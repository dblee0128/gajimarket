package com.market.gaji.qna.mapper;

import java.util.List;

import com.market.gaji.qna.domain.QnaReplyVO;

public interface QnaReplyMapper {
	
	// 댓글 등록
	public int registerQnaReply(QnaReplyVO qnareply);
	
	// 하나의 댓글 조회
	public QnaReplyVO getQnaReply(int qnareplynum);

	// 전체 댓글 조회
	public List<QnaReplyVO> getListQnaReply(int qnanum);

	// 댓글 삭제
	public int deleteQnaReply(int qnareplynum);

	// 댓글 수정
	public int modifyReply(QnaReplyVO qnareply);	

}
