package com.project.controller;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.nio.charset.Charset;

import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;


@RestController
@RequestMapping(value="/naver")
public class NaverSearchController {
	
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
        
        // 방법1
        RequestEntity<Void> req = RequestEntity
                .get(uri)
                .header("X-Naver-Client-Id", clientId)
                .header("X-Naver-Client-Secret", clientSecret)
                .header("Content-Type", "application/json; charset=UTF-8")
                .build();
        
        RestTemplate restTemplate = new RestTemplate();
        
        ResponseEntity<String> responseEntity = restTemplate.exchange(req, String.class);
        
        String responseBody = responseEntity.getBody();
        
        /*
        // 방법 2
        HttpHeaders headers = new HttpHeaders();
        	headers.set("X-Naver-Client-Id", clientId);
        	headers.set("X-Naver-Client-Secret", clientSecret);
            headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Void> requestEntity = new HttpEntity<>(headers);
        
        RestTemplate restTemplate = new RestTemplate();
        
        ResponseEntity<String> responseEntity = restTemplate.exchange(uri, HttpMethod.GET, requestEntity, String.class);
        
        String responseBody = responseEntity.getBody();
         */
        
        
        /* 방법 3
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
         */
        
        System.out.println("API Response: " + responseBody);
        System.out.println("API searchText: " + searchText);
        System.out.println("API uri: " + uri);
        
        return ResponseEntity.ok(responseBody);
	}
}
