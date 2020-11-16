package com.market.gaji.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {
	
	@RequestMapping("test")
	public String test() {
		return "test";
	}

	@RequestMapping("foot")
	public String foot() {
		return "foot";
	}
	
	@RequestMapping("head")
	public String head() {
		return "includes/header2";
	}
	
	@RequestMapping("test2")
	public String test2() {
		return "test2";
	}
	
	
	
}
