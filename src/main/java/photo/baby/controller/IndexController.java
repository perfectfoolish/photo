package photo.baby.controller;

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
import photo.baby.service.PhotoService;

import java.io.File;
import java.io.IOException;

/**
 * Created by apple on 16/3/25.
 */
@Controller
@RequestMapping(value = "/")
public class IndexController {

    @Autowired
    private PhotoService photoService;

    @RequestMapping("/")
    public String index(Model model) throws IOException {
        model.addAttribute("photos" , photoService.latestPhotos());
        return "index";
    }


}
