package com.market.gaji.qna.domain;

import java.sql.Date;

import com.market.gaji.member.domain.MemberVO;

public class QnaVO {
	
	private int qnanum;
	private String title;
	private String content;
	private Date regdate;
	private int typenum;
	private int membernum;
	
	private QnaTypeVO type;
	private MemberVO member;
	
	public int getQnanum() {
		return qnanum;
	}
	public void setQnanum(int qnanum) {
		this.qnanum = qnanum;
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
	public int getTypenum() {
		return typenum;
	}
	public void setTypenum(int typenum) {
		this.typenum = typenum;
	}
	public int getMembernum() {
		return membernum;
	}
	public void setMembernum(int membernum) {
		this.membernum = membernum;
	}
	public QnaTypeVO getType() {
		return type;
	}
	public void setType(QnaTypeVO type) {
		this.type = type;
	}
	public MemberVO getMember() {
		return member;
	}
	public void setMember(MemberVO member) {
		this.member = member;
	}
	@Override
	public String toString() {
		return "QnaVO [qnanum=" + qnanum + ", title=" + title + ", content=" + content + ", regdate=" + regdate
				+ ", typenum=" + typenum + ", membernum=" + membernum + ", type=" + type + ", member=" + member + "]";
	}

}
