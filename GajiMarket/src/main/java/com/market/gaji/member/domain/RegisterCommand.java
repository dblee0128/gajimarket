package com.market.gaji.member.domain;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class RegisterCommand {
	
	@NotEmpty(message="이메일을 입력해주세요.")
	@Email(message="이메일 형식에 어긋납니다.")
	private String email;
	
	@NotEmpty(message="비밀번호를 입력해주세요.")
	@Pattern(regexp="[a-zA-Z0-9]{8,16}", message = "입력 조건을 확인해주세요.")
	private String password;
	
	@NotEmpty(message="비밀번호를 한번 더 입력해주세요.")
	@Pattern(regexp="[a-zA-Z0-9]{8,16}", message = "입력 조건을 확인해주세요.")
	private String confirmPassword;
	
	@NotEmpty(message="별명을 입력해주세요.")
	@Pattern(regexp = "[가-힣a-zA-Z0-9]{2,8}", message = "입력 조건을 확인해주세요.")
	private String nickname;
	
	@NotEmpty(message="핸드폰 번호를 입력해주세요.")
	@Pattern(regexp = "[0-9]{10,11}", message = "입력 조건을 확인해주세요.")
	private String phone;
	
	private int addressnum;
	
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
	public String getConfirmPassword() {
		return confirmPassword;
	}
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getAddressnum() {
		return addressnum;
	}
	public void setAddressnum(int addressnum) {
		this.addressnum = addressnum;
	}
	@Override
	public String toString() {
		return "RegisterCommand [email=" + email + ", password=" + password + ", confirmPassword=" + confirmPassword
				+ ", nickname=" + nickname + ", phone=" + phone + ", addressnum=" + addressnum + "]";
	}

}
