package com.sikon.service.domain;

public class Love {
	
	
	private int loveNo;
	private String mentorNickname;
	private String userId;
	private User user;
	private int loveCheck;
	public int getLoveNo() {
		return loveNo;
	}
	public void setLoveNo(int loveNo) {
		this.loveNo = loveNo;
	}
	public String getMentorNickname() {
		return mentorNickname;
	}
	public void setMentorNickname(String mentorNickname) {
		this.mentorNickname = mentorNickname;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public int getLoveCheck() {
		return loveCheck;
	}
	public void setLoveCheck(int loveCheck) {
		this.loveCheck = loveCheck;
	}
	
	
	@Override
	public String toString() {
		return "Love [loveNo=" + loveNo + ", mentorNickname=" + mentorNickname + ", userId=" + userId + ", user=" + user
				+ ", loveCheck=" + loveCheck + "]";
	}
	
	
	

}
