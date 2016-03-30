package photo.baby.repository;


import org.springframework.data.repository.PagingAndSortingRepository;
import photo.baby.bean.Photo;

public interface PhotoRepository extends PagingAndSortingRepository<Photo, Integer> {

}
