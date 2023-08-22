package com.bluebooks.order.converter;

public interface AttributeConverter<X, Y> {

	public Y convertToDatabaseColumn (X attribute); // entity attribute -> DB 값    
	public X convertToEntityAttribute (Y dbData); // DB 값 -> entity attribute
	
}

