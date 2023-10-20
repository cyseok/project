package com.project.dto;

import lombok.Data;

@Data
public class Qa {
	
	private int qaIdx;  // pk
	private String userinfoId;  // pk
	private String qaTitle;  // 제목 
	private String qaContent;  // 내용 
	private String qaRegdate;  // 등록일 
    private String qaImg;  // 사진
	private int qaViewcnt;  // 조회수 
	private int qaStatus; // 상태등록(1:작성글, 2:삭제)

}
