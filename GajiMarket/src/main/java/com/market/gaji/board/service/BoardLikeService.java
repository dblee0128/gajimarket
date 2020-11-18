package com.market.gaji.board.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.market.gaji.board.domain.Criteria;
import com.market.gaji.board.domain.LikeVO;

public interface BoardLikeService {

	// 관심 추가
	public void insertBoardLike(LikeVO likevo);
	
	// 관심 삭제
	public void deleteBoardLike(LikeVO likevo);
	
	// 내가 좋아요한 게시물 반환값 (1,0)
	public int getLikeOrDisLike(LikeVO likevo);
	
	// 내가 좋아요한 게시글 수
	public int getCountMyBoardLike(int membernum);
	
	// 게시물 관심 개수
	public int getCountBoardLike(int boardnum);
	
	
	// 마이페이지 - 나의 관심 목록 조회 (페이징)
	public List<LikeVO> getMyBoardLike(@Param("cri") Criteria cri, @Param("membernum") int membernum);
		
	// 마이페이지 - 나의 관심 목록 총 개수
	public int getMyBoardLikeCount(@Param("cri") Criteria cri, @Param("membernum") int membernum);
	
}
