package com.project.controller;

import java.net.URI;
import java.nio.charset.Charset;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

@RestController
@RequestMapping("/naver")
public class NaverSearch {
	
	@GetMapping("/search")
	public ResponseEntity<JSONObject> naverSearchList(@RequestParam String text
            , @RequestParam(defaultValue = "1") int start
            , @RequestParam(defaultValue = "5") int display
            , @RequestParam(defaultValue = "random") String sort) throws JsonMappingException, JsonProcessingException, ParseException {
		
		// 네이버 검색 API 요청
		String clientId = "lLK4tKRRKZzB3p_z8n5e"; 		
        String clientSecret = "H3jKWKwxmm";
        
        // https://openapi.naver.com/v1/search/local.json?
        //          query=프롬상록&display=10&start=1&sort=random
        String uri = UriComponentsBuilder
      		  .fromUriString("https://openapi.naver.com")
      		  .path("/v1/search/local.json")
      		  .queryParam("query", text)
      		  .queryParam("display", 10)
      		  .queryParam("start", 1)
      		  .queryParam("sort", "random")
      		  .toUriString();
        
        // 방법 1
        WebClient webClient = WebClient.builder()
        		.baseUrl(uri)
        		// .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
        		.defaultHeader("X-Naver-Client-Id", clientId)
        		.defaultHeader("X-Naver-Client-Secret", clientSecret)
        		.build();
        
        String responseBody = webClient.get()
        		.retrieve()
        		.bodyToMono(String.class)
        		.block();
        
        //JSONParser 객체 : JSON 형식의 문자열을 JSON 객체로 변환
  		JSONParser parser=new JSONParser();
  		//JSONParser.parse(String json) : JSON 형식의 문자열을 Object 객체로 변환
  		Object object=parser.parse(responseBody);
  		//Object 객체로 JSONObject 객체로 변환하여 저장
  		JSONObject jsonObject=(JSONObject)object;
  		
        System.out.println("Naver Search API Response: " + responseBody);
        
        // 방법 2
        /*
        RestTemplate restTemplate = new RestTemplate();
        
        RequestEntity<Void> req = RequestEntity
                .get(uri)
                .header("X-Naver-Client-Id", clientId)
                .header("X-Naver-Client-Secret", clientSecret)
                .build();
        
        ResponseEntity<String> responseEntity = restTemplate.exchange(req, String.class);
        
        String responseBody = responseEntity.getBody();
        */
        
        return ResponseEntity.ok(jsonObject);
	}
	
}
