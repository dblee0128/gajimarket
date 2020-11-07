package com.market.gaji.board.mapper;

import java.util.List;

import com.market.gaji.board.domain.ImgVO;

public interface ImgMapper {
	
	// 이미지 추가
	public void registerImg(ImgVO img);
	
	// 이미지 삭제
	public void deleteImg(String uuid);
	
	// 이미지 조회
	public List<ImgVO> getImg(int boardnum);
	
	// 전체 이미지 삭제
	public void deleteAllImg(int boardnum);

}
