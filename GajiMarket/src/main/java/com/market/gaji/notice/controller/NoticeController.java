package com.market.gaji.notice.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.market.gaji.board.domain.Criteria;
import com.market.gaji.board.domain.PageDTO;
import com.market.gaji.member.domain.MemberVO;
import com.market.gaji.member.service.MemberService;
import com.market.gaji.notice.domain.NoticeVO;
import com.market.gaji.notice.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private MemberService memberService;
	
	
	// 전체 공지 조회 - 페이징
	@RequestMapping
	public String getListNotice(Criteria cri, HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) { return "redirect:/"; }
		
		// 2. 공지 전체 목록 가져오기
		List<NoticeVO> notice = noticeService.getListPagingNotice(cri);
		model.addAttribute("notice", notice);
		
		int total = noticeService.getTotalCountNotice(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		return "/notice/get";
		
	}
	
	// 게시물 상세 조회
	@RequestMapping("/{noticenum}")
	public String getDetailNotice(HttpSession session, 
								  @ModelAttribute("noticenum") @PathVariable int noticenum,
								  @ModelAttribute("cri") Criteria cri, Model model) {
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) { return "redirect:/"; }
		
		// 2. 세션 정보 가져오기
		MemberVO member = memberService.getMember(email);
		model.addAttribute("member", member);
		
		// 3. 공지사항 상세 내용 가져오기
		NoticeVO notice = noticeService.getDetailNotice(noticenum);
		if(notice == null) { return "redirect:/notice"; }
		
		model.addAttribute("notice", notice);
		model.addAttribute("pageNum", cri.getPageNum()); // 페이징 추가
		model.addAttribute("amount", cri.getAmount()); // 페이징 추가
		
		return "/notice/getDetail";
		
	}
	
	// 공지사항 등록 - 관리자
	@RequestMapping(value="/register")
	public String registerNotice(HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) { return "redirect:/"; }
		
		// 2. 세션 정보 가져오기
		MemberVO member = memberService.getMember(email);
		model.addAttribute("member", member);
		
		// 3. <form:form modelAttribute="notice">
		model.addAttribute("notice", new NoticeVO());
		
		return "/notice/register";
		
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registerNotice(@ModelAttribute("notice") @Valid NoticeVO notice, 
								 BindingResult bindingResult, Model model) {
		
		// 1. 유효성 검증
		if(bindingResult.hasErrors()) { return "/notice/register"; };

		// 2. 게시글 등록 실행
		noticeService.registerNotice(notice);
		return "redirect:/notice";
		
	}
	
	// 공지사항 삭제 - 관리자
	@RequestMapping(value="/delete/{noticenum}")
	public String deleteNotice(@PathVariable int noticenum, HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) { return "redirect:/"; }
		
		// 2. 공지글의 membernum과 로그인한 관리자의 membernum이 같은지 확인
		NoticeVO notice = noticeService.getDetailNotice(noticenum);
		int membernum = (int)session.getAttribute("membernum");
		model.addAttribute("membernum", membernum);
		
		if(membernum == notice.getMembernum()) {
			noticeService.deleteNotice(noticenum);
			return "redirect:/notice";
		} else {
			model.addAttribute("notice", notice);
			model.addAttribute("msg", "게시물을 삭제할 수 없습니다.");
			return "/notice/getDetail";
		}
		
	}
	
	// 공지사항 수정 - 관리자
	@RequestMapping(value="/modify/{noticenum}")
	public String modifyNotice(@ModelAttribute("cri") Criteria cri, @PathVariable("noticenum") int noticenum, 
							   HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) { return "redirect:/"; }
		
		// 2. 공지글의 membernum과 로그인한 관리자의 membernum이 같은지 확인
		NoticeVO notice = noticeService.getDetailNotice(noticenum);
		int membernum = (int)session.getAttribute("membernum");
		
		if(membernum == notice.getMembernum()) {
			model.addAttribute("notice", notice);
			return "/notice/modify";
		}
		return "redirect:/notice";
		
	}
	
	@RequestMapping(value="/modify/{noticenum}", method=RequestMethod.POST)
	public String modifyNotice(@PathVariable("noticenum") int noticenum, @ModelAttribute("cri") Criteria cri, 
							   @ModelAttribute("notice") @Valid NoticeVO notice, BindingResult bindingResult, 
							   HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) { return "redirect:/"; }
		
		// 2. 유효성 검증
		if(bindingResult.hasErrors()) { return "/notice/modify"; };
		
		// 3. 게시글 등록 실행
		if(notice.getMembernum() == (int)session.getAttribute("membernum")) {
			noticeService.modifyNotice(notice);
			model.addAttribute("pageNum", cri.getPageNum());
			model.addAttribute("amount", cri.getAmount());
			model.addAttribute("type", cri.getType());
			model.addAttribute("keyword", cri.getKeyword());
			return "redirect:/notice/{noticenum}";
		} else {
			return "redirect:/notice";
		}
	}

}
