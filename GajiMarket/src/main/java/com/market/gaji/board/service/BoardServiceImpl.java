package com.market.gaji.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.gaji.board.domain.BoardVO;
import com.market.gaji.board.domain.Criteria;
import com.market.gaji.board.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;

	@Override
	public List<BoardVO> getListBoard(int addressnum) {
		return boardMapper.getListBoard(addressnum);
	}

	@Override
	public BoardVO getDetailBoard(int boardnum) {
		boardMapper.modifyPlusReadCnt(boardnum);
		return boardMapper.getDetailBoard(boardnum);
	}

	@Override
	public void registerBoard(BoardVO board) {
		boardMapper.registerBoard(board);
	}

	@Override
	public void deleteBoard(int boardnum) {
		boardMapper.deleteBoard(boardnum);
	}

	@Override
	public void modifyBoard(BoardVO board) {
		boardMapper.modifyBoard(board);
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





	
}
