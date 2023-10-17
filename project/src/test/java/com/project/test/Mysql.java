package com.project.test;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class Mysql {
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		/*
		try(Connection con = 
				DriverManager.getConnection(
						"jdbc:mysql://wcwimj6zu5aaddlj.cbetxkdyhwsb.us-east-1.rds.amazonaws.com:3306/r8u2n4j10c73bvkm?serverTimezone=UTC",
						"i6eqgj8l9920k7q7",
						"svtfuithtubdhpoj")){
			System.out.println(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
		*/
	}
	
}