package com.market.gaji.notice.service;

import java.util.List;

import com.market.gaji.board.domain.Criteria;
import com.market.gaji.notice.domain.NoticeVO;

public interface NoticeService {
	
	// 전체 공지 조회
	public List<NoticeVO> getListNotice();
	
	// 공지 상세 조회
	public NoticeVO getDetailNotice(int noticenum);

	// 공지 등록
	public void registerNotice(NoticeVO notice);

	// 공지 수정
	public void modifyNotice(NoticeVO notice);

	// 공지 삭제
	public void deleteNotice(int noticenum);
	
	// 전체 공지 조회 + 페이징
	public List<NoticeVO> getListPagingNotice(Criteria cri);
	
	// 공지글 전체 개수
	public int getTotalCountNotice(Criteria cri);
	
}
