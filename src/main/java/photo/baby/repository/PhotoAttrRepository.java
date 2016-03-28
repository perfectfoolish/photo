package photo.baby.repository;

import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Repository;
import photo.baby.bean.PhotoAttr;

import java.util.List;

/**
 * Created by apple on 16/3/25.
 */
@Repository
public interface PhotoAttrRepository extends MongoRepository<PhotoAttr, Integer> {


}
