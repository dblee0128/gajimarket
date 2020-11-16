package com.market.gaji.member.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.market.gaji.member.domain.MemberVO;
import com.market.gaji.member.domain.RegisterCommand;
import com.market.gaji.member.service.MemberService;

@Controller
@RequestMapping("/member")
public class RegisterController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder pwEncoder; // 비밀번호 암호화
	
	// 회원가입
	@RequestMapping(value="/register")
	public String registerMember(Model model) {
		model.addAttribute("registerCmd", new RegisterCommand());
		return "member/register";
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registerMember(@ModelAttribute("registerCmd") @Valid RegisterCommand registerCmd,
								 BindingResult bindingResult, MemberVO member, Model model) {	
		
		MemberVO check = memberService.getMember(registerCmd.getEmail());
		MemberVO check2 = memberService.getNicknameMember(registerCmd.getNickname());
		MemberVO check3 = memberService.getPhoneMember(registerCmd.getPhone());
		
		// 유효성 검사에 에러가 발생할 경우
		if(bindingResult.hasErrors()) {
			// + 주소 검증은 따로 추가
			if(registerCmd.getAddressnum() == 0) {
				model.addAttribute("msg5", "주소를 선택해주세요.");
				return "member/register"; 
			}
			return "member/register"; 
		} else if(!(check == null)){ // 이메일 중복
			model.addAttribute("msg1", "이미 존재하는 이메일입니다.");
			return "member/register";
		} else if(!(registerCmd.getConfirmPassword().equals(registerCmd.getPassword()))) { // 비밀번호 불일치
			model.addAttribute("msg2", "변경할 비밀번호가 일치하지 않습니다.");
			return "member/register";
		} else if(!(check2 == null)) { // 별명 중복
			model.addAttribute("msg3", "이미 존재하는 별명입니다.");
			return "member/register";
		} else if(!(check3 == null)) { // 핸드폰 번호 중복
			model.addAttribute("msg4", "이미 존재하는 핸드폰 번호입니다.");
			return "member/register";
		} else if(registerCmd.getAddressnum() == 0) { // 주소 없음
			model.addAttribute("msg5", "주소를 선택해주세요.");
			return "member/register"; 
		}
			
		// 모든 조건이 만족할 경우
		member.setEmail(registerCmd.getEmail());
		
		String password = registerCmd.getPassword(); // 기존 비밀번호
		String encryPassword = pwEncoder.encode(password); // 암호화된 비밀번호
		member.setPassword(encryPassword); // 암호화한 비밀번호로 저장될 수 있게 변경
		//member.setPassword(registerCmd.getPassword());
		
		member.setNickname(registerCmd.getNickname());
		member.setPhone(registerCmd.getPhone());
		member.setAddressnum(registerCmd.getAddressnum());
		memberService.registerMember(member); // 가입
		return "redirect:/";

	}
	
}
