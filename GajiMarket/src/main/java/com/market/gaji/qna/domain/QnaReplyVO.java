package com.market.gaji.qna.domain;

import java.sql.Date;

import com.market.gaji.member.domain.MemberVO;

public class QnaReplyVO {
	
	private int qnareplynum;
	private String qnareply;
	private Date regdate;
	private int qnanum;
	private int membernum;
	
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
