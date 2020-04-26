package wimi.student.util;

import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.MySqlMapper;

/**
 * 继承自己的MyMapper
 *
 * @author Administrator
 */
public interface MyMapper<T> extends Mapper<T>, MySqlMapper<T> {

}
