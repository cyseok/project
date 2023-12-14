package com.project.util;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

public class CorsFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// Cast ServletResponse to HttpServletResponse
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Allow requests from specific origins
        httpResponse.setHeader("Access-Control-Allow-Origin", "http://www.waiting-check.com");

        // Allow specific headers and methods
        httpResponse.setHeader("Access-Control-Allow-Headers", "Content-Type");
        httpResponse.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS, PUT, DELETE");

        // Allow credentials
        httpResponse.setHeader("Access-Control-Allow-Credentials", "true");

        // Continue the filter chain
        chain.doFilter(request, response);
	}

}
