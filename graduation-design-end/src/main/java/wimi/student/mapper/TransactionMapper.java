package wimi.student.mapper;

import org.apache.ibatis.annotations.Param;
import wimi.student.entity.Transaction;
import wimi.student.util.MyMapper;

import java.util.Date;
import java.util.List;

public interface TransactionMapper extends MyMapper<Transaction> {
    List<Transaction> listTransaction(@Param("type") String type, @Param("beginTime") Date beginTime,
                                      @Param("endTime") Date endTime, @Param("accountid") String accountid,
                                      @Param("otherid") String otherid);
}
