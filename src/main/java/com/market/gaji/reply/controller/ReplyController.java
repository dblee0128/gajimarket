package com.market.gaji.reply.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.market.gaji.reply.domain.ReplyVO;
import com.market.gaji.reply.service.ReplyService;

@RestController // 순수한 데이터를 반환하는 형태로 다양한 포맷의 데이터 전송 가능 : JSON, XML, 문자열 등
@RequestMapping("/reply/")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	
	// 댓글 등록
	@RequestMapping(value = "/new", method=RequestMethod.POST,
					consumes = "application/json", 
					produces = { MediaType.TEXT_PLAIN_VALUE }) // JSON 방식으로 처리하겠다
	public ResponseEntity<String> registerReply(@RequestBody ReplyVO replyvo) { // @RequestBody: JSON 데이터를 ReplyVO 타입으로 변환
		
		int insertCount = replyService.registerReply(replyvo);
		
		if(insertCount == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
	// 전체 댓글 조회
	@RequestMapping(value="/pages/{boardnum}", 
					method=RequestMethod.GET,
					produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<ReplyVO>> getListReply(@PathVariable("boardnum") int boardnum) {
		List<ReplyVO> replyList = replyService.getListRelpy(boardnum);
		return new ResponseEntity<>(replyList, HttpStatus.OK);
	}
	
	
	// 댓글 조회
	@RequestMapping(value="/{replynum}", method = RequestMethod.GET,
					produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyVO> getReply(@PathVariable("replynum") int replynum) {
		ReplyVO reply = replyService.getReply(replynum);		
		return new ResponseEntity<>(reply, HttpStatus.OK);
	}
	
	
	// 댓글 삭제
	@DeleteMapping(value="/{replynum}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> deleteReply(@PathVariable("replynum") int replynum) {
		int deleteConut = replyService.deleteReply(replynum);
		
		if(deleteConut == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
	// 댓글 수정
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH }, // 수정은 PUT 이나 PATCH 방법 사용
					value = "/{replynum}", 
					consumes = "application/json", 
					produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modifyBoard(@RequestBody ReplyVO replyvo, @PathVariable("replynum") int replynum) {
		
		replyvo.setReplynum(replynum); // 일단 직접 처리
		
		int updateCount = replyService.modifyReply(replyvo);
		
		if(updateCount == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
