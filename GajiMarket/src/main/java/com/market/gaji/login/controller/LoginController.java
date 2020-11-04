package com.market.gaji.login.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
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
		
		MemberVO check = memberService.getMember(loginCmd.getEmail()); // check 변수에 해당 이메일의 정보 저장
		
		if(check != null) { // 정보가 있다면 = 이메일 존재
			// 비밀번호까지 일치한다면
			System.out.println("come session?");
			if(loginCmd.getPassword().equals(check.getPassword())) { // 사용자가 입력한 비밀번호와 DB에 저장된 비밀번호가 일치한다면 = 로그인 성공
				// 로그인에 성공했을 때, 세션 발급해주기
				session.setAttribute("email", check.getEmail());
				session.setAttribute("nickname", check.getNickname());
				session.setAttribute("membernum", check.getMembernum());
				session.setAttribute("addressnum", check.getAddressnum());
				session.setAttribute("member", check);
				
				// 정보를 뷰로 뿌려주기
				//model.addAttribute("email", check.getEmail());
				//model.addAttribute("nickname", check.getNickname());
				//model.addAttribute("membernum", check.getMembernum());
				return "redirect:/board";
			} else { // 이메일은 존재하나, 비밀번호가 일치하지 않는다면
				model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
				return "login/login"; // 로그인 페이지로 이동
			}
		} else { // 이메일 정보가 존재하지 않는다면
			model.addAttribute("msg", "존재하지 않는 회원입니다.");
			return "login/login";
		}
	}
	
	// 로그아웃
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session, Model model) {
		session.invalidate();
		return "redirect:/"; // 맨 위에 있는 메서드 실행 -> 세션이 있는지 판단 후 -> 페이지 이동
	}
	
	
}
