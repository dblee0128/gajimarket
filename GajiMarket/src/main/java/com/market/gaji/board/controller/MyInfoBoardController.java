package com.market.gaji.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.market.gaji.board.domain.BoardVO;
import com.market.gaji.board.domain.Criteria;
import com.market.gaji.board.domain.LikeVO;
import com.market.gaji.board.domain.PageDTO;
import com.market.gaji.board.service.BoardLikeService;
import com.market.gaji.board.service.BoardService;
import com.market.gaji.member.domain.MemberVO;
import com.market.gaji.member.service.MemberService;

@Controller
@RequestMapping("/myInfo/board")
public class MyInfoBoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BoardLikeService boardLikeService;
	
	// 내가 쓴 글 전체 목록 가져오기
//	@RequestMapping(value="/get")
//	public String getListMyBoard(HttpSession session, Model model) {
//		
//		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
//		int membernum = (int)session.getAttribute("membernum");
//		if(membernum == 0) {
//			return "redirect:/";
//		}
//		
//		// 2. membernum으로 로그인한 회원의 정보 조회
//		MemberVO member = memberService.getMemberNumMember(membernum);
//		model.addAttribute("member", member);
//		
//		// 3. 내가 쓴 글 전체 목록 가져오기
//		List<BoardVO> board = boardService.getListMyBoard(membernum);
//		model.addAttribute("board", board);
//						
//		return "myInfo/board/get";
//	}
	
	// 내가 쓴 글 전체 목록 가져오기 - 페이징 후
	@RequestMapping(value="/get")
	public String getListMyBoard(Criteria cri, HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) {
			return "redirect:/";
		}
		
		// 2. membernum으로 로그인한 회원의 정보 조회
		MemberVO member = memberService.getMemberNumMember(membernum);
		model.addAttribute("member", member);
		
		// 3. 내가 쓴 글 전체 목록 가져오기
		List<BoardVO> board = boardService.getListPagingMyBoard(cri, membernum);
		model.addAttribute("board", board);
		
		// 페이징
		int total = boardService.getTotalCountMyBoard(cri, membernum);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
						
		return "myInfo/board/get";
	}
	
	// 좋아요한 게시글 가져오기
	@RequestMapping(value="/getLike")
	public String getMyBoardLike(Criteria cri, HttpSession session, Model model) {
		// 1. 로그인 여부 체크: 세션에 membernum이 있는지 확인
		int membernum = (int)session.getAttribute("membernum");
		if(membernum == 0) {
			return "redirect:/";
		}		
		
		// 2. membernum으로 로그인한 회원의 정보 조회
		MemberVO member = memberService.getMemberNumMember(membernum);
		model.addAttribute("member", member);
		
		// 3. 내가 좋아요한 글 전체 목록 가져오기
		List<LikeVO> like = boardLikeService.getMyBoardLike(cri, membernum);
		model.addAttribute("like", like);
		
		// 페이징
		int total = boardLikeService.getMyBoardLikeCount(cri, membernum);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		return "myInfo/board/getLike";
	}
	
	
	
	
	
	
	

	
	
}
