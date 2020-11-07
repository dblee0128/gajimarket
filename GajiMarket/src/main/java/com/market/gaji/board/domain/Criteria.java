package com.market.gaji.board.domain;

import org.springframework.web.util.UriComponentsBuilder;

public class Criteria {
	
	private int pageNum; // 페이지 번호
	private int amount; // 한 페이지당 몇 개의 데이터
	
	// 검색 처리를 위한 변수
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,10); // 1 페이지당 10개의 데이터
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	// 검색 조건을 배열로 만들어 한 번에 처리
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
	}
	
	// 파라미터 전송에 사용되는 문자열 처리
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
		.queryParam("pageNum", this.pageNum)
		.queryParam("amount", this.getAmount())
		.queryParam("type", this.getType())
		.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
	
	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", type=" + type + ", keyword=" + keyword + "]";
	}

}
