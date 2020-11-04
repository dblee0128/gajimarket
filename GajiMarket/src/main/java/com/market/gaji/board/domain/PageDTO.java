package com.market.gaji.board.domain;

public class PageDTO {
	
	// 화면 처리시 필요한 변수들
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total; // 전체 데이터 수
	private Criteria cri; // 한 페이지에서 보여주는 데이터 수, 현재 페이지 번호(amount, pageNum)
	
	public int getStartPage() {
		return startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public boolean isNext() {
		return next;
	}
	public int getTotal() {
		return total;
	}
	public Criteria getCri() {
		return cri;
	}
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
	
	@Override
	public String toString() {
		return "PageDTO [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", total=" + total + ", cri=" + cri + "]";
	}
	
}
