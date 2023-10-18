package com.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.mapper.NoticeMapper;
import com.project.dto.NoticeDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class NoticeDAOImpl implements NoticeDAO{
	private final SqlSession sqlSession;
	
	// 공지사항 등록
	@Override
	public int insertNotice(NoticeDTO notice) {
		return sqlSession.getMapper(NoticeMapper.class).insertNotice(notice);
	}

	// 공지사항 수정
	@Override
	public int updateNotice(NoticeDTO notice) {
		return sqlSession.getMapper(NoticeMapper.class).updateNotice(notice);
	}
	
	// 공지사항 삭제
	@Override
	public int deleteNotice(int noticeIdx) {
		return sqlSession.getMapper(NoticeMapper.class).deleteNotice(noticeIdx);
	}

	// 공지사항 상세 보기
	@Override
	public NoticeDTO selectNotice(int noticeIdx) {
		return sqlSession.getMapper(NoticeMapper.class).selectNotice(noticeIdx);
	}

	// 공지사항 조회수 
	@Override
	public int viewNoticeCount(int noticeIdx) {
		return sqlSession.getMapper(NoticeMapper.class).viewNoticeCount(noticeIdx);
	}

	// 전체 게시글 수 조회
	@Override
	public int selectNoticeCount(Map<String, Object> map) {
		return sqlSession.getMapper(NoticeMapper.class).selectNoticeCount(map);
	}

	// 페이징된 게시글 리스트 조회
	@Override
	public List<NoticeDTO> selectNoticeList(Map<String, Object> map) {
		return sqlSession.getMapper(NoticeMapper.class).selectNoticeList(map);
	}


}
