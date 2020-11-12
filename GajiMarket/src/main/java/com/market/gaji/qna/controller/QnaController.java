package com.market.gaji.qna.controller;

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
import com.market.gaji.qna.domain.QnaVO;
import com.market.gaji.qna.service.QnaService;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private MemberService memberService;
	
	
	// 전체 문의 목록 (페이징) - 관리자
	@RequestMapping(value="/admin/qna")
	public String getQnaList(Criteria cri, HttpSession session, Model model) {
		
		// 1. 관리자 로그인 여부 확인 : isadmin이 0이면 돌려보내라
		int isadmin = (int)session.getAttribute("isadmin");
		if(isadmin == 0) { return "redirect:/"; }
		
		// 2. 전체 문의 목록 가져오기
		List<QnaVO> qna = qnaService.getQnaList(cri);
		model.addAttribute("qna", qna);
		
		// 3. 페이징
		int total = qnaService.getCountQnaList(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		return "admin/qna/get";
	}
	
	// 문의 상세 조회 - 관리자
	@RequestMapping(value="/admin/qna/{qnanum}")
	public String getDetailQna(HttpSession session, @ModelAttribute("qnanum") @PathVariable int qnanum,
							   @ModelAttribute("cri") Criteria cri, Model model) {
		
		// 1. 관리자 로그인 여부 확인 : isadmin이 0이면 돌려보내라
		int isadmin = (int)session.getAttribute("isadmin");
		if(isadmin == 0) { return "redirect:/"; }
		
		// 2. 문의글 상세 내용 가져오기
		QnaVO qna = qnaService.getDetailQna(qnanum);
		if(qna == null) { return "redirect:/admin/qna"; }
		
		model.addAttribute("qna", qna);
		model.addAttribute("pageNum", cri.getPageNum()); // 페이징 추가
		model.addAttribute("amount", cri.getAmount()); // 페이징 추가
		
		return "admin/qna/getDetail";
		
	}
	
	
	// 여기서부터 회원
	
	// 나의 게시글 보기 - 회원
	@RequestMapping(value="/myInfo/qna")
	public String getMyQnaList(HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) { return "redirect:/"; }
				
		// 2. 전체 문의 목록 가져오기
		List<QnaVO> qna = qnaService.getMyQnaList(membernum);
		model.addAttribute("qna", qna);
		
		return "myInfo/qna/get";
		
	}
	
	// 나의 게시글 상세 보기 - 회원
	@RequestMapping(value="/myInfo/qna/{qnanum}")
	public String getDetailQna(HttpSession session, @ModelAttribute("qnanum") @PathVariable int qnanum, Model model) {
		
		// 1. 로그인 여부 체크
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) { return "redirect:/"; }
		
		// 2. 문의글 상세 내용 가져오기
		QnaVO qna = qnaService.getDetailQna(qnanum);
		if(qna == null) { return "redirect:/myInfo/qna"; } // 문의 글이 없습니다. 이런거 뜨면 좋을 듯.
		
		model.addAttribute("qna", qna);
		return "myInfo/qna/getDetail";
	
	}
	
	// 나의 게시글 등록하기 - 회원
	@RequestMapping(value="/myInfo/qna/register")
	public String registerQna(HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) { return "redirect:/"; }
		
		// 2. 로그인한 회원의 정보 조회
		MemberVO member = memberService.getMemberNumMember(membernum);
		model.addAttribute("member", member);
		model.addAttribute("qna", new QnaVO());
		
		return "/myInfo/qna/register";
		
	}
	
	@RequestMapping(value="/myInfo/qna/register", method = RequestMethod.POST)
	public String registerQna(@ModelAttribute("qna") @Valid QnaVO qna, 
							  BindingResult bindingResult, Model model) {
		
		// 1. 유효성 검증 + 문의유형 선택 검증
		if(bindingResult.hasErrors()) {
			if(qna.getTypenum() == 0) {
				model.addAttribute("msg", "적합한 문의 유형을 선택해주세요.");
				return "/myInfo/qna/register";
			} else if(qna.getTypenum() == 0) {
				model.addAttribute("msg", "적합한 문의 유형을 선택해주세요.");
				return "/myInfo/qna/register";
			}
			return "/myInfo/qna/register";
		}
		
		// 2. 문의 등록 실행
		qnaService.registerQna(qna);
		return "redirect:/myInfo/qna";
		
	}
	
	// 나의 게시글 삭제하기 - 회원
	@RequestMapping(value="/myInfo/qna/delete/{qnanum}")
	public String deleteQna(@PathVariable("qnanum") int qnanum, HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) { return "redirect:/"; }
		model.addAttribute("membernum", membernum);
		
		// 2. 게시글의 membernum과 로그인한 사용자의 membernum이 같은지 확인
		QnaVO qna = qnaService.getDetailQna(qnanum);
		if(qna.getMembernum() == membernum) {
			qnaService.deleteQna(qnanum);
			return "redirect:/myInfo/qna";
		} else {
			model.addAttribute("qna", qna);
			model.addAttribute("msg", "게시물을 삭제할 수 없습니다.");
			return "/myInfo/qna/getDetail";
		}
		
	}
	
	// 나의 게시글 수정하기 - 회원
	@RequestMapping(value="/myInfo/qna/modify/{qnanum}")
	public String modifyQna(@PathVariable("qnanum") int qnanum, HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) { return "redirect:/"; }
		model.addAttribute("membernum", membernum);
		
		// 2. 기존 게시글 작성자와 세션 num 가져와서 일치하는지 비교
		QnaVO qna = qnaService.getDetailQna(qnanum);
		if(membernum == qna.getMembernum()) {
			model.addAttribute("qna", qna);
			return "/myInfo/qna/modify";
		}
		return "redirect:/myInfo/qna";
		
	}
	
	@RequestMapping(value="/myInfo/qna/modify/{qnanum}", method=RequestMethod.POST)
	public String modifyQna(@PathVariable("qnanum") int qnanum, 
							@ModelAttribute("qna") @Valid QnaVO qna, BindingResult bindingResult,
							HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) { return "redirect:/"; }
		
		
		// 2. 유효성 검증 + 문의유형 선택 검증
		if(qna.getTypenum() == 0) {
			model.addAttribute("msg", "적합한 문의 유형을 선택해주세요.");
			return "/myInfo/qna/modify";
		}
		if(bindingResult.hasErrors()) {
			return "/myInfo/qna/modify";
		}
		
		// 3. 문의글의 membernum과 로그인한 사용자의 membernum이 같으면 수정 실행
		if(qna.getMembernum() == membernum) {
			qnaService.modifyQna(qna);
			return "redirect:/myInfo/qna/{qnanum}";
		} else {
			return "redirect:/myInfo/qna";
		}
		
	}
	
}
