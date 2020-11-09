package com.market.gaji.notice.domain;

import java.sql.Date;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class NoticeVO {
	
	private int noticenum;
	
	@NotEmpty(message = "제목을 입력해주세요.")
	@Size(min=1, max=25, message="1-25자 이내로 입력해주세요.")
	private String title;
	
	@NotEmpty(message = "내용을 입력해주세요.")
	@Size(min=1, max=2000, message="1000자 이내로 입력해주세요.")
	private String content;
	private Date regdate;
	private int membernum;
	
	public int getNoticenum() {
		return noticenum;
	}
	public void setNoticenum(int noticenum) {
		this.noticenum = noticenum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getMembernum() {
		return membernum;
	}
	public void setMembernum(int membernum) {
		this.membernum = membernum;
	}
	
	@Override
	public String toString() {
		return "NoticeVO [noticenum=" + noticenum + ", title=" + title + ", content=" + content + ", regdate=" + regdate
				+ ", membernum=" + membernum + "]";
	}
	
}
