package com.project.controller;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.nio.charset.Charset;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriComponentsBuilder;

import com.project.service.NoticeService;

import lombok.RequiredArgsConstructor;
import reactor.core.scheduler.Schedulers;


@RestController
@RequiredArgsConstructor
@RequestMapping(value="/naver")
public class NaverSearchController {
	
	/*
	// 방법 1, 2, 3
	@GetMapping(value = "/search", produces = "application/json; charset=UTF-8")
	public ResponseEntity<String> naverSearchList(@RequestParam(name = "text") String searchText) throws UnsupportedEncodingException  {
		
		String clientId = "lLK4tKRRKZzB3p_z8n5e"; 		
        String clientSecret = "H3jKWKwxmm";
        
        URI uri = UriComponentsBuilder
      		  .fromUriString("https://openapi.naver.com")
      		  .path("/v1/search/local.json")
      		  .queryParam("query", searchText)
      		  .queryParam("display", 5)
      		  .queryParam("start", 1)
      		  .queryParam("sort", "random")
      		  .encode(Charset.forName("UTF-8"))
      		  .build()
              .toUri();
        
        // 방법1 RequestEntity 헤더 / RestTemplate
//        RequestEntity<Void> req = RequestEntity
//                .get(uri)
//                .header("X-Naver-Client-Id", clientId)
//                .header("X-Naver-Client-Secret", clientSecret)
//                .header("Content-Type", "application/json; charset=UTF-8")
//                .build();
//        
//        RestTemplate restTemplate = new RestTemplate();
//        
//        ResponseEntity<String> responseEntity = restTemplate.exchange(req, String.class);
//        
//        String responseBody = responseEntity.getBody();
        
        // 방법 2 HttpHeaders 헤더 / RestTemplate
//        HttpHeaders headers = new HttpHeaders();
//        	headers.set("X-Naver-Client-Id", clientId);
//        	headers.set("X-Naver-Client-Secret", clientSecret);
//            headers.setContentType(MediaType.APPLICATION_JSON);
//
//        HttpEntity<Void> requestEntity = new HttpEntity<>(headers);
//        
//        RestTemplate restTemplate = new RestTemplate();
//        
//        ResponseEntity<String> responseEntity = restTemplate.exchange(uri, HttpMethod.GET, requestEntity, String.class);
//        
//        String responseBody = responseEntity.getBody();
        
        
        // 방법 3 WebClient 사용===============================
        WebClient webClient = WebClient.builder()
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .defaultHeader("X-Naver-Client-Id", clientId)
                .defaultHeader("X-Naver-Client-Secret", clientSecret)
                .build();

        ResponseEntity<String> responseEntity = webClient.get()
                .uri(uri)
                .retrieve()
                .toEntity(String.class)
                .block();
        
        String responseBody = responseEntity.getBody();
        
        System.out.println("API Response: " + responseBody);
        System.out.println("API searchText: " + searchText);
        System.out.println("API uri: " + uri);
        
        return ResponseEntity.ok(responseBody);
	}
	*/
	
	
	private final WebClient webClient;
	
	// 방법 4 DeferredResult 클래스를 이용한 비동기 방식
	// 왜 키가 없어도 동작하지....?????
	@GetMapping(value = "/search", produces = "application/json; charset=UTF-8")
	public DeferredResult<ResponseEntity<String>> naverSearchList(@RequestParam(name = "text") String searchText) throws UnsupportedEncodingException  {
		
		DeferredResult<ResponseEntity<String>> deferredResult = new DeferredResult<>();

        
        URI uri = UriComponentsBuilder
      		  .fromUriString("https://openapi.naver.com")
      		  .path("/v1/search/local.json")
      		  .queryParam("query", searchText)
      		  .queryParam("display", 5)
      		  .queryParam("start", 1)
      		  .queryParam("sort", "random")
      		  .encode(Charset.forName("UTF-8"))
      		  .build()
              .toUri();
        

        webClient.get()
        .uri(uri)
        .retrieve()
        .bodyToMono(String.class)
        .subscribeOn(Schedulers.boundedElastic())
        .subscribe(
                result -> {
                    System.out.println("API Response: " + result);
                    ResponseEntity<String> responseEntity = ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(result);
                deferredResult.setResult(responseEntity);
                },
                error -> {
                    System.err.println("API Error: " + error.getMessage());
                    ResponseEntity<String> errorResponse = ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body("error : " + error.getMessage());
                deferredResult.setErrorResult(errorResponse);
                }
            );

        return deferredResult;
	}
}