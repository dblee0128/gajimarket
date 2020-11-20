package com.market.gaji.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.market.gaji.qna.domain.QnaReplyVO;
import com.market.gaji.qna.mapper.QnaMapper;
import com.market.gaji.qna.mapper.QnaReplyMapper;

@Service
public class QnaReplyServiceImpl implements QnaReplyService {
	
	@Autowired
	private QnaReplyMapper qnaReplyMapper;
	
	@Autowired
	private QnaMapper qnaMapper;

	@Transactional
	@Override
	public int registerQnaReply(QnaReplyVO qnareplyVo) {
		qnaMapper.updateReplyCnt(qnareplyVo.getQnanum(), 1);
		return qnaReplyMapper.registerQnaReply(qnareplyVo);
	}

	@Override
	public QnaReplyVO getQnaReply(int qnareplynum) {
		return qnaReplyMapper.getQnaReply(qnareplynum);
	}

	@Override
	public List<QnaReplyVO> getListQnaReply(int qnanum) {
		return qnaReplyMapper.getListQnaReply(qnanum);
	}

	@Transactional
	@Override
	public int deleteQnaReply(int qnareplynum) {
		QnaReplyVO vo = qnaReplyMapper.getQnaReply(qnareplynum);
		qnaMapper.updateReplyCnt(vo.getQnanum(), -1);
		return qnaReplyMapper.deleteQnaReply(qnareplynum);
	}

	@Override
	public int modifyQnaReply(QnaReplyVO qnareplyVo) {
		return qnaReplyMapper.modifyQnaReply(qnareplyVo);
	}
	

}
