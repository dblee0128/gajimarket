package com.market.gaji.board.domain;

public class CategoryVO {
	
	private int categorynum;
	private String categoryname;
	
	public int getCategorynum() {
		return categorynum;
	}
	public void setCategorynum(int categorynum) {
		this.categorynum = categorynum;
	}
	public String getCategoryname() {
		return categoryname;
	}
	public void setCategoryname(String categoryname) {
		this.categoryname = categoryname;
	}
	@Override
	public String toString() {
		return "CategoryVO [categorynum=" + categorynum + ", categoryname=" + categoryname + "]";
	}

}
