package com.sikon.web.cart;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sikon.service.domain.User;
import com.sikon.service.product.ProductService;
import com.sikon.service.domain.Cart;
import com.sikon.service.domain.Product;
import com.sikon.service.cart.CartService;



@RestController
@RequestMapping("/cart/*")
public class CartRestController {
	
	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
		
	public CartRestController(){
		System.out.println(this.getClass());
	}
	
	
	//장바구니에 상품추가하기
	@RequestMapping("json/addCart")
	public Map addCart(@RequestParam("quantity") int quantity, @RequestParam("prodNo") int prodNo, HttpSession session) throws Exception {

		System.out.println("json/addCart");
		
		User user = (User) session.getAttribute("user");
		Product product = productService.getProduct(prodNo);
		
		Cart cart = new Cart();
		cart.setUserId(user.getUserId());
		cart.setCartProd(product);
		cart.setQuantity(quantity);
		
	
		cartService.addCart(cart);
		
		Map map = new HashMap();
		map.put("response", "success");
		
		return map;
	}
	
	//장바구니 상품수량 수정
	@RequestMapping( value="json/updateCart")
	public int updateCart( @RequestParam("cartNo") int cartNo, @RequestParam("quantity") int quantity) throws Exception{
		
		System.out.println("json/updateCart");
		
		Cart cart = cartService.getCart(cartNo);
		cart.setQuantity(quantity);
		
		cartService.updateCart(cart);
		
		
		return quantity;
	}
	
	
}