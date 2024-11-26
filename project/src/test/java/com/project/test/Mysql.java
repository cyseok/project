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
		
		try(Connection con = 
				DriverManager.getConnection(
						//"jdbc:mysql://database-1.c4036o3cjyhj.ap-northeast-2.rds.amazonaws.com:3306/test?serverTimezone=UTC",
						"jdbc:log4jdbc:mysql://waiting-rds.c3qu0gcwopn7.ap-northeast-2.rds.amazonaws.com:3306/test?serverTimezone=UTC",
						"admin",
						"!dbstjr8879")){
			/*
			DriverManager.getConnection(
						"jdbc:mysql://3.39.12.166:3306/sys?serverTimezone=UTC",
						"yunseok",
						"dbstjr8879")){
			 */
			System.out.println(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
		
	}
	
}