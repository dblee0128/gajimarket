package com.market.gaji.member.mapper;

import org.apache.ibatis.annotations.Param;

import com.market.gaji.member.domain.MemberVO;

public interface MemberMapper {
	
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
	public void deleteMember(@Param("email") String email, 
							 @Param("password") String password); // @Param 쓰는 이유: 다수의 파라미터를 넘겨줄 때 필요
	
	// 회원정보 수정 - 주소, 핸드폰 번호 변경
	public void modifyMember(MemberVO member);
	
	// 회원정보 수정 - 비밀번호 변경
	public void modifyPwMember(MemberVO member);
	
	
}
