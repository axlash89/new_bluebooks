package com.bluebooks.book.domain;

import java.time.ZonedDateTime;

import lombok.Data;


@Data
public class Book {
	
	private int id;
	private String isbn13;
	private String categoryName;
	private String title;
	private String author;
	private String publisher;
	private String pubDate;
	private String description;
	private long priceStandard;
	private long priceSales;
	private long point;
	private String cover;
	private ZonedDateTime createdAt;
	private ZonedDateTime updatedAt;
	
}
