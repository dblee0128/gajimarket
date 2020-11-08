package com.market.gaji.board.domain;

import java.sql.Date;
import java.util.List;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import com.market.gaji.member.domain.MemberVO;

public class BoardVO {
	
	private int boardnum;
	
	@NotEmpty(message = "제목을 입력해주세요.")
	@Size(min=1, max=15, message="1-15자 이내로 입력해주세요.")
	private String title;
	
	@NotEmpty(message = "가격을 입력해주세요.")
	@Size(min=1, max=8, message="9999만원 이내로 입력해주세요.")
	private String price;
	
	@NotEmpty(message = "내용을 입력해주세요.")
	@Size(min=1, max=5000, message="500자 이내로 입력해주세요.")
	private String content;

	private String sell;
	
	private int readcnt;
	private Date regdate;
	private int categorynum;
	private int membernum;
	private int replycnt; // 댓글 조회수 추가
	private int likecnt; // 관심 개수 추가
	
	private MemberVO member;
	private CategoryVO category;
	private List<ImgVO> imgList;
	
	public int getBoardnum() {
		return boardnum;
	}
	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSell() {
		return sell;
	}
	public void setSell(String sell) {
		this.sell = sell;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getCategorynum() {
		return categorynum;
	}
	public void setCategorynum(int categorynum) {
		this.categorynum = categorynum;
	}
	public int getMembernum() {
		return membernum;
	}
	public void setMembernum(int membernum) {
		this.membernum = membernum;
	}
	public MemberVO getMember() {
		return member;
	}
	public void setMember(MemberVO member) {
		this.member = member;
	}
	public int getReplycnt() {
		return replycnt;
	}
	public void setReplycnt(int replycnt) {
		this.replycnt = replycnt;
	}
	public CategoryVO getCategory() {
		return category;
	}
	public void setCategory(CategoryVO category) {
		this.category = category;
	}
	public List<ImgVO> getImgList() {
		return imgList;
	}
	public void setImgList(List<ImgVO> imgList) {
		this.imgList = imgList;
	}
	public int getLikecnt() {
		return likecnt;
	}
	public void setLikecnt(int likecnt) {
		this.likecnt = likecnt;
	}
	@Override
	public String toString() {
		return "BoardVO [boardnum=" + boardnum + ", title=" + title + ", price=" + price + ", content=" + content
				+ ", sell=" + sell + ", readcnt=" + readcnt + ", regdate=" + regdate + ", categorynum=" + categorynum
				+ ", membernum=" + membernum + ", replycnt=" + replycnt + ", likecnt=" + likecnt + ", member=" + member
				+ ", category=" + category + ", imgList=" + imgList + "]";
	}
	
}
