package com.project.dto;

import org.springframework.hateoas.RepresentationModel;

import lombok.Data;
import lombok.EqualsAndHashCode;
@EqualsAndHashCode(callSuper=true)
@Data
public class Post extends RepresentationModel<Post> {
	
	private int rownum;  // ROWNUM 번호 
	private int postIdx;  // pk
	private String userinfoId;  // fk (userinfo 테이블 id)
	private String postTitle;  // 게시글 제목
	private String postContent;  // 게시글 내용 (editor 사용)
	private String postLoc; // 지역이름
	private int postDayType; // 1 : 평일, 2 : 공휴일+주말
    private int postTag; // 1:사람이없어요, 2:웨이팅없어요, 3:웨이팅보통(약30분), 4:웨이팅많아요(1시간이상)
    private String postRegdate; // 게시글 등록일 
    private int postViewCount; // 게시글 조회수
    private int postLikes; // 게시글 추천수
    private int postStatus; // 1:작성글, 0:삭제글
    private int prevnum; // 이전글 번호 
	private int nextnum; // 다음글 번호
	private int conmmentCount;  // 댓글 수
    
}
