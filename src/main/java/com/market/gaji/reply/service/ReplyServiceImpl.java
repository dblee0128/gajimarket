package com.market.gaji.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.market.gaji.board.mapper.BoardMapper;
import com.market.gaji.reply.domain.ReplyVO;
import com.market.gaji.reply.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Autowired
	private BoardMapper boardMapper;

	@Transactional
	@Override
	public int registerReply(ReplyVO replyvo) {
		boardMapper.updateReplyCnt(replyvo.getBoardnum(), 1); // 댓글 입력할 때 개수 증가
		return replyMapper.registerReply(replyvo);
	}

	@Override
	public ReplyVO getReply(int replynum) {
		return replyMapper.getReply(replynum);
	}

	@Transactional
	@Override
	public int deleteReply(int replynum) {
		ReplyVO replyvo = replyMapper.getReply(replynum);
		boardMapper.updateReplyCnt(replyvo.getBoardnum(), -1);
		return replyMapper.deleteReply(replynum);
	}

	@Override
	public int modifyReply(ReplyVO replyvo) {
		return replyMapper.modifyReply(replyvo);
	}

	@Override
	public List<ReplyVO> getListRelpy(int boardnum) {
		return replyMapper.getListRelpy(boardnum);
	}

	
	
}
