package com.bluebooks.common.enums;

import org.apache.ibatis.type.MappedTypes;

import com.bluebooks.order.typehandler.PayByTypeHandler;
import com.bluebooks.order.typehandler.ValueEnum;

public enum PayBy implements ValueEnum {

CARD("신용카드"), POINT("카카오페이");
	
	private String value;
	
	private PayBy(String value) {
		this.value = value;
	}
	
	@MappedTypes(PayBy.class)
    public static class TypeHandler extends PayByTypeHandler<PayBy> {
        public TypeHandler() {

            super(PayBy.class);
            
        }
    }
	
	@Override
	public String getValue() {
		return value;
	}
	
}
