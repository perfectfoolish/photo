package photo.baby.controller;

import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import photo.baby.bean.Photo;
import photo.baby.bean.Prompt;
import photo.baby.entity.Progress;
import photo.baby.ext.PhotoMultipartResolver;
import photo.baby.service.PhotoService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Created by apple on 16/3/25.
 */
@Controller
@RequestMapping(value = "photo")
public class PhotoController {

    private static final AtomicInteger sequenceGenerator = new AtomicInteger();
    private static final Random random = new Random();

    @Autowired
    private PhotoService photoService;

    @RequestMapping("{name:.*}")
    public ResponseEntity<byte[]> download(@PathVariable String name) throws IOException {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", name);

        File image = photoService.file(name);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(image), headers, HttpStatus.OK);
    }

    @RequestMapping(value = "upload", method = {RequestMethod.GET}, produces = "text/html;charset=utf-8")
    public String upload(Model model) {
        String key = sequenceGenerator.getAndIncrement() + "_" + random.nextInt(Integer.MAX_VALUE);
        model.addAttribute("key", key);
        return "upload";
    }

    @RequestMapping(value = "do_upload/{key}", method = {RequestMethod.POST})
    public String do_upload(HttpSession session,
                            HttpServletRequest req,
                            @PathVariable String key,
                            RedirectAttributes attr) {

        Progress p = (Progress) session.getAttribute(key);
        if (p == null) {
            p = new Progress();
            session.setAttribute(key, p);
        }
        final Progress p2 = p;

        PhotoMultipartResolver resolver = new PhotoMultipartResolver(
                new ProgressListener() {
                    public void update(long pBytesRead, long pContentLength, int pItems) {
                        p2.setStatus(1);
                        p2.setMax(pContentLength);
                        p2.setNow(pBytesRead);
                    }
                });

        if (resolver.isMultipart(req)) {
            MultipartHttpServletRequest multipartRequest = resolver.resolveMultipart(req);
            p2.setStatus(2);
            MultipartFile image = multipartRequest.getFile("image");

            if (!image.isEmpty()) {
                String contentType = image.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    Date now = new Date();
                    String imageFilename = image.getOriginalFilename();
                    imageFilename = now.getTime() + imageFilename;
                    try {
                        Photo photo = photoService.save(image, imageFilename);
                        p2.setSave(image.getSize());
                        p2.setStatus(3);
                        attr.addFlashAttribute("flash", "上传成功");
                    } catch (IOException e) {
                        e.printStackTrace();
                        p2.setStatus(-1);
                        attr.addFlashAttribute("error", "上传失败");
                    }
                } else {
                    p2.setStatus(-1);
                    attr.addFlashAttribute("error", "文件不是图片");
                }
            } else {
                p2.setStatus(-1);
                attr.addFlashAttribute("error", "没有发现文件");
            }
        } else {
            p2.setStatus(-1);
            attr.addFlashAttribute("error", "没有发现文件");
        }

        session.removeAttribute(key);

        return "redirect:/photo/upload";
    }

    @RequestMapping(value = "upload_progress", produces = "application/json;charset=utf-8")
    @ResponseBody
    public Progress upload_progress(HttpSession session, String key) {
        Progress p = (Progress) session.getAttribute(key);
        if (p == null) {
            p = new Progress();
        }
        return p;
    }

    @RequestMapping(value = "prompt", method = {RequestMethod.POST}, produces = "application/json;charset=utf-8")
    @ResponseBody
    public Prompt prompt(int photo_id, int x, int y, String text) {
        Prompt p = new Prompt();
        p.setCreatedAt(new Date());
        p.setPhotoId(photo_id);
        p.setText(text);
        p.setX(x);
        p.setY(y);
        p = photoService.save(p);
        return p;
    }

}
