package com.sikon.web.ranking;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sikon.common.Page;
import com.sikon.common.Search;
import com.sikon.service.recipe.RecipeService;

//��ŷ Controller
@Controller
@RequestMapping("/ranking/*")
public class RankingController {

	/// Field
	@Autowired
	@Qualifier("recipeServiceImpl")
	private RecipeService recipeService;

	public RankingController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	
	@RequestMapping(value = "listRecipe")
	public String listRecipe(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {

		System.out.println("/ranking/listRecipe :  POST/get");

		System.out.println("search:" + search);
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		if(search.getSearchCondition()==null) {
			search.setSearchCondition("0");
		}

		if (search.getOrderCondition() == null) {
			search.setOrderCondition("4");
		}
		
		search.setPageSize(pageSize);
			

		// Business logic ����
		Map<String, Object> map = recipeService.getRecipeList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		System.out.println("list=" + map.get("list"));
		System.out.println("resultPage=" + resultPage);

		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/ranking/listRecipe.jsp";
	}
}