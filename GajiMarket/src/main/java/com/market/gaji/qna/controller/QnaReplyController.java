package com.market.gaji.qna.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.market.gaji.qna.domain.QnaReplyVO;
import com.market.gaji.qna.service.QnaReplyService;

@RestController
@RequestMapping("/qnaReply/")
public class QnaReplyController {
	
	@Autowired
	private QnaReplyService qnaReplyService;
	
	
	// 댓글 등록
	@RequestMapping(value="/new", 
					method=RequestMethod.POST,
					consumes = "application/json", 
					produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> registerQnaReply(@RequestBody QnaReplyVO qnareplyVo) {
		
		int insertCount = qnaReplyService.registerQnaReply(qnareplyVo);
		
		if(insertCount == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
	
	// 전체 댓글 조회
	@RequestMapping(value="/pages/{qnanum}",
					method=RequestMethod.GET,
					produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<QnaReplyVO>> getListQnaReply(@PathVariable("qnanum") int qnanum) {
		List<QnaReplyVO> replyList = qnaReplyService.getListQnaReply(qnanum);
		return new ResponseEntity<>(replyList, HttpStatus.OK);
	}
	
	// 댓글 조회
	@RequestMapping(value="/{qnareplynum}",
					method = RequestMethod.GET,
					produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<QnaReplyVO> getQnaReply(@PathVariable("qnareplynum") int qnareplynum) {
		QnaReplyVO reply = qnaReplyService.getQnaReply(qnareplynum);
		return new ResponseEntity<>(reply, HttpStatus.OK);
	}
	
	// 댓글 삭제
	@RequestMapping(value="/{qnareplynum}",
					method=RequestMethod.DELETE,
					produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> deleteQnaReply(@PathVariable("qnareplynum") int qnareplynum) {
		
		int deleteCount = qnaReplyService.deleteQnaReply(qnareplynum);
		
		if(deleteCount == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	// 댓글 수정
	@RequestMapping(value="/{qnareplynum}",
					method = { RequestMethod.PUT, RequestMethod.PATCH },
					consumes = "application/json", 
					produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modifyQnaReply(@RequestBody QnaReplyVO qnareplyVo, @PathVariable("qnareplynum") int qnareplynum) {
		
		qnareplyVo.setQnareplynum(qnareplynum);
		int updateCount = qnaReplyService.modifyQnaReply(qnareplyVo);
		if(updateCount == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
