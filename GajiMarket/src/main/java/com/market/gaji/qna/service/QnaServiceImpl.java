package com.market.gaji.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.gaji.board.domain.Criteria;
import com.market.gaji.qna.domain.QnaVO;
import com.market.gaji.qna.mapper.QnaMapper;

@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	private QnaMapper qnaMapper;

	@Override
	public List<QnaVO> getQnaList(Criteria cri) {
		return qnaMapper.getQnaList(cri);
	}

	@Override
	public QnaVO getDetailQna(int qnanum) {
		return qnaMapper.getDetailQna(qnanum);
	}

	@Override
	public void registerQna(QnaVO qna) {
		qnaMapper.registerQna(qna);
	}

	@Override
	public void deleteQna(int qnanum) {
		qnaMapper.deleteQna(qnanum);
	}

	@Override
	public void modifyQna(QnaVO qna) {
		qnaMapper.modifyQna(qna);
	}

	@Override
	public List<QnaVO> getMyQnaList(int membernum) {
		return qnaMapper.getMyQnaList(membernum);
	}

}
