package com.project.eatda.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MarketController {
	private static final Logger logger = LoggerFactory.getLogger(MarketController.class);
	
	@RequestMapping("/test.do")
	public String test() {
		System.out.println("test");
		return "/market/marketMain";
	}
	
	@RequestMapping("/page.do")
	public String test2() {
		System.out.println("test2");
		return "/market/marketPage";
	}
	
	@RequestMapping("/shoppingbag.do")
	public String test3() {
		System.out.println("test3");
		return "/market/shoppingBag";
	}
	
	@RequestMapping("/orderSuccess.do")
	public String test4() {
		System.out.println("test4");
		return "/market/orderSuccess";
	}
	
	@RequestMapping("/payment.do")
	public String test5() {
		System.out.println("test5");
		return "/market/payment";
	}

}
