package com.market.gaji.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.gaji.board.domain.Criteria;
import com.market.gaji.notice.domain.NoticeVO;
import com.market.gaji.notice.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeMapper noticeMapper;

	@Override
	public List<NoticeVO> getListNotice() {
		return noticeMapper.getListNotice();
	}

	@Override
	public NoticeVO getDetailNotice(int noticenum) {
		return noticeMapper.getDetailNotice(noticenum);
	}

	@Override
	public void registerNotice(NoticeVO notice) {
		noticeMapper.registerNotice(notice);
	}

	@Override
	public void modifyNotice(NoticeVO notice) {
		noticeMapper.modifyNotice(notice);
	}

	@Override
	public void deleteNotice(int noticenum) {
		noticeMapper.deleteNotice(noticenum);
	}

	@Override
	public List<NoticeVO> getListPagingNotice(Criteria cri) {
		return noticeMapper.getListPagingNotice(cri);
	}

	@Override
	public int getTotalCountNotice(Criteria cri) {
		return noticeMapper.getTotalCountNotice(cri);
	}
	

}
