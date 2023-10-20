package com.project.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class QaAnswer {
	
	private int noticeIdx;  // pk
	private String noticeTitle;  // 제목 
	private String noticeContent;  // 내용 
	private String noticeRegdate;  // 등록일 
    private String noticeImg;  // 썸네일 or 사진
	private int noticeViewcnt;  // 조회수 
	private MultipartFile noticeFile;  // 첨부파일
	private int noticeStatus; // 상태등록(1:진행중, 2:종료 or 삭제...)
	private int prevNum; // 이전글의 글 번호 저장 
	private int nextNum; // 다음글의 글 번호 저장

}
