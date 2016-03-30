package photo.baby.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import photo.baby.bean.PhotoAttribute;

/**
 * Created by apple on 16/3/25.
 */
@Repository
public interface PhotoAttrRepository extends MongoRepository<PhotoAttribute, Integer> {


}
