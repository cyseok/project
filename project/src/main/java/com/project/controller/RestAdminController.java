package com.project.controller;

import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.UserinfoService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/admin")
@RequiredArgsConstructor
public class RestAdminController {
	
	private final UserinfoService userinfoService;
	
	@GetMapping("/userinfo-list")
	public Map<String, Object> getUserinfos(@RequestParam(defaultValue = "1") int pageNum, 
											@RequestParam(defaultValue = "20") int pageSize) {
		return userinfoService.getUserinfoList(pageNum, pageSize);
	}

}
