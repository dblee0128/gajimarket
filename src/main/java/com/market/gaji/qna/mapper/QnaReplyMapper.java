package com.market.gaji.qna.mapper;

import java.util.List;

import com.market.gaji.qna.domain.QnaReplyVO;

public interface QnaReplyMapper {
	
	// 댓글 등록
	public int registerQnaReply(QnaReplyVO qnareplyVo);
	
	// 하나의 댓글 조회
	public QnaReplyVO getQnaReply(int qnareplynum);

	// 전체 댓글 조회
	public List<QnaReplyVO> getListQnaReply(int qnanum);

	// 댓글 삭제
	public int deleteQnaReply(int qnareplynum);

	// 댓글 수정
	public int modifyQnaReply(QnaReplyVO qnareplyVo);
	
	// 댓글 삭제 : 회원번호룰 받아서
	public void removeQnaReplyMem(int membernum);
	
	// 댓글 삭제 : 문의번호를 받아서
	public void removeQnaReplyQnanum(int qnanum);

}
