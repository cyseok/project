package com.project.dao;

import java.util.List;
import java.util.Map;
import com.project.dto.NoticeDTO;

public interface NoticeDAO {
	
	   // 공지사항 등록
	   int insertNotice(NoticeDTO notice); 
	   
	   // 공지사항 수정
	   int updateNotice(NoticeDTO notice);
	   
	   // 공지사항 삭제
	   int deleteNotice(int noticeIdx);
	 
	   // 공지사항 상세 보기
	   NoticeDTO selectNotice(int noticeIdx);
	   
	   // 공지사항 조회수 
	   int viewNoticeCount(int noticeIdx);
	   
	   // 페이징 처리 된 전체 게시글 수 조회
	   int selectNoticeCount(Map<String, Object> map); 
	   
	   // 페이징된 공지사항 목록 조회
	   List<NoticeDTO> selectNoticeList(Map<String, Object> map);
	   
}
