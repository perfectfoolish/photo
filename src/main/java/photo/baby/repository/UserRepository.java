package photo.baby.repository;


import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;
import photo.baby.bean.User;

@Repository
public interface UserRepository extends PagingAndSortingRepository<User, Integer> {

}
