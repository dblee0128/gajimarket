package com.market.gaji.myinfo.controller;

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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.market.gaji.board.service.BoardLikeService;
import com.market.gaji.board.service.BoardService;
import com.market.gaji.member.domain.ChangePwCommand;
import com.market.gaji.member.domain.MemberVO;
import com.market.gaji.member.service.MemberService;
import com.market.gaji.qna.service.QnaService;

@Controller
@SessionAttributes("member")
@RequestMapping("/myInfo")
public class MyInfoMemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private BoardLikeService likeService;
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	BCryptPasswordEncoder pwEncoder; // 비밀번호 암호화
	
	// 내 정보 메인 페이지로 이동
	@RequestMapping
	public String myInfo(HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) {
			return "redirect:/";
		}
		
		int membernum = (int)session.getAttribute("membernum");
		
		// 2. 메인 페이지에 정보 뿌려주기
		model.addAttribute("onSaleCnt", boardService.getOnSaleCountMyBoard(membernum));
		model.addAttribute("salesComplCnt", boardService.getSalesCompletedCountMyBoard(membernum));
		model.addAttribute("likeCnt", likeService.getCountMyBoardLike(membernum));
		model.addAttribute("qnaCnt", qnaService.getCountMyQna(membernum));
		
		
		return "/myInfo/myInfo";
	}
	
	// 회원 정보 조회
	@RequestMapping(value="/member/get")
	public String getDetailMyInfo(HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) {
			return "redirect:/";
		}
		
		MemberVO member = memberService.getMember((String)session.getAttribute("email")); // 세션을 이용해서 값 가져오기
		model.addAttribute("member", member);
		return "/myInfo/member/get";
	}
	
	// 회원 탈퇴
	@RequestMapping(value="/member/delete")
	public String deleteMember(HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) {
			return "redirect:/";
		}
		
		String email = (String)session.getAttribute("email");
		String nickname = (String)session.getAttribute("nickname");
		model.addAttribute("email", email);
		model.addAttribute("nickname", nickname);
		return "/myInfo/member/delete";
	}
	
	@RequestMapping(value="/member/delete", method=RequestMethod.POST)
	public String deleteMember(String email, String password, HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) {
			return "redirect:/";
		}
		
		MemberVO member = memberService.getMember(email); // 입력한 정보를 가져오기 (email은 hidden으로 넘겨줄거야)
		System.out.println("member: " + member);
	
		boolean pwMatch = pwEncoder.matches(password, member.getPassword());
		
		if(pwMatch == true) { // 비밀번호가 일치하면
			memberService.removeMember(member.getMembernum());
			memberService.deleteMember(email, password); // 삭제 진행
			session.invalidate(); // 세션도 끊어주기
			return "redirect:/";
		} else { // 비밀번호가 일치하지 않으면
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "/myInfo/member/delete";
		}
	
	}
	
	// 회원 정보 수정 - 주소, 핸드폰 번호 수정
	@RequestMapping(value="/member/modify")
	public String modifyMember(HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) {
			return "redirect:/";
		}
		
		// 세션에 저장된 email 값을 가져오기 = 가져올 수 있다는 것은 로그인이 되어있다는 것 = 즉, 수정이 자유로운 상태
		String email = (String)session.getAttribute("email");
		MemberVO member = memberService.getMember(email); // 멤버 정보 가져오기
		model.addAttribute("member", member); // 이 단계에서 @SessionAttributes("member")에 의해 세션까지 저장됨
		return "/myInfo/member/modify";
	}
	
	// RegisterCommand에서의 유효성 검증은 더 많은거야. (주소, 핸드폰 번호만 검증하면 되는데)
	// 그래서 GET 단계에서 세션에 값을 저장해두고 --> @SessionAttributes("member")
	// POST로 넘어오면 member가 이미 값이 채워진 상태로 오게되어 내가 바꾸고픈 주소, 핸드폰 번호만 변경되어 넘어감
	// 이렇게 해야 유효성 검증에 오류가 생기지 않음
	@RequestMapping(value="/member/modify", method=RequestMethod.POST)
	public String modifyMember(@ModelAttribute("member") @Valid MemberVO member, BindingResult bindingResult, 
							   SessionStatus sessionStatus, Model model, HttpSession session) {
		
		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) {
			return "redirect:/";
		}
		
		MemberVO check = memberService.getPhoneMember(member.getPhone());
		System.out.println("check:" + check);
		
		if(bindingResult.hasErrors()) { // 유효성 검사에 에러가 발생할 경우
			if(member.getAddressnum() == 0) {
				model.addAttribute("msg", "주소를 선택해주세요.");
				return "myInfo/member/modify"; 
			}
			return "/myInfo/member/modify";
		} else {
			if(member.getAddressnum() == 0) {
				model.addAttribute("msg2", "주소를 선택해주세요.");
				return "myInfo/member/modify"; 
			} 
			memberService.modifyMember(member);
			sessionStatus.setComplete(); //세션에 담겨 있던 member 제거
			return "redirect:/myInfo";
		}
	}
	
	// 회원 정보 수정 - 비밀번호 수정
	@RequestMapping(value="/member/modifyPw")
	public String modifyPwMember(HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) {
			return "redirect:/";
		}
		
		String email = (String)session.getAttribute("email");
		MemberVO member = memberService.getMember(email);
		model.addAttribute("member", member);
		model.addAttribute("changePwCmd", new ChangePwCommand());
		return "/myInfo/member/modifyPw";
	}
	
	@RequestMapping(value="/member/modifyPw", method=RequestMethod.POST)
	public String modifyPwMember(@ModelAttribute("changePwCmd") @Valid ChangePwCommand changePwCmd, 
								 BindingResult bindingResult, MemberVO member, Model model, HttpSession session) {
		
		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) {
			return "redirect:/";
		}
		
		// 1.유효성 검사에서 에러가 발생할 경우
		if(bindingResult.hasErrors()) {
			System.out.println(bindingResult.toString());
			return "/myInfo/member/modifyPw";
		}
		
		MemberVO detail = memberService.getMember(member.getEmail());
		boolean pwMatch = pwEncoder.matches(changePwCmd.getCurrentPassword(), detail.getPassword());
		
		// 2.DB의 비밀번호와 현재 비밀번호가 일치하지 않을 경우
		if(pwMatch == false) {
			model.addAttribute("msg1", "현재 비밀번호가 일치하지 않습니다.");
			return "/myInfo/member/modifyPw";
		}
		
		// 3.변경할 비밀번호와 변경할 비밀번호 확인이 일치하지 않을 경우
		if(!(changePwCmd.getConfirmPassword().equals(changePwCmd.getPassword()))) {
			model.addAttribute("msg2", "변경할 비밀번호가 일치하지 않습니다.");
			return "/myInfo/member/modifyPw";
		}
	
		// 모든 조건이 만족할 경우
		member.setEmail(changePwCmd.getEmail());
		member.setPassword(pwEncoder.encode(changePwCmd.getPassword())); // 암호화해서 저장
		memberService.modifyPwMember(member);
		return "redirect:/myInfo";
	}
	
		
}