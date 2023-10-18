package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.NoticeDAO;
import com.project.dto.NoticeDTO;
import com.project.exception.NoticeNotFoundException;
import com.project.utill.Pager;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService{

	private final NoticeDAO noticeDAO;
	@Override
	public void addNotice(NoticeDTO notice) {
		noticeDAO.insertNotice(notice);
	}

	@Override
	public void modifyNotice(NoticeDTO notice) {
		noticeDAO.updateNotice(notice);
	}

	@Override
	public void removeNotice(int noticeIdx) {
		noticeDAO.deleteNotice(noticeIdx);
	}

	@Override
	public NoticeDTO getSelectNotice(int noticeIdx) {
		return noticeDAO.selectNotice(noticeIdx);
	}

	@Override
	public void getViewNoticeCount(int noticeIdx) {
		noticeDAO.viewNoticeCount(noticeIdx);
	}
	
	// pager 클래스 
	@Override
	public Map<String, Object> getSelectNoticeList(Map<String, Object> map) {
		
		// 전체 공지사항 개수 조회
		int totalBoard = noticeDAO.selectNoticeCount(map); 
		int pageSize = 6; //하나의 페이지에 출력될 게시글 개수 저장
		int blockSize = 5; //하나의 블럭에 출력될 개수 저장
		int pageNum=1;
		
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		Pager pager = new Pager(pageNum, totalBoard, pageSize, blockSize);
		
		map.put("startRow", pager.getStartRow());  // 시작 행 번호 추가
		map.put("endRow", pager.getEndRow());  // 마지막 행 번호 추가
		
		List<NoticeDTO> noticeList = noticeDAO.selectNoticeList(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("noticeList", noticeList);
		resultMap.put("pager", pager);
		
		if (noticeList == null) {
			throw new NoticeNotFoundException("존재하는 글이 없습니다.");
		}
		
		return resultMap; 
	}

}
