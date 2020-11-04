package com.market.gaji.member.domain;

import java.sql.Date;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class MemberVO {
	
	private int membernum;
	private String email;
	private String password;
	private String nickname;
	
	@NotEmpty(message="핸드폰 번호를 입력해주세요.")
	@Pattern(regexp = "[0-9]{10,11}", message = "입력 조건을 확인해주세요.")
	private String phone;
	private Date regdate;
	private int addressnum;
	
	private AddressVO address;
	

	public int getMembernum() {
		return membernum;
	}
	public void setMembernum(int membernum) {
		this.membernum = membernum;
	}
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
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getAddressnum() {
		return addressnum;
	}
	public void setAddressnum(int addressnum) {
		this.addressnum = addressnum;
	}
	public AddressVO getAddress() {
		return address;
	}
	public void setAddress(AddressVO address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "MemberVO [membernum=" + membernum + ", email=" + email + ", password=" + password + ", nickname="
				+ nickname + ", phone=" + phone + ", regdate=" + regdate + ", addressnum=" + addressnum + ", address="
				+ address + "]";
	}
	
}