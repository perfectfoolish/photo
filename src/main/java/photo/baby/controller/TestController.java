package photo.baby.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import photo.baby.bean.PhotoAttr;
import photo.baby.bean.User;
import photo.baby.repository.PhotoAttrRepository;
import photo.baby.repository.UserRepository;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by apple on 16/3/25.
 */
@Controller
@RequestMapping(value = "test")
public class TestController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PhotoAttrRepository photoAttrRepository;

    @RequestMapping(value = "list", method = {RequestMethod.GET}, produces = "application/json;charset=utf-8")
    public String list(HttpServletRequest req, Model model) {

        PhotoAttr pa = new PhotoAttr();
        pa.setKey("时间");
        pa.setValue("哈哈");

        photoAttrRepository.save(pa);

        List<PhotoAttr> photoAttrs = photoAttrRepository.findAll();

        model.addAttribute("pas", photoAttrs);

        User user = new User();
        user.setUsername("test");
        user.setPassword("fdfd");
        userRepository.save(user);

        return "test";
    }

}
