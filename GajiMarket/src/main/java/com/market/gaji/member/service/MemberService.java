package com.market.gaji.member.service;

import java.util.List;

import com.market.gaji.board.domain.Criteria;
import com.market.gaji.member.domain.MemberVO;

public interface MemberService {
	
	// 회원가입
	public void registerMember(MemberVO member);
	
	// 한명의 회원조회 - 이메일
	public MemberVO getMember(String email);
	
	// 한명의 회원조회 - 별명
	public MemberVO getNicknameMember(String nickname);
	
	// 한명의 회원조회 - 핸드폰 번호
	public MemberVO getPhoneMember(String phone);
	
	// 한명의 회원조회 - membernum으로
	public MemberVO getMemberNumMember(int membernum);
	
	// 회원탈퇴
	public void deleteMember(String email, String password);
	
	// 회원정보 수정 - 주소, 핸드폰 번호 변경
	public void modifyMember(MemberVO member);
	
	// 회원정보 수정 - 비밀번호 변경	
	public void modifyPwMember(MemberVO member);
	
	// 전체 회원 조회 - 관리자
	public List<MemberVO> getListMember(Criteria cri);
	
	// 전체 회원 수 - 관리자
	public int getCountAllMember(Criteria cri);
	
	// 여기부터 관리자
	// 회원 강제 탈퇴 기능 - 관리자
	public void removeMember(int membernum);
	
	// 회원 <-> 관리자 수정
	public void changeAdminOrMember(int isadmin, int membernum);
	


}
