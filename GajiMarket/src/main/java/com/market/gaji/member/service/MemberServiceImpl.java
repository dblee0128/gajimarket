package com.market.gaji.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.market.gaji.board.domain.Criteria;
import com.market.gaji.board.mapper.BoardMapper;
import com.market.gaji.board.mapper.LikeMapper;
import com.market.gaji.member.domain.MemberVO;
import com.market.gaji.member.mapper.MemberMapper;
import com.market.gaji.notice.mapper.NoticeMapper;
import com.market.gaji.qna.mapper.QnaMapper;
import com.market.gaji.qna.mapper.QnaReplyMapper;
import com.market.gaji.reply.mapper.ReplyMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private LikeMapper likeMapper;
	
	@Autowired
	private QnaMapper qnaMapper;
	
	@Autowired
	private QnaReplyMapper qnaReplyMapper; 
	
	@Autowired
	private NoticeMapper noticeMapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Override
	public void registerMember(MemberVO member) {
		memberMapper.registerMember(member);
	}

	@Override
	public MemberVO getMember(String email) {
		return memberMapper.getMember(email);
	}
	
	@Override
	public MemberVO getNicknameMember(String nickname) {
		return memberMapper.getNicknameMember(nickname);
	}
	
	@Override
	public MemberVO getPhoneMember(String phone) {
		return memberMapper.getPhoneMember(phone);
	}
	
	@Override
	public void deleteMember(String email, String password) {
		memberMapper.deleteMember(email, password);
	}

	@Override
	public void modifyMember(MemberVO member) {
		memberMapper.modifyMember(member);
	}

	@Override
	public void modifyPwMember(MemberVO member) {
		memberMapper.modifyPwMember(member);	
	}

	@Override
	public MemberVO getMemberNumMember(int membernum) {
		return memberMapper.getMemberNumMember(membernum);
	}

	@Override
	public List<MemberVO> getListMember(Criteria cri) {
		return memberMapper.getListMember(cri);
	}

	@Override
	public int getCountAllMember(Criteria cri) {
		return memberMapper.getCountAllMember(cri);
	}

	// 여기부터 관리자
	// 회원 강제 탈퇴
	@Transactional
	@Override
	public void removeMember(int membernum) {
		qnaReplyMapper.removeQnaReplyMem(membernum);
		qnaMapper.removeQnaMem(membernum);
		noticeMapper.removeNoticeMem(membernum);
		likeMapper.removeBoardLikeMem(membernum);
		replyMapper.removeReplyMem(membernum);
		boardMapper.removeBoardMem(membernum);
		memberMapper.removeMember(membernum);
	}

	@Override
	public void changeAdminOrMember(int isadmin, int membernum) {
		memberMapper.changeAdminOrMember(isadmin, membernum);
	}

	
	
}
