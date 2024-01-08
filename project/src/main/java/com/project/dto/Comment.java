package com.project.dto;

import lombok.Data;

@Data
public class Comment {
	private int commentIdx;  // pk
	private int postIdx; // fk (Post 클래스) 
	private String userinfoId; // fk(Userinfo 클래스 id) 작성자 ID
	private String nickname; // fk(Userinfo 클래스 nickname) 작성자 닉네임
	private int parentIdx; // 부모 댓글의 commentIdx
	private String commentContent;  // 내용 
	private String commentRegdate;  // 작성일 
	private int commentStatus; // 상태등록(1:작성글, 0: 삭제글...)

}
