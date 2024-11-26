package com.project.util;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

//메일 전송 서비스
@Component
public class MailSend {
	// JavaMailSenderImpl 클래스는 JavaMailSender 인터페이스를 사용해 이메일 보내기 기능을 제공
	@Autowired
	private JavaMailSenderImpl mailSender;
	private int authNumber; 

	public void makeRandomNumber() {
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		authNumber = checkNum;
	}

	//회원 가입 이메일 인증번호 확인 
	public String joinEmail(String email) {
		makeRandomNumber();
		String from = "cysuk123@naver.com"; 
		String to = email;
		String subject = "회원 가입 인증 이메일 입니다."; 
		String content = 
				"홈페이지를 방문해주셔서 감사합니다." + 	
						"<br><br>" + 
						"인증 번호는  " + authNumber + "  입니다." + 
						"<br>" + 
						"해당 인증번호를 인증번호 확인란에 기입하여 주세요."; 
		mailSend(from, to, subject, content);
		return Integer.toString(authNumber);
	}
	
	//이메일 전송 메소드
	public void mailSend(String from, String to, String subject, String content) { 
		// MimeMessage 객체를 사용하여 메일을 전송
		/*
		from: 발신자
		to: 수신자
		subject: 제목
		content: 메시지 본문
		contentType: 메시지 콘텐츠 유형
		headers: 메시지 헤더
		*/
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(from);
			helper.setTo(to);
			helper.setSubject(subject);
			// true -> html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달됨
			helper.setText(content,true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
