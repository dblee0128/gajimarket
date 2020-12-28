package com.market.gaji.board.domain;

import com.market.gaji.member.domain.MemberVO;

public class LikeVO {
	
	private int boardnum;
	private int membernum;
	
	// 나의 게시물 조회를 위해 board, member 추가
	private BoardVO board;
	private MemberVO member;
	
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
	public BoardVO getBoard() {
		return board;
	}
	public void setBoard(BoardVO board) {
		this.board = board;
	}
	public MemberVO getMember() {
		return member;
	}
	public void setMember(MemberVO member) {
		this.member = member;
	}
	@Override
	public String toString() {
		return "LikeVO [boardnum=" + boardnum + ", membernum=" + membernum + ", board=" + board + ", member=" + member
				+ "]";
	}

}
