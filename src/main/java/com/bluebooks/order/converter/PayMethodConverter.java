package com.bluebooks.order.converter;

import javax.persistence.Converter;

import com.bluebooks.common.PayMethod;

@Converter
public class PayMethodConverter implements AttributeConverter<PayMethod, String> {


	@Override
	public String convertToDatabaseColumn(PayMethod payMethod) { return payMethod.name(); }
    
	@Override
	public PayMethod convertToEntityAttribute(String name) {
		if(name == null) { return null; }
		return PayMethod.valueOf(name);
	}
	
}
