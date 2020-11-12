package com.market.gaji.board.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.market.gaji.board.domain.BoardVO;
import com.market.gaji.board.domain.Criteria;
import com.market.gaji.board.domain.ImgVO;

public interface BoardService {
	
	// 전체 게시물 조회
	public List<BoardVO> getListBoard(int addressnum);
	
	// 나의 게시물 조회
	public List<BoardVO> getListMyBoard(int membernum);
	
	// 게시물 상세 조회
	public BoardVO getDetailBoard(int boardnum);
	
	// 이미지 조회
	public List<ImgVO> getImg(int boardnum);

	// 게시물 등록
	public void registerBoard(BoardVO board);
	
	// 게시물 삭제
	public void deleteBoard(int boardnum);
	
	// 게시물 수정
	public void modifyBoard(BoardVO board);

	// 전체 게시물 조회 - 페이징 처리
	public List<BoardVO> getListPagingBoard(@Param("cri") Criteria cri, @Param("addressnum") int addressnum);
	public int getTotalCountBoard(@Param("cri") Criteria cri, @Param("addressnum") int addressnum);
	
	// 나의 게시물 조회 - 페이징 처리
	public List<BoardVO> getListPagingMyBoard(@Param("cri") Criteria cri, @Param("membernum") int membernum);
	public int getTotalCountMyBoard(@Param("cri") Criteria cri, @Param("membernum") int membernum);
	
	// 여기부터 관리자
	// 모든 게시물 조회 - 모든 주소 포함
	public List<BoardVO> getAllBoard(Criteria cri);
	public int getAllBoardCount(Criteria cri);

	
}
