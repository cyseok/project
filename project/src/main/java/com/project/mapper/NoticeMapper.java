package com.project.mapper;

import java.util.List;
import java.util.Map;
import com.project.dto.NoticeDTO;

public interface NoticeMapper {
	
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
	   
	   // 전체 게시글 수 조회(페이징)
	   int selectNoticeCount(Map<String, Object> map); 
	   
	   // 페이징된 게시글 리스트 조회
	   List<NoticeDTO> selectNoticeList(Map<String, Object> map);
	   
}
