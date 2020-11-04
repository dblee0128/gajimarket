package com.market.gaji.board.controller;

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

import com.market.gaji.board.domain.BoardVO;
import com.market.gaji.board.domain.Criteria;
import com.market.gaji.board.domain.PageDTO;
import com.market.gaji.board.service.BoardService;
import com.market.gaji.member.domain.MemberVO;
import com.market.gaji.member.service.MemberService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MemberService memberService;
	
	// 전체 게시물 조회 - 페이징 전
//	@RequestMapping
//	public String getAllBoard(HttpSession session, Model model) {
//		
//		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
//		String email = (String)session.getAttribute("email");
//		if(email == null) {
//			return "redirect:/";
//		}
//		
//		// 2. 로그인한 회원의 정보 조회
//		MemberVO member = memberService.getMember(email); // 세션의 email로 회원 정보 조회하기
//		model.addAttribute("member", member);
//		
//		// 3. 게시판 전체 목록 가져오기 - 회원의 주소 기준
//		List<BoardVO> board = boardService.getListBoard(member.getAddressnum());
//		model.addAttribute("board", board);
//		
//		return "/board/get";
//	}
	
	// 전체 게시물 조회 - 페이징 후
	@RequestMapping
	public String getAllBoard(Criteria cri, HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) {
			return "redirect:/";
		}
		
		// 2. 로그인한 회원의 정보 조회
		MemberVO member = memberService.getMember(email); // 세션의 email로 회원 정보 조회하기
		model.addAttribute("member", member);
		
		
		// 3. 게시판 전체 목록 가져오기
		List<BoardVO> board = boardService.getListPagingBoard(cri, member.getAddressnum());
		model.addAttribute("board", board);
		
		int total = boardService.getTotalCountBoard(cri, member.getAddressnum());
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		return "/board/get";
	}
	
	// 게시물 상세 조회
	@RequestMapping(value="/{boardnum}")
	public String getDetailBoard(HttpSession session, @ModelAttribute("boardnum") @PathVariable int boardnum,
								 @ModelAttribute("cri") Criteria cri, Model model) { // cri 추가
		
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) { 
			return "redirect:/";
		}
		
		// 2. 게시판 상세 내용 가져오기
		BoardVO board = boardService.getDetailBoard(boardnum);
		if(board == null) { // 존재하지 않는 게시물이라면
			return "redirect:/board";
		}
		model.addAttribute("board", board);
		model.addAttribute("pageNum", cri.getPageNum()); // 페이징 추가
		model.addAttribute("amount", cri.getAmount()); // 페이징 추가
		
		return "/board/getDetail";
	}

	// 게시물 등록
	@RequestMapping(value="/register")
	public String registerBoard(HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) {
			return "redirect:/";
		}
		
		// 2. 로그인한 회원의 정보 조회
		MemberVO member = memberService.getMember(email);
		model.addAttribute("member", member); // membernum 필요
		model.addAttribute("board", new BoardVO()); // <form:form modelAttribute="board">
		return "/board/register";
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registerBoard(@ModelAttribute("board") @Valid BoardVO board, 
								BindingResult bindingResult, Model model) {
		
		// 1. 유효성 검증 + 카테고리 선택 검증
		if(bindingResult.hasErrors()) {
			if(board.getCategorynum() == 0) {
				model.addAttribute("msg", "카테고리를 선택해주세요.");
				return "/board/register";
			} else if(board.getCategorynum() == 0) {
				model.addAttribute("msg", "카테고리를 선택해주세요.");
				return "/board/register";
			}
			return "/board/register";
		}
		
		// 2. 게시글 등록 실행
		boardService.registerBoard(board);
		return "redirect:/board";
	}
	
	// 게시물 삭제
	@RequestMapping(value="/delete/{boardnum}")
	public String deleteBoard(@PathVariable int boardnum, HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) {
			return "redirect:/";
		}
			
		// 2. 게시글의 membernum과 로그인한 사용자의 membernum이 같은지 확인
		BoardVO board = boardService.getDetailBoard(boardnum);
		int membernum = (int)session.getAttribute("membernum");
		model.addAttribute("membernum", membernum);
		
		if(membernum == board.getMembernum()) {
			boardService.deleteBoard(boardnum); // 같으면 삭제
			return "redirect:/board";
		} else {
			model.addAttribute("board", board);
			model.addAttribute("msg", "게시물을 삭제할 수 없습니다.");
			return "/board/getDetail";
		}
		
	}
	
	// 게시물 수정
	@RequestMapping(value="/modify/{boardnum}")
	public String modifyBoard(@ModelAttribute("cri") Criteria cri, @PathVariable int boardnum, HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) {
			return "redirect:/";
		}
		
		// 2. 기존 게시글의 내용과 세션의 membernum 가져오기
		BoardVO board = boardService.getDetailBoard(boardnum);
		int membernum = (int)session.getAttribute("membernum");
		
		// 3. 두 값이 같으면 게시글 내용 뿌려주기
		if(membernum == board.getMembernum()) {
			model.addAttribute("board", board);
			return "/board/modify";
		}
		return "redirect:/board"; // 두 값이 다르다면 = 다른 사람의 글을 수정하려고 한다면
	}
	
	@RequestMapping(value="/modify/{boardnum}", method = RequestMethod.POST)
	public String modifyBoard(@PathVariable int boardnum, @ModelAttribute("board") @Valid BoardVO board, 
							  @ModelAttribute("cri") Criteria cri, BindingResult bindingResult, HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) {
			return "redirect:/";
		}
		
		// 2. 유효성 검증 + 카테고리 선택 검증
		if(bindingResult.hasErrors()) {
			if(board.getCategorynum() == 0) {
				model.addAttribute("msg", "카테고리를 선택해주세요.");
				return "/board/modify";
			} else if(board.getCategorynum() == 0) {
				model.addAttribute("msg", "카테고리를 선택해주세요.");
				return "/board/modify";
			}
			return "/board/modify";
		}
		
		// 3. 게시글의 membernum과 로그인한 사용자의 membernum이 같으면 수정 실행
		if(board.getMembernum() == (int)session.getAttribute("membernum")) {
			boardService.modifyBoard(board);
			model.addAttribute("pageNum", cri.getPageNum());
			model.addAttribute("amount", cri.getAmount());
			model.addAttribute("type", cri.getType());
			model.addAttribute("keyword", cri.getKeyword());
			return "redirect:/board/{boardnum}";
		} else {
			return "redirect:/board";
		}
	}
	

}