package com.market.gaji.qna.service;

import java.util.List;

import com.market.gaji.board.domain.Criteria;
import com.market.gaji.qna.domain.QnaVO;

public interface QnaService {
	
	// 전체 문의 목록 (페이징) - 관리자
	public List<QnaVO> getQnaList(Criteria cri);
	
	// 문의 상세 조회
	public QnaVO getDetailQna(int qnanum);

	// 문의 등록
	public void registerQna(QnaVO qna);

	// 문의 삭제
	public void deleteQna(int qnanum);

	// 문의 수정
	public void modifyQna(QnaVO qna);

	// 내가 쓴 문의 조회
	public List<QnaVO> getMyQnaList(int membernum);

}
