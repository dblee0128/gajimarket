package com.market.gaji.board.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.market.gaji.board.domain.BoardVO;
import com.market.gaji.board.domain.Criteria;
import com.market.gaji.board.domain.ImgVO;
import com.market.gaji.board.domain.LikeVO;
import com.market.gaji.board.domain.PageDTO;
import com.market.gaji.board.service.BoardLikeService;
import com.market.gaji.board.service.BoardService;
import com.market.gaji.member.domain.MemberVO;
import com.market.gaji.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BoardLikeService likeService;
	
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
		
		// 3. 좋아요 테이블에서 사용자가 좋아요 눌렀는지 확인
		LikeVO likevo = new LikeVO();
		likevo.setBoardnum(boardnum);
		likevo.setMembernum((int)session.getAttribute("membernum"));
		System.out.println("likevo: " + likevo); // OK
		
		int likeCheck = likeService.getLikeOrDisLike(likevo); // 좋아요 했냐 안했냐? 좋아요한 개수가 담김
		System.out.println("likeCheck: " + likeCheck);
		
		if(likeCheck == 1) { // 좋아요 했으면
			model.addAttribute("likeCheck", likeCheck);
		} else { // 좋아요 안했으면
			model.addAttribute("likeCheck", 0);
		}
		model.addAttribute("board", board);
		model.addAttribute("membernum", (int)session.getAttribute("membernum"));
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
		
		if(board.getImgList() != null) {
			board.getImgList().forEach(img -> log.info(img));
		}
		
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
	public String deleteBoard(@PathVariable int boardnum, Criteria cri, HttpSession session, Model model) {
		
		// 1. 로그인 여부 체크: 세션에 email이 있는지 확인
		String email = (String)session.getAttribute("email");
		if(email == null) {
			return "redirect:/";
		}
			
		// 2. 게시글의 membernum과 로그인한 사용자의 membernum이 같은지 확인
		BoardVO board = boardService.getDetailBoard(boardnum);
		int membernum = (int)session.getAttribute("membernum");
		model.addAttribute("membernum", membernum);
		
		// 3. 이미지 전체 목록 가져오기
		List<ImgVO> imgList = boardService.getImg(boardnum);
		
		if(membernum == board.getMembernum()) {
			boardService.deleteBoard(boardnum); // 같으면 삭제
			deleteImgs(imgList); // 이미지도 삭제
			return "redirect:/board" + cri.getListLink();
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
	
	// 이미지 출력
	@RequestMapping(value="/getImgList", 
					method=RequestMethod.GET, 
					produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ImgVO>> getImgList(int boardnum) {
		return new ResponseEntity<>(boardService.getImg(boardnum), HttpStatus.OK);
	}
	
	// 이미지 삭제
	private void deleteImgs(List<ImgVO> imgList) {
		if(imgList == null || imgList.size() == 0) {
			return;
		}
		
		imgList.forEach(img -> {
			try {
				Path file = Paths.get("/Users/dabin/upload/temp/" + img.getUploadpath() + "/" + img.getUuid() + "_" + img.getFilename());
				Files.deleteIfExists(file); // 원본 이미지 삭제
				
				Path thumbNail = Paths.get("/Users/dabin/upload/temp/" + img.getUploadpath() + "/s_" + img.getUuid() + "_" + img.getFilename());
				Files.delete(thumbNail);
			} catch(Exception e) {
				log.error("delete file error: " + e.getMessage());
			}
		});
	}
	
	
	
	// 좋아요 
	
	// 좋아요 추가 기능
	@RequestMapping(value="/like", method=RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public String likeBoard(@RequestBody LikeVO likevo) {
		
		int likeCheck = likeService.getLikeOrDisLike(likevo);
		int response = 0;
		
		if(likeCheck == 0) { // 하얀하트
			likeService.insertBoardLike(likevo); 
			response = 1; // 빨간하트
			
		} else if(likeCheck > 0) { // 빨간하트
			likeService.deleteBoardLike(likevo); 
			response = 0; // 하얀하트
		}
		return String.valueOf(response);
	}

	
}