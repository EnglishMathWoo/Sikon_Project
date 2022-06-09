package com.sikon.service.heart;

import java.util.List;

import com.sikon.common.Search;
import com.sikon.service.domain.Heart;
import com.sikon.service.domain.Wish;



public interface HeartDao {
	

	public void updateHeart (int cookNo) throws Exception;
	
	public void updateHeartCancel(int cookNo) throws Exception;
	
	
	public void insertHeart(int cookNo,String userId) throws Exception;
	
	public void deleteHeart(int cookNo,String userId) throws Exception;
	
	public int heartCheck(int cookNo,String userId) throws Exception;
	
	public void updateHeartCheck(int cookNo,String userId) throws Exception;
	
	public void updateHeartCheckCancel(int cookNo,String userId) throws Exception;
	
	public List<Heart> getHeart(Search search,String userId) throws Exception;
	
	public int getTotalCount(Search search,String userId) throws Exception ;
	
	public List<Heart> getHeart2(int cookNo, String userId) throws Exception;
	
	
	
}