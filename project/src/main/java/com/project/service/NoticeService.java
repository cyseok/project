package com.project.service;

import java.util.Map;

import com.project.dto.Notice;

public interface NoticeService {
	
	// 공지사항 등록
	void addNotice(Notice notice); 
	   
	// 공지사항 수정
	void modifyNotice(Notice notice);
	   
	// 공지사항 삭제
	void removeNotice(int noticeIdx);
	 
	// 공지사항 상세 보기
	Notice getSelectNotice(int noticeIdx);
	   
	// 공지사항 조회수 
	void getViewNoticeCount(int noticeIdx);
	   
	// 공지사항 리스트 조회 (페이징 처리 + 검색 기능)
    Map<String, Object> getSelectNoticeList(int pageNum, int pageSize, String selectKeyword);
       
    // 상세보기 페이지에서 이전 글 번호와 다음 글 번호 저장
    Notice getSelectPreNumNextNum(int idx);

}
