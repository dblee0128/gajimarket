package com.market.gaji.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.market.gaji.board.domain.BoardVO;
import com.market.gaji.board.domain.Criteria;

public interface BoardMapper {
	
	// 전체 게시물 조회 - 주소 분류
	public List<BoardVO> getListBoard(int addressnum);
	
	// 나의 게시물 조회
	public List<BoardVO> getListMyBoard(int membernum);
	
	// 게시물 상세 조회
	public BoardVO getDetailBoard(int boardnum);
	
	// 게시물 등록
	public void registerBoard(BoardVO board);
	
	// 게시물 삭제
	public void deleteBoard(int boardnum);
		
	// 게시물 수정
	public void modifyBoard(BoardVO board);
	
	// 조회수 증가
	public void modifyPlusReadCnt(int boardnum);
	
	// 전체 게시물 조회 - 페이징 처리
	public List<BoardVO> getListPagingBoard(@Param("cri") Criteria cri, @Param("addressnum") int addressnum);
	public int getTotalCountBoard(@Param("cri") Criteria cri, @Param("addressnum") int addressnum);
	
	// 나의 게시물 조회 - 페이징 처리
	public List<BoardVO> getListPagingMyBoard(@Param("cri") Criteria cri, @Param("membernum") int membernum);
	public int getTotalCountMyBoard(@Param("cri") Criteria cri, @Param("membernum") int membernum);
	
	// 게시물당 댓글 개수 조회
	public void updateReplyCnt(@Param("boardnum") int boardnum, @Param("amount") int amount);
	
	
}
