package com.market.gaji.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.market.gaji.board.domain.BoardVO;
import com.market.gaji.board.domain.Criteria;
import com.market.gaji.board.domain.ImgVO;
import com.market.gaji.board.domain.LikeVO;
import com.market.gaji.board.mapper.BoardMapper;
import com.market.gaji.board.mapper.ImgMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private ImgMapper imgMapper;

	@Override
	public List<BoardVO> getListBoard(int addressnum) {
		return boardMapper.getListBoard(addressnum);
	}

	@Override
	public BoardVO getDetailBoard(int boardnum) {
		boardMapper.modifyPlusReadCnt(boardnum);
		return boardMapper.getDetailBoard(boardnum);
	}
	
	@Transactional
	@Override
	public void registerBoard(BoardVO board) {
		boardMapper.registerSelectKey(board); // boardnum을 사용하기 위해 selectKey 버전 사용
		
		if(board.getImgList() == null || board.getImgList().size() <= 0) {
			return;
		}
		
		List<ImgVO> imgList = board.getImgList();
		
		for(ImgVO img : imgList) {
			img.setBoardnum(board.getBoardnum()); // 게시글 먼저 넣으면서 boardnum 셋팅해주고
			imgMapper.registerImg(img); // 이미지 넣어주기
		}
		
	}

	@Transactional
	@Override
	public void deleteBoard(int boardnum) {
		imgMapper.deleteAllImg(boardnum); // 이미지도 함께 삭제되도록 함
		boardMapper.deleteBoard(boardnum); // 게시물이 삭제될 때
	}
	
	@Transactional
	@Override
	public void modifyBoard(BoardVO board) {
		imgMapper.deleteAllImg(board.getBoardnum()); // 일단 전체 이미지 삭제
		
		List<ImgVO> imgList = board.getImgList();
		
		if(imgList != null && board.getImgList().size() > 0) { // 폼에서 넘긴 이미지가 있으면
			for(ImgVO img : imgList) {
				img.setBoardnum(board.getBoardnum());
				imgMapper.registerImg(img); // 다시 이미지 등록
			}
		}
		boardMapper.modifyBoard(board); // 게시글 등록
	}

	@Override
	public List<BoardVO> getListMyBoard(int membernum) {
		return boardMapper.getListMyBoard(membernum);
	}

	@Override
	public List<BoardVO> getListPagingBoard(Criteria cri, int addressnum) {
		return boardMapper.getListPagingBoard(cri, addressnum);
	}

	@Override
	public int getTotalCountBoard(Criteria cri, int addressnum) {
		return boardMapper.getTotalCountBoard(cri, addressnum);
	}

	@Override
	public List<BoardVO> getListPagingMyBoard(Criteria cri, int membernum) {
		return boardMapper.getListPagingMyBoard(cri, membernum);
	}

	@Override
	public int getTotalCountMyBoard(Criteria cri, int membernum) {
		return boardMapper.getTotalCountMyBoard(cri, membernum);
	}
	
	@Override
	public List<ImgVO> getImg(int boardnum) {
		return imgMapper.getImg(boardnum);
	}
	
}
