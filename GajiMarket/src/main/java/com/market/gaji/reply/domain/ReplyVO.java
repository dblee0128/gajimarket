package com.market.gaji.reply.domain;

import java.sql.Date;

import com.market.gaji.member.domain.MemberVO;

public class ReplyVO {
	
	private int replynum;
	private String reply;
	private Date regdate;
	private int boardnum;
	private int membernum;
	
	private MemberVO member;
	
	public int getReplynum() {
		return replynum;
	}
	public void setReplynum(int replynum) {
		this.replynum = replynum;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getBoardnum() {
		return boardnum;
	}
	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
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
		return "ReplyVO [replynum=" + replynum + ", reply=" + reply + ", regdate=" + regdate + ", boardnum=" + boardnum
				+ ", membernum=" + membernum + ", member=" + member + "]";
	}

}
