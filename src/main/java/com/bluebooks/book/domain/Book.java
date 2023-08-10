package com.bluebooks.book.domain;

import java.time.ZonedDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
public class Book {
	
	private int id;
	private String isbn13;
	private String categoryName;
	private String title;
	private String author;
	private String publisher;
	private String pubDate;
	private String description;
	private int priceStandard;
	private int priceSales;
	private int mileage;
	private String cover;
	private ZonedDateTime createdAt;
	private ZonedDateTime updatedAt;
	
}
