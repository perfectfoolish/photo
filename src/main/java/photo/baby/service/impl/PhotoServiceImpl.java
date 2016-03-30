package photo.baby.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import photo.baby.bean.Photo;
import photo.baby.entity.Progress;
import photo.baby.repository.PhotoRepository;
import photo.baby.service.AlbumService;
import photo.baby.service.PhotoService;

import java.io.*;
import java.util.Date;
import java.util.List;

/**
 * Created by apple on 16/3/29.
 */

@Service
public class PhotoServiceImpl implements PhotoService, AlbumService {

    @Autowired
    private PhotoRepository photoRepository;

    private String path = "/Users/apple/test";

    @Override
    public Photo save(MultipartFile multipartFile, String name) throws IOException {
        multipartFile.transferTo(new File(path, name));
        Photo photo = new Photo();
        photo.setName(name);
        photo.setCreatedAt(new Date());
        return photoRepository.save(photo);
    }

    @Override
    public List<Photo> latestPhotos() {
        return null;
    }

}
