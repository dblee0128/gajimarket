package com.market.gaji.login.domain;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

// 로그인 정보를 담기 위한 VO 객체
public class LoginCommand {
	
	@NotEmpty(message="이메일을 입력해주세요.")
	@Email(message="이메일 형식에 어긋납니다.")
	private String email;
	
	@NotEmpty(message="비밀번호를 입력해주세요.")
	private String password;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
		
}
