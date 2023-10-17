package com.project.dto;

import lombok.Data;

@Data
public class NoticeDTO {
	
	private int noticeIdx;  // pk
	private String userinfoId;  // Userinfo table Join fk
	private String noticeTitle;  // 제목 
	private String noticeContent;  // 내용 
	private String noticeRegDate;  // 등록일 
	private int noticeViewcnt;  // 조회수 
	private int noticeStatus; // 상태등록(1:진행중, 2:종료...)
	// 페이징 할 때 쓰기 
	private int prevnum; // 이전글의 글번호
	private int nextnum; // 다음글의 글번호
}
