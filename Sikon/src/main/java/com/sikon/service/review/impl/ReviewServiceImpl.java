package com.sikon.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.sikon.common.Search;
import com.sikon.service.domain.Review;
import com.sikon.service.review.ReviewDao;
import com.sikon.service.review.ReviewService;;

//리뷰 서비스 구현
@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

	/// Field
	@Autowired
	@Qualifier("reviewDaoImpl")
	private ReviewDao reviewDao;

	public void setReviewDao(ReviewDao reviewDao) {
		this.reviewDao = reviewDao;
	}

	/// Constructor
	public ReviewServiceImpl() {
		System.out.println(this.getClass());
	}

	/// Method
	public void addReview(Review review) throws Exception {

		reviewDao.addReview(review);
	}

	public Map<String, Object> getReviewList(Search search, String category, int textNo) throws Exception {

		List<Review> list = reviewDao.getReviewList(search, category, textNo);
		int totalCount = reviewDao.getTotalCount(search, category, textNo);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	public void updateReview(Review review) throws Exception {

		reviewDao.updateReview(review);
	}

	public void deleteReview(int reviewNo) throws Exception {

		reviewDao.deleteReview(reviewNo);

	}

	public void updateStatus(int textNo, String category) throws Exception {
		reviewDao.updateStatus(textNo, category);

	}

	public Map<String, Object> getMyReviewList(Search search, String writerNickname) throws Exception {

		List<Review> list = reviewDao.getMyReviewList(search, writerNickname);
		int totalCount = reviewDao.getTotalMyCount(search, writerNickname);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	public Review getReview(int reviewNo) throws Exception {
		return reviewDao.getReview(reviewNo);

	}

	public void updateReviewNum(int count, int recipeNo) throws Exception {
		reviewDao.updateReviewNum(count, recipeNo);

	}

	public int countReviewNum(int textNo, String category) throws Exception {
		return reviewDao.countReviewNum(textNo, category);
	}

}