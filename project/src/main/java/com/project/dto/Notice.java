package com.project.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
   Field	    Type 	        Null	Key	    Default	     Extra
notice_idx   	int       	    NO	    PRI  	NULL	    auto_increment
userinfo_id	    varchar(50)	    YES	    MUL     NULL	
notice_title	varchar(1000)	YES             NULL	
notice_content	varchar(4000)	YES		        NULL	
notice_regDate	date	        YES		        curdate()	DEFAULT_GENERATED
notice_viewcnt	int	            YES		        0	
notice_status	char(1)	        YES		        1	
*/

@Data
public class Notice {
	
	private int rownum;  // pk
	private int noticeIdx;  // pk
	private String noticeTitle;  // 제목 
	private String noticeContent;  // 내용 
	private String noticeRegdate;  // 등록일 
    private String noticeImg;  // 썸네일 or 사진
	private int noticeViewcnt;  // 조회수 
	private String noticeFile;  // 첨부파일 저장
	private String noticeFileName;  // 첨부이름 저장
	private MultipartFile noticeFileUpload;  // 첨부파일 업로드
	private int noticeStatus; // 상태등록(1:진행중, 2:종료 or 삭제...)
	private int prevNum; // 이전글의 글 번호 저장 
	private int nextNum; // 다음글의 글 번호 저장
	
}
