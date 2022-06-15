package com.sikon.service.ranking.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sikon.common.Search;
import com.sikon.service.domain.Recipe;
import com.sikon.service.ranking.RankingDao;


@Repository("rankingDaoImpl")
public class RankingDaoImpl implements RankingDao {

	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	/// Constructor
	public RankingDaoImpl() {
		System.out.println(this.getClass());
	}

	/// Method
	//������ �� ��¥ ����
	public void insertRecipeView(int recipeNo) throws Exception {
		sqlSession.insert("RankingMapper.addRecipeView", recipeNo);
	}
	
	public List<Recipe> getRecipeList(Search search) throws Exception {
		System.out.println("search=" + search);
		return sqlSession.selectList("RankingMapper.getRecipeList", search);
	}
	
	public int getRecipeCount(Search search) throws Exception {
		System.out.println("search=" + search);
		return sqlSession.selectOne("RankingMapper.getRecipeCount", search);
	}
	
	public List<Recipe> getCookList(Search search) throws Exception {
		System.out.println("search=" + search);
		return sqlSession.selectList("RankingMapper.getCookList", search);
	}
	
	public int getCookCount(Search search) throws Exception {
		System.out.println("search=" + search);
		return sqlSession.selectOne("RankingMapper.getCookCount", search);
	}
}