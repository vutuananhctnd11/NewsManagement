package com.laptrinhjavaweb.dto;

public class CategoryDTO extends AbstractDTO<CategoryDTO> {
	
	private String name;
	private String code;
	private int totalNews;
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getTotalNews() {
		return totalNews;
	}
	public void setTotalNews(int totalNews) {
		this.totalNews = totalNews;
	}
	
	

}
