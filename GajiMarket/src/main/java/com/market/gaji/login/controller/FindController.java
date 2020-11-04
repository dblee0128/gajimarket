package com.market.gaji.login.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.market.gaji.member.domain.MemberVO;
import com.market.gaji.member.service.MemberService;

@Controller
public class FindController {
	
	@Autowired
	private MemberService memberService;
	
	// 아이디 찾기
	@RequestMapping(value="/findEmail")
	public String findEmailMember() {
		return "login/findEmail";
	}
	
	@RequestMapping(value="/findEmail", method=RequestMethod.POST)
	public String findEmailMember(String phone, Model model) {
		MemberVO member = memberService.getPhoneMember(phone);
		
		if(member.getPhone() == null) {
			model.addAttribute("msg1", "일치하는 회원 정보가 없습니다.");
			return "login/findEmail";
		}
		model.addAttribute("msg2", "가입하신 이메일: ");
		model.addAttribute("email", member.getEmail());
		return "login/findEmail";
	}
	

	// 비밀번호 찾기
	@RequestMapping(value="/findPw")
	public String findPwMember() {
		return "login/findPw";
	}
	
	@RequestMapping(value="/findPw", method=RequestMethod.POST)
	public String findPwMember(String email, Model model) {
		MemberVO check = memberService.getMember(email);
		
		if(check == null) {
			model.addAttribute("msg1", "일치하는 회원 정보가 없습니다.");
			return "login/findPw";
		} 
		model.addAttribute("msg2", "이메일이 발송되었습니다. 확인해주세요.");
		return "login/findPw";
	}
	

}
