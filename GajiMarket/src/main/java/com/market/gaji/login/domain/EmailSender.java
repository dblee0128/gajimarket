package com.market.gaji.login.domain;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;

// 실제 이메일을 보내기 위한 sender
// EmailVO에서 정보를 set해서 보내주는 역할
public class EmailSender {
	
	protected JavaMailSender javaMailSender;
	
	public void sendEmail(EmailVO email) throws Exception {
		System.out.println(javaMailSender);
		MimeMessage msg = javaMailSender.createMimeMessage();
		
		try { // 셋팅해주기
			msg.setSubject(email.getSubject());
			msg.setText(email.getContent());
			msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(email.getReceiver()));
			
		} catch (MessagingException e) {
			System.out.println("MessagingException");
			e.printStackTrace();
		}
		
		try { 
			javaMailSender.send(msg); // 보내기
			
		} catch(MailException e) {
			System.out.println("MailException");
			e.printStackTrace();
		}
		
	}

}