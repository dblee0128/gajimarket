package com.market.gaji.qna.domain;

import java.util.Date;

import com.market.gaji.member.domain.MemberVO;

public class QnaReplyVO {
	
	private int qnareplynum; // 댓글번호
	private String qnareply; // 댓글내용
	private Date regdate; // 작성일자
	
	private int qnanum; // 문의글번호
	private int membernum; // 회원번호
	
	private MemberVO member;

	public int getQnareplynum() {
		return qnareplynum;
	}

	public void setQnareplynum(int qnareplynum) {
		this.qnareplynum = qnareplynum;
	}

	public String getQnareply() {
		return qnareply;
	}

	public void setQnareply(String qnareply) {
		this.qnareply = qnareply;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public int getQnanum() {
		return qnanum;
	}

	public void setQnanum(int qnanum) {
		this.qnanum = qnanum;
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

	@Override
	public String toString() {
		return "QnaReplyVO [qnareplynum=" + qnareplynum + ", qnareply=" + qnareply + ", regdate=" + regdate
				+ ", qnanum=" + qnanum + ", membernum=" + membernum + ", member=" + member + "]";
	}	

}
