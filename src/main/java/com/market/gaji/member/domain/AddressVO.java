package com.market.gaji.member.domain;

public class AddressVO {
	
	private int addressnum;
	private String addressname;
	
	public int getAddressnum() {
		return addressnum;
	}
	public void setAddressnum(int addressnum) {
		this.addressnum = addressnum;
	}
	public String getAddressname() {
		return addressname;
	}
	public void setAddressname(String addressname) {
		this.addressname = addressname;
	}
	@Override
	public String toString() {
		return "AddressVO [addressnum=" + addressnum + ", addressname=" + addressname + "]";
	}
	
	
}
