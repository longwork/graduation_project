package wimi.student.mapper;

import org.apache.ibatis.annotations.Param;
import wimi.student.entity.Person;
import wimi.student.entity.PersonVO;
import wimi.student.util.MyMapper;

import java.util.List;

/**
 * @author Administrator
 */
public interface PersoninfoMapper extends MyMapper<Person> {

    List<PersonVO> getAllPerson(@Param("rows") int rows, @Param("page") int page);

    int countAllPerson(@Param("status") String status);

    List<PersonVO> getPerson(@Param("rows") int rows,@Param("page") int page,@Param("status") String status );

    List<PersonVO> getPersonList();
}
