package photo.baby.service;

import org.springframework.web.multipart.MultipartFile;
import photo.baby.bean.Photo;

import java.io.IOException;
import java.util.List;

public interface PhotoService {

    public Photo save(MultipartFile multipartFile, String name) throws IOException;

    public List<Photo> latestPhotos();

}
