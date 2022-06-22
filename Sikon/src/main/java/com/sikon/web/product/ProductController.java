package com.sikon.web.product;

import java.io.File;
import java.io.IOError;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sikon.common.Page;
import com.sikon.common.Search;
import com.sikon.service.domain.Product;
import com.sikon.service.product.ProductService;
import com.sikon.service.product.impl.ProductServiceImpl;
import com.sikon.service.review.ReviewService;


//==> 회원관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
		
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['filepath']}")
	String filePath;
	

	@RequestMapping(value="addProduct", method=RequestMethod.POST )
	public String addProduct( @ModelAttribute("product") Product product, @RequestParam("uploadfiles[]") MultipartFile[] fileArray, Model model ) throws Exception {
		
		System.out.println("/product/addProduct : POST");
		
		String temDir = filePath;
		
		String fileName = "";
		
		for(int i=0; i<fileArray.length;i++) {
		
			if(!fileArray[i].getOriginalFilename().isEmpty()) {
				fileArray[i].transferTo(new File(temDir, fileArray[i].getOriginalFilename()));
				System.out.println("파일명 :: "+fileArray[i].getOriginalFilename());
				
			}else {
				System.out.println("파일업로드 실패...?");
			}
		
			fileName+=fileArray[i].getOriginalFilename()+"&";
			
			System.out.println("저장될 파일이름 : "+fileName);
		}
				
		
		product.setProdThumbnail(fileName);
		
		System.out.println("product: "+product);
		productService.addProduct(product);
		
		model.addAttribute(product);
		
		return "forward:/product/readProduct.jsp";
	}

	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct(@ModelAttribute("search") Search search, @RequestParam("prodNo") int prodNo , @RequestParam("menu") String menu, @CookieValue(value="history", required=false) Cookie cookie,  
										HttpServletResponse response, Model model ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		System.out.println("menu: "+menu);
		
		//리뷰
		System.out.println("search:" + search);

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);

		Map map=reviewService.getReviewList(search, "PRD", prodNo);
		int reviewNum=reviewService.countReviewNum(prodNo, "PRD");
		System.out.println("리뷰수"+reviewNum);
		System.out.println("리뷰확인"+map.get("list"));
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		model.addAttribute("menu", menu);
		model.addAttribute("review", map.get("list"));
		model.addAttribute("reviewNum", reviewNum);

		
		String img = product.getProdThumbnail();
		String prod = product.getProdName().replace(" ", "_");
		String pn = "/"+prodNo+"&"+img+"&"+prod;
		String first = prodNo+"&"+img+"&"+prod;
		
		if (cookie == null) {
			
			Cookie prodCookie = new Cookie("history",first);
			prodCookie.setPath("/");
			response.addCookie(prodCookie);
					
		}else{
	
			String str1 = cookie.getValue()+ pn;
			
			Cookie prodCookie02 = new Cookie("history",str1);
			prodCookie02.setPath("/");
			response.addCookie(prodCookie02);
			
			System.out.println("Not NULL일 때 저장된 prod쿠키값"+cookie.getValue());
			System.out.println("Not NULL일 때 저장될 prod쿠키값"+str1);
		}
		
		return "forward:/product/getProduct.jsp";
	}
	


	@RequestMapping(value="updateProduct", method=RequestMethod.GET )
	public String updateProduct( @ModelAttribute("product") Product product , Model model) throws Exception{

		System.out.println("/product/updateProduct : GET");
		
		product = productService.getProduct(product.getProdNo());
		
		model.addAttribute("product", product);

		return "forward:/product/updateProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product , @RequestParam("uploadfiles[]") MultipartFile[] fileArray) throws Exception{

		System.out.println("/product/updateProduct : POST");
		
		String temDir = filePath;
		
		String fileName = "";
	
		
		for(int i=0; i<fileArray.length;i++) {
		
			if(!fileArray[i].getOriginalFilename().isEmpty()) {
				fileArray[i].transferTo(new File(temDir, fileArray[i].getOriginalFilename()));
				System.out.println("파일명 :: "+fileArray[i].getOriginalFilename());
				
			}else {
				System.out.println("파일업로드 실패...?");
			}
		
			fileName+=fileArray[i].getOriginalFilename()+"&";
			
			System.out.println("저장될 파일이름 : "+fileName);
		}
				
		
		product.setProdThumbnail(fileName);
		productService.updateProduct(product);
		
		return "redirect:/product/getProduct?prodNo="+product.getProdNo()+"&menu=manage";
	}
	
	
	@RequestMapping( value="listProduct" )
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct :  GET / POST ");
		
		System.out.println("productlist search: "+search);

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		
		if(search.getThemeCondition() == "all") {
			search.setThemeCondition(null);
		}
		
		System.out.println("Theme: "+search.getThemeCondition());
		
		Map<String , Object> map=productService.getProductList(search);
		Map<String , Object> mapName = productService.getProdNames(search);
		
		String names = "";
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("prodNames",mapName.get("list"));
		
		System.out.println("1:"+mapName);
		System.out.println("2:"+mapName.get("list"));
		
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping( value="manageProduct" )
	public String manageProduct( @ModelAttribute("search") Search search , Model model) throws Exception{
		
		System.out.println("/product/manageProduct :  GET / POST ");
		
		System.out.println("productlist search: "+search);

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(10);
		
		Map<String , Object> map=productService.getProductList(search);
		Map<String , Object> mapName = productService.getProdNames(search);
		
		String names = "";
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, 10);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("prodNames",mapName.get("list"));
		
		System.out.println("1:"+mapName);
		System.out.println("2:"+mapName.get("list"));
		
		
		return "forward:/product/manageProduct.jsp";
	}

}