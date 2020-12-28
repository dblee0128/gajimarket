package com.market.gaji.qna.domain;

public class QnaTypeVO {
	
	private int typenum;
	private String typename;
	
	public int getTypenum() {
		return typenum;
	}
	public void setTypenum(int typenum) {
		this.typenum = typenum;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	
	@Override
	public String toString() {
		return "QnaTypeVO [typenum=" + typenum + ", typename=" + typename + "]";
	}

}
