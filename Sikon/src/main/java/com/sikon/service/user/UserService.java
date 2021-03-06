package com.sikon.service.user;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sikon.common.Search;
import com.sikon.service.domain.Career;
import com.sikon.service.domain.License;
import com.sikon.service.domain.User;


 
public interface UserService {
	
	// 일반회원가입
	public void addUser(User user, Map map) throws Exception;
	// 카카오 회원가입
	public void addKakaoUser(User user, Map map) throws Exception;
	
	// id 중복체크
	public int checkId(String userId) throws Exception;
	// 닉네임 중복체크
	public int checkNickname(String userNickname) throws Exception;
	
	// 카카오 로그인할때 받아오는 토큰과 카카오 회원정보
	public String getAccessToken (String authorize_code) throws Exception;
	public HashMap<String, Object> getUserInfo(String access_Token) throws Exception;
	
	// 카카오 로그인할때 회원ID 중복체크
	public boolean checkDuplication(String userId) throws Exception;
	
	// 회원정보 가져오기
	public User getUser(String userId) throws Exception;
	// 자격증정보 가져오기
	public List getLicense(String userId) throws Exception;
	// 경력사항정보 가져오기
	public List getCareer(String userId) throws Exception;
		
	// ID찾기
	public String findUserId(String userName, String phone) throws Exception;
	
	// 쿠킹멘토 승인
	public void changeUserRole(String userId, String role) throws Exception;
	
	// 쿠킹멘토 거절
	public void backUserRole(String userId, String mentorApply) throws Exception;
		
	// 회원정보수정
	public void updateUser(User user) throws Exception;
	public void updateLicense(Map license, User user) throws Exception;
	public void updateCareer(Map career, User user) throws Exception;
	
	// 패스워드 변경
	public void updateUserPw(String userId, String password) throws Exception;
		
	// 회원정보리스트 
	public Map<String , Object> getUserList(Search search) throws Exception;
		
	// 회원탈퇴
	public void deleteUser(User user, Date quitDate, String quitStatus) throws Exception;

}