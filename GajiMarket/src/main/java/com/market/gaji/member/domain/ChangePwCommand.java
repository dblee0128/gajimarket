package com.market.gaji.member.domain;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class ChangePwCommand {
	
	private String email;
	
	@NotEmpty(message = "현재 비밀번호를 입력해주세요.")
	@Pattern(regexp="[a-zA-Z0-9]{8,16}", message = "입력 조건을 확인해주세요.")
	private String currentPassword;
	
	@NotEmpty(message = "비밀번호를 입력해주세요.")
	@Pattern(regexp="[a-zA-Z0-9]{8,16}", message = "입력 조건을 확인해주세요.")
	private String password;
	
	@NotEmpty(message = "비밀번호를 한 번 더 입력해주세요.")
	@Pattern(regexp="[a-zA-Z0-9]{8,16}", message = "입력 조건을 확인해주세요.")
	private String confirmPassword;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCurrentPassword() {
		return currentPassword;
	}
	public void setCurrentPassword(String currentPassword) {
		this.currentPassword = currentPassword;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getConfirmPassword() {
		return confirmPassword;
	}
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	
}
