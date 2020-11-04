package com.market.gaji.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.gaji.member.domain.MemberVO;
import com.market.gaji.member.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public void registerMember(MemberVO member) {
		memberMapper.registerMember(member);
	}

	@Override
	public MemberVO getMember(String email) {
		return memberMapper.getMember(email);
	}
	
	@Override
	public MemberVO getNicknameMember(String nickname) {
		return memberMapper.getNicknameMember(nickname);
	}
	
	@Override
	public MemberVO getPhoneMember(String phone) {
		return memberMapper.getPhoneMember(phone);
	}
	
	@Override
	public void deleteMember(String email, String password) {
		memberMapper.deleteMember(email, password);
	}

	@Override
	public void modifyMember(MemberVO member) {
		memberMapper.modifyMember(member);
	}

	@Override
	public void modifyPwMember(MemberVO member) {
		memberMapper.modifyPwMember(member);	
	}

	@Override
	public MemberVO getMemberNumMember(int membernum) {
		return memberMapper.getMemberNumMember(membernum);
	}






}
