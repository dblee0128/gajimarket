package com.market.gaji.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.market.gaji.board.domain.Criteria;
import com.market.gaji.qna.domain.QnaVO;
import com.market.gaji.qna.mapper.QnaMapper;
import com.market.gaji.qna.mapper.QnaReplyMapper;

@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	private QnaMapper qnaMapper;
	
	@Autowired
	private QnaReplyMapper qnaReplyMapper;

	@Override
	public List<QnaVO> getQnaList(Criteria cri) {
		return qnaMapper.getQnaList(cri);
	}
	
	@Override
	public int getCountQnaList(Criteria cri) {
		return qnaMapper.getCountQnaList(cri);
	}

	@Override
	public QnaVO getDetailQna(int qnanum) {
		return qnaMapper.getDetailQna(qnanum);
	}

	@Override
	public void registerQna(QnaVO qna) {
		qnaMapper.registerQna(qna);
	}

	@Transactional
	@Override
	public void deleteQna(int qnanum) {
		qnaReplyMapper.removeQnaReplyQnanum(qnanum); // 문의글의 댓글 먼저 삭제 
		qnaMapper.deleteQna(qnanum); // 그다음 문의글 삭제
	}

	@Override
	public void modifyQna(QnaVO qna) {
		qnaMapper.modifyQna(qna);
	}

	@Override
	public List<QnaVO> getMyQnaList(int membernum) {
		return qnaMapper.getMyQnaList(membernum);
	}

	@Override
	public int getCountMyQna(int membernum) {
		return qnaMapper.getCountMyQna(membernum);
	}

	@Override
	public int getCountQna() {
		return qnaMapper.getCountQna();
	}



}
