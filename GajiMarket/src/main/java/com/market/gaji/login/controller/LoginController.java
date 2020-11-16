package com.market.gaji.login.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.market.gaji.login.domain.LoginCommand;
import com.market.gaji.member.domain.MemberVO;
import com.market.gaji.member.service.MemberService;

@Controller
public class LoginController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder pwEncoder; // 비밀번호 암호화

	// 세션으로 로그인, 로그아웃 구분
	@RequestMapping(value="/") // 메인으로 들어왔을 때
	public String login(HttpSession session, Model model) {
		String email = (String)session.getAttribute("email"); // 세션에 저장된 email 가져오기
		
		if(email != null) { // 세션이 있으면 = 로그인 상태
			return "redirect:/board"; // 게시판 전체 목록으로
		}
		model.addAttribute("loginCmd", new LoginCommand());
		return "login/login"; // 세션이 없으면 로그인 페이지로
	}
	
	// 로그인
	@RequestMapping(value="/", method=RequestMethod.POST)
	public String login(@ModelAttribute("loginCmd") @Valid LoginCommand loginCmd, 
						BindingResult bindingResult, HttpSession session, Model model) { 
		
		if(bindingResult.hasErrors()) { // 유효성 검사에 에러가 발생할 경우
			return "login/login";
		}
		
		MemberVO member = memberService.getMember(loginCmd.getEmail()); // 로그인에서 얻은 회원 정보
		
		if(member == null) {
			model.addAttribute("msg", "존재하지 않는 회원입니다.");
			return "login/login";
		}
		
		boolean pwMatch = pwEncoder.matches(loginCmd.getPassword(), member.getPassword()); // (실제 비번, 디비에 있는 암호화된 비번)
		
		if(member != null && pwMatch == true) {
			session.setAttribute("email", member.getEmail());
			session.setAttribute("nickname", member.getNickname());
			session.setAttribute("membernum", member.getMembernum());
			session.setAttribute("addressnum", member.getAddressnum());
			session.setAttribute("isadmin", member.getIsadmin());
			session.setAttribute("member", member);
			return "redirect:/board";
		} else if(member != null && pwMatch == false){
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "login/login"; // 로그인 페이지로 이동
		} 
		return "redirect:/";
	}
	
	// 로그아웃
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session, Model model) {
		session.invalidate();
		return "redirect:/"; // 맨 위에 있는 메서드 실행 -> 세션이 있는지 판단 후 -> 페이지 이동
	}
	
	
}
