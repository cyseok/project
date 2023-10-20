package com.project.dao;

import java.util.List;
import java.util.Map;

import com.project.dto.Notice;

public interface NoticeDAO {
	
    // 공지사항 등록
    int insertNotice(Notice notice); 
   
    // 공지사항 수정
    int updateNotice(Notice notice);
   
    // 공지사항 삭제
    int deleteNotice(int noticeIdx);
 
    // 공지사항 상세 보기
    Notice selectNotice(int noticeIdx);
   
    // 공지사항 조회수 
    int viewNoticeCount(int noticeIdx);
   
    // 페이징 처리 된 전체 게시글 수 조회
    int selectNoticeCount(String selectKeyword); 
   
    // 페이징된 공지사항 목록 조회
    List<Notice> selectNoticeList(Map<String, Object> map);
    
    // 상세보기 페이지에서 이전 글 번호와 다음 글 번호 저장
    Notice selectPreNumNextNum(int idx);
	   
}
