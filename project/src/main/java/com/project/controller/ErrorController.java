package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ErrorController {

	@GetMapping("/error")
	public String diyAdd() {
		return "/error";
	}

}
