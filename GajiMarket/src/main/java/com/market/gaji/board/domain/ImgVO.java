package com.market.gaji.board.domain;

public class ImgVO {

	private String uuid;
	private String uploadpath;
	private String filename;
	private int boardnum;
	
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getUploadpath() {
		return uploadpath;
	}
	public void setUploadpath(String uploadpath) {
		this.uploadpath = uploadpath;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getBoardnum() {
		return boardnum;
	}
	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
	}
	@Override
	public String toString() {
		return "BoardImgVO [uuid=" + uuid + ", uploadpath=" + uploadpath + ", filename=" + filename + ", boardnum="
				+ boardnum + "]";
	}
	
}
