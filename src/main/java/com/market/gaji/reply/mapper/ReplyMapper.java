package com.market.gaji.reply.mapper;

import java.util.List;

import com.market.gaji.reply.domain.ReplyVO;

public interface ReplyMapper {
	
	// 댓글 등록
	public int registerReply(ReplyVO replyvo);
	
	// 하나의 댓글 조회
	public ReplyVO getReply(int replynum);

	// 댓글 삭제
	public int deleteReply(int replynum);
		
	// 댓글 수정
	public int modifyReply(ReplyVO replyvo);
	
	// 전체 댓글 조회
	public List<ReplyVO> getListRelpy(int boardnum);
	
	// 댓글 삭제 - 회원번호
	public void removeReplyMem(int membernum);
	
	// 댓글 삭제 - 게시글번호
	public void removeReplyBrd(int boardnum);
	


}
