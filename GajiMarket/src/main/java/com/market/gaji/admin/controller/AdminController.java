package com.market.gaji.admin.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.market.gaji.board.domain.BoardVO;
import com.market.gaji.board.domain.Criteria;
import com.market.gaji.board.domain.ImgVO;
import com.market.gaji.board.domain.LikeVO;
import com.market.gaji.board.domain.PageDTO;
import com.market.gaji.board.service.BoardLikeService;
import com.market.gaji.board.service.BoardService;
import com.market.gaji.member.domain.MemberVO;
import com.market.gaji.member.service.MemberService;
import com.market.gaji.notice.service.NoticeService;
import com.market.gaji.qna.service.QnaService;

@Controller
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private BoardLikeService likeService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private QnaService qnaService;
	
	
	// 관리자 메인 페이지로 이동
	@RequestMapping(value="/admin")
	public String adminMain(Model model) {
		
		model.addAttribute("memberCnt", memberService.getCountMember()); // 전체 회원 수
		model.addAttribute("boardCnt", boardService.getCountBoard()); // 전체 게시글 수
		model.addAttribute("noticeCnt", noticeService.getCountNotice()); // 전체 공지 수
		model.addAttribute("qnaCnt", qnaService.getCountQna()); // 전체 문의 수
		return "admin/admin";
	}
	
	
	// 회원 관리 
	// 전체 회원 조회
	@RequestMapping(value="/admin/member")
	public String getListMember(Criteria cri, HttpSession session, Model model) {
		
		// 1. 관리자 로그인 여부 확인 : isadmin이 0이면 돌려보내라
		int isadmin = (int)session.getAttribute("isadmin");
		if(isadmin == 0) { return "redirect:/"; }
		
		// 2. 회원 정보 모두 가져오기
		List<MemberVO> member = memberService.getListMember(cri);
		model.addAttribute("member", member);
		
		// 3. 페이징
		int total = memberService.getCountAllMember(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		return "admin/member/get";
	}
	
	// 상세 회원 조회
	@RequestMapping(value="/admin/member/{membernum}")
	public String getDetailMember(@ModelAttribute("membernum") @PathVariable("membernum") int membernum,
								  @ModelAttribute("cri") Criteria cri, HttpSession session, Model model) {
		
		// 1. 관리자 로그인 여부 확인 : isadmin이 0이면 돌려보내라
		int isadmin = (int)session.getAttribute("isadmin");
		if(isadmin == 0) { return "redirect:/"; }
		
		// 2. 회원 상세 정보 가져오기
		MemberVO member = memberService.getMemberNumMember(membernum);
		if(member == null) {
			return "redirect:/admin/member";
		} else {
			model.addAttribute("member", member);
			model.addAttribute("pageNum", cri.getPageNum()); // 페이징 추가
			model.addAttribute("amount", cri.getAmount()); // 페이징 추가
			return "/admin/member/getDetail";
		}
		
	}
	
	// 회원 정보 수정 - 회원 <-> 관리자 전환
	@RequestMapping(value="/admin/member/update/{membernum}", method = RequestMethod.POST)
	public String changeAdminOrMember(@PathVariable("membernum") int membernum, @ModelAttribute("isadmin") int isadmin,
									  @ModelAttribute("cri") Criteria cri, HttpSession session, Model model) {
		
		// 1. 관리자 로그인 여부 확인 : isadmin이 0이면 돌려보내라
		int check = (int)session.getAttribute("isadmin");
		if(check == 0) { return "redirect:/"; }
		
		// 2. 수정 실행
		memberService.changeAdminOrMember(isadmin, membernum);
		return "redirect:/admin/member/{membernum}";
		
	}
	
	// 회원 강제 탈퇴
	@RequestMapping(value="/admin/member/delete/{membernum}")
	public String deleteMember(@PathVariable("membernum") int membernum, Criteria cri, 
							   HttpSession session, Model model) {
		
		// 1. 관리자 로그인 여부 확인 : isadmin이 0이면 돌려보내라
		int isadmin = (int)session.getAttribute("isadmin");
		if(isadmin == 0) { return "redirect:/"; }
		
		// 2. 강제 탈퇴 진행
		memberService.removeMember(membernum);
		return "redirect:/admin/member";
		
	}
	

	// 게시글 관리
	// 전체 게시글 보기
	@RequestMapping(value="/admin/board")
	public String getAllBoardAdmin(Criteria cri, HttpSession session, Model model) {
		
		// 1. 관리자 로그인 여부 확인 : isadmin이 0이면 돌려보내라
		int check = (int)session.getAttribute("isadmin");
		if(check == 0) { return "redirect:/"; }
		
		// 2. 게시판 전체 목록 가져오기
		List<BoardVO> board = boardService.getAllBoard(cri);
		model.addAttribute("board", board);
		
		int total = boardService.getAllBoardCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		return "admin/board/get";
		
		// get.jsp에 주소별 검색 기능 추가하기
	}
	
	// 상세 게시글 보기
	@RequestMapping(value="admin/board/{boardnum}")
	public String getDetailBoard(HttpSession session, @ModelAttribute("boardnum") @PathVariable int boardnum,
								 @ModelAttribute("cri") Criteria cri, Model model) { // cri 추가
		
		// 1. 관리자 로그인 여부 확인 : isadmin이 0이면 돌려보내라
		int isadmin = (int)session.getAttribute("isadmin");
		if(isadmin == 0) { return "redirect:/"; }
		model.addAttribute("isadmin", isadmin);
		
		
		// 2. 게시판 상세 내용 가져오기
		BoardVO board = boardService.getDetailBoard(boardnum);
		if(board == null) { // 존재하지 않는 게시물이라면
			return "redirect:admin/board";
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
		
		return "admin/board/getDetail";
	}
	
	// 게시물 삭제
	@RequestMapping(value="admin/board/delete/{boardnum}")
	public String deleteBoard(@PathVariable int boardnum, Criteria cri, HttpSession session, Model model) {
		
		// 1. 관리자 로그인 여부 확인 : isadmin이 0이면 돌려보내라
		int isadmin = (int)session.getAttribute("isadmin");
		if(isadmin == 0) { return "redirect:/"; }
		model.addAttribute("isadmin", isadmin);
			
		//BoardVO board = boardService.getDetailBoard(boardnum);
		//int membernum = (int)session.getAttribute("membernum");
		//model.addAttribute("membernum", membernum);
		
		// 3. 이미지 전체 목록 가져온 후 삭제
		List<ImgVO> imgList = boardService.getImg(boardnum);
		boardService.deleteBoard(boardnum);
		deleteImgs(imgList); 
		return "redirect:/admin/board" + cri.getListLink();
		
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
				e.getMessage();
			}
		});
	}

}
