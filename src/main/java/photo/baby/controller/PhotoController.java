package photo.baby.controller;

import org.apache.commons.fileupload.ProgressListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import photo.baby.bean.Photo;
import photo.baby.entity.Progress;
import photo.baby.ext.PhotoMultipartResolver;
import photo.baby.service.PhotoService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
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

    @RequestMapping(value = "upload", method = {RequestMethod.GET}, produces = "text/html;charset=utf-8")
    public String upload(HttpSession session, Model model) {
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
                attr.addFlashAttribute("error", "上传失败");
            }

            session.removeAttribute(key);
        } else {
            attr.addFlashAttribute("error", "没有发现文件");
        }

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

}
