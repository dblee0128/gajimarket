package com.market.gaji.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.gaji.board.domain.Criteria;
import com.market.gaji.board.domain.LikeVO;
import com.market.gaji.board.mapper.LikeMapper;

@Service
public class BoardLikeServiceImpl implements BoardLikeService {

	@Autowired
	private LikeMapper likeMapper;

	// 관심 등록
	@Override
	public void insertBoardLike(LikeVO likevo) {
		likeMapper.insertBoardLike(likevo); // 등록
		likeMapper.updateBoardLike(likevo.getBoardnum()); // 게시글의 관심 수 증가
	}

	// 관심 삭제
	@Override
	public void deleteBoardLike(LikeVO likevo) {
		likeMapper.deleteBoardLike(likevo); // 삭제
		likeMapper.updateBoardLike(likevo.getBoardnum()); // 게시글의 관심 수 감소
	}
	
	// 관심 여보 확인
	@Override
	public int getLikeOrDisLike(LikeVO likevo) {
		return likeMapper.getLikeOrDisLike(likevo);
	}
	
	// 게시글 관심 수 조회
	@Override
	public int getCountBoardLike(int boardnum) {
		return likeMapper.getCountBoardLike(boardnum);
	}

	@Override
	public List<LikeVO> getMyBoardLike(Criteria cri, int membernum) {
		return likeMapper.getMyBoardLike(cri, membernum);
	}

	@Override
	public int getMyBoardLikeCount(Criteria cri, int membernum) {
		return likeMapper.getMyBoardLikeCount(cri, membernum);
	}
	

	
	
}
