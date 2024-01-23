package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.NoticeDAO;
import com.project.dto.Notice;
import com.project.exception.NoticeNotFoundException;
import com.project.util.Pager;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService{

	private final NoticeDAO noticeDAO;
	@Override
	public void addNotice(Notice notice) {
		noticeDAO.insertNotice(notice);
	}

	@Override
	public void modifyNotice(Notice notice) {
		noticeDAO.updateNotice(notice);
	}

	@Override
	public void removeNotice(int noticeIdx) {
		noticeDAO.deleteNotice(noticeIdx);
	}

	@Override
	public Notice getSelectNotice(int noticeIdx) {
		return noticeDAO.selectNotice(noticeIdx);
	}

	@Override
	public void getViewNoticeCount(int noticeIdx) {
		noticeDAO.viewNoticeCount(noticeIdx);
	}
	
	// Pager 클래스 사용
	@Override
	public Map<String, Object> getSelectNoticeList(int pageNum, int pageSize, String selectKeyword) {
		
		int totalBoard = noticeDAO.selectNoticeCount(selectKeyword); // 전체 공지사항 개수 조회
    	int blockSize = 5; // 페이지 블록 크기
    	
    	Pager pager = new Pager(pageNum, totalBoard, pageSize, blockSize);
    	
    	Map<String, Object> pageMap = new HashMap<String, Object>(); 
		pageMap.put("startRow", pager.getStartRow());  // 시작 행 번호 추가
		pageMap.put("endRow", pager.getEndRow());  // 마지막 행 번호 추가
		pageMap.put("totalBoard", pager.getTotalBoard());  // 전체 글 개수
		pageMap.put("selectKeyword", selectKeyword);  // 검색 키워드 추가
    	
		List<Notice> noticeList = noticeDAO.selectNoticeList(pageMap);
		
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("noticeList", noticeList);
        resultMap.put("pager", pager);
        
        if (noticeList == null) {
			throw new NoticeNotFoundException("공지사항이 없습니다.");
		}
        
        return resultMap;
		
	}

	@Override
	public Notice getSelectPreNumNextNum(int idx) {
		return noticeDAO.selectPreNumNextNum(idx);
	}

}
