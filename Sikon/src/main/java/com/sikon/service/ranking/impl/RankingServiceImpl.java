package com.sikon.service.ranking.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.sikon.common.Search;
import com.sikon.service.coupon.CouponDao;
import com.sikon.service.coupon.CouponService;
import com.sikon.service.domain.Coupon;
import com.sikon.service.domain.Recipe;
import com.sikon.service.ranking.RankingDao;
import com.sikon.service.ranking.RankingService;


@Service("rankingServiceImpl")
public class RankingServiceImpl implements RankingService{
	
	///Field
	@Autowired
	@Qualifier("rankingDaoImpl")
	private RankingDao rankingDao;

	
	/// Constructor
	public RankingServiceImpl() {
		System.out.println(this.getClass());
	}


	///Method
	//������ �� ��¥ ����
	public void addRecipeView(int recipeNo) throws Exception {
		rankingDao.insertRecipeView(recipeNo);
	}
	
	//������ ����Ʈ ��ȸ
	public Map<String, Object> getRecipeList(Search search) throws Exception {
		System.out.println("search=" + search);
		List<Recipe> list = rankingDao.getRecipeList(search);
		int totalCount = rankingDao.getRecipeCount(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		System.out.println("list=" + list);

		return map;
	}
	
	// ��ŷŬ���� ����Ʈ ��ȸ
	public Map<String, Object> getCookList(Search search) throws Exception {
		System.out.println("search=" + search);
		List<Recipe> list = rankingDao.getCookList(search);
		int totalCount = rankingDao.getCookCount(search);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		System.out.println("list=" + list);

		return map;
	}

}