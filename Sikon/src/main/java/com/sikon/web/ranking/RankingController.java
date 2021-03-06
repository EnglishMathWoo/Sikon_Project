package com.sikon.web.ranking;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sikon.common.Search;
import com.sikon.service.ranking.RankingService;


@Controller
@RequestMapping("/ranking/*")
public class RankingController {

	///Field
	@Autowired
	@Qualifier("rankingServiceImpl")
	private RankingService rankingService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	
	///Constructor
	public RankingController() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@RequestMapping(value = "listRecipe")
	public String listRecipe( @ModelAttribute("search") Search search, Model model ) throws Exception {

		System.out.println("/ranking/listRecipe");
				
		search.setPageSize(pageSize);
		
		Map<String, Object> map = rankingService.getRecipeList(search);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);

		return "forward:/ranking/listRecipeRanking.jsp";
	}
	
	@RequestMapping(value = "listProduct")
	public String listProduct( @ModelAttribute("search") Search search, Model model ) throws Exception {

		System.out.println("/ranking/listProduct");

		search.setPageSize(pageSize);
			
		Map<String, Object> map = rankingService.getProductList(search);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);

		return "forward:/ranking/listProductRanking.jsp";
	}
	
	@RequestMapping(value = "listMentor")
	public String listMentor( @ModelAttribute("search") Search search, Model model ) throws Exception {

		System.out.println("/ranking/listMentor");
			
		search.setPageSize(pageSize);
			
		Map<String, Object> map = rankingService.getLoveList(search);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);

		return "forward:/ranking/listMentorRanking.jsp";
	}

}