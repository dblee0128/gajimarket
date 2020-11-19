package com.market.gaji.login.controller;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
	
	@Autowired
	protected JavaMailSender javaMailSender;
	
	@Autowired
	BCryptPasswordEncoder pwEncoder; // 비밀번호 암호화
	
	
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
		model.addAttribute("msg2", "가입하신 이메일은 ");
		model.addAttribute("email", member.getEmail());
		model.addAttribute("msg3", " 입니다.");
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
		
		MimeMessage msg = javaMailSender.createMimeMessage();
		
		// 임시 비밀번호: 난수 만들기
		String tempPw = "";
		for(int i = 0; i < 12; i++) {
			tempPw += (char)((Math.random() * 26) + 97);
		}
		
		check.setPassword(pwEncoder.encode(tempPw)); // 암호화된 임시 비밀번호 셋팅
		memberService.modifyPwMember(check); // 암호화된 임시 비밀번호로 변경
		
		try { // 셋팅해주기
			msg.setSubject("가지마켓 임시 비밀번호 발급 메일입니다.");
			msg.setText("회원님의 임시 비밀번호는 " + tempPw + " 입니다. 보안을 위해 임시 비밀번호 로그인 후, 비밀번호를 변경해주세요.");
			msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(email));
			javaMailSender.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("msg2", "이메일이 발송되었습니다. 확인해주세요.");
		return "login/findPw";
	}	

}
