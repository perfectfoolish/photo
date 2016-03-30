package photo.baby.repository;


import org.springframework.data.repository.PagingAndSortingRepository;
import photo.baby.bean.Prompt;

public interface PromptRepository extends PagingAndSortingRepository<Prompt, Integer> {


}
