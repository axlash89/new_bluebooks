package com.bluebooks.order.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.EnumSet;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;
import org.apache.ibatis.type.TypeHandler;

import com.bluebooks.common.enums.PayBy;


@MappedTypes(PayBy.class)
public class PayByTypeHandler<E extends Enum<E> & ValueEnum> implements TypeHandler<ValueEnum> {
	
	
	private Class<E> type;
	
	public PayByTypeHandler(Class<E> type) {
        this.type = type;
    }
	
	@Override
	public void setParameter(PreparedStatement ps, int i, ValueEnum parameter, JdbcType jdbcType) throws SQLException {
		ps.setString(i, parameter.getValue());
	}
	
	@Override
	public ValueEnum getResult(ResultSet rs, String columnName) throws SQLException {
		return getValueEnum(rs.getString(columnName));

	}
	
	@Override
	public ValueEnum getResult(ResultSet rs, int columnIndex) throws SQLException {
		return getValueEnum(rs.getString(columnIndex));
	}
	
	@Override
	public ValueEnum getResult(CallableStatement cs, int columnIndex) throws SQLException {
		return getValueEnum(cs.getString(columnIndex));
	}
	
	private ValueEnum getValueEnum(String value) {
		return EnumSet.allOf(type)
                .stream()
                .filter(code -> code.getValue().equals(value))
                .findFirst()
                .orElseGet(null);
		
		
	}

	

	
}
