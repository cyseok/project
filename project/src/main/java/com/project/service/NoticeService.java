package com.project.service;

import java.util.Map;

import com.project.dto.NoticeDTO;

public interface NoticeService {
	
	   // 공지사항 등록
	   void addNotice(NoticeDTO notice); 
	   
	   // 공지사항 수정
	   void modifyNotice(NoticeDTO notice);
	   
	   // 공지사항 삭제
	   void removeNotice(int noticeIdx);
	 
	   // 공지사항 상세 보기
	   NoticeDTO getSelectNotice(int noticeIdx);
	   
	   // 공지사항 조회수 
	   void getViewNoticeCount(int noticeIdx);
	   
	   // 공지사항 리스트 조회 (페이징 처리 + 검색 기능)
       Map<String, Object> getSelectNoticeList(Map<String, Object> map);

}
