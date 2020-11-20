package com.market.gaji.qna.domain;


import java.util.Date;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import com.market.gaji.member.domain.MemberVO;

public class QnaVO {
	
	private int qnanum;
	
	@NotEmpty(message = "제목을 입력해주세요.")
	@Size(min=1, max=50, message="1-50자 이내로 입력해주세요.")
	private String title;
	
	@NotEmpty(message = "내용을 입력해주세요.")
	@Size(min=1, max=500, message="500자 이내로 입력해주세요.")
	private String content;
	
	private Date regdate;
	private int typenum;
	private int membernum;
	
	private int replycnt;
	
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
	public int getReplycnt() {
		return replycnt;
	}
	public void setReplycnt(int replycnt) {
		this.replycnt = replycnt;
	}
	@Override
	public String toString() {
		return "QnaVO [qnanum=" + qnanum + ", title=" + title + ", content=" + content + ", regdate=" + regdate
				+ ", typenum=" + typenum + ", membernum=" + membernum + ", replycnt=" + replycnt + ", type=" + type
				+ ", member=" + member + "]";
	}

}
