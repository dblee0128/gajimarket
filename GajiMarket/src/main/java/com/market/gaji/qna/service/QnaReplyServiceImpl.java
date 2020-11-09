package com.market.gaji.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.gaji.qna.domain.QnaReplyVO;
import com.market.gaji.qna.mapper.QnaReplyMapper;

@Service
public class QnaReplyServiceImpl implements QnaReplyService {
	
	@Autowired
	private QnaReplyMapper qnaReplyMapper;

	@Override
	public int registerQnaReply(QnaReplyVO qnareply) {
		return qnaReplyMapper.registerQnaReply(qnareply);
	}

	@Override
	public QnaReplyVO getQnaReply(int qnareplynum) {
		return qnaReplyMapper.getQnaReply(qnareplynum);
	}

	@Override
	public List<QnaReplyVO> getListQnaReply(int qnanum) {
		return qnaReplyMapper.getListQnaReply(qnanum);
	}

	@Override
	public int deleteQnaReply(int qnareplynum) {
		return qnaReplyMapper.deleteQnaReply(qnareplynum);
	}

	@Override
	public int modifyReply(QnaReplyVO qnareply) {
		return qnaReplyMapper.modifyReply(qnareply);
	}
	

}
