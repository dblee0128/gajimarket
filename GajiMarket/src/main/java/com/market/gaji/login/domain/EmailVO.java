package com.market.gaji.login.domain;

// 이메일을 보낼 때 작성하여 보낼 내용
public class EmailVO {
	
	private String subject; // 제목
	private String content; // 내용
	private String receiver; // 받는사람
	
	
	
	public EmailVO(String subject, String content, String receiver) {
		super();
		this.subject = subject;
		this.content = content;
		this.receiver = receiver;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	
	@Override
	public String toString() {
		return "EmailVO [subject=" + subject + ", content=" + content + ", receiver=" + receiver + "]";
	}
	
}
