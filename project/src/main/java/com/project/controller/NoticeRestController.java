package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import com.project.dto.Notice;
import com.project.service.NoticeService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeRestController {
	
	private final NoticeService noticeService;
	private final WebApplicationContext context; //파일 업로드
	
	// 공지사항 리스트
	@GetMapping("/list")
	public Map<String, Object> noticeList(
			@RequestParam(defaultValue = "1") int pageNum
			, @RequestParam(defaultValue = "10") int pageSize
			, @RequestParam(defaultValue = "") String selectKeyword) {
		return noticeService.getSelectNoticeList(pageNum, pageSize, selectKeyword);
	}
	
	// 공지사항 수정
	// ROLE_ADMIN만 공지사항 수정 가능
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PatchMapping("/{noticeIdx}")
	public String noticeModify(@ModelAttribute Notice notice
			, @RequestParam(value="noticeFile", required = false) MultipartFile noticeFileUpload
			, @RequestParam(value = "noticeImg" ,required = false) MultipartFile noticeImg 
			) throws IllegalStateException, IOException {
		
		// => 파일 업로드 방법 
		// notice 테이블의  notice_idx로 기존의 정보를 가져옴
		Notice existingNotice = noticeService.getSelectNotice(notice.getNoticeIdx());
		
			if(!noticeFileUpload.isEmpty()) {
				   String uploadDirectory = context.getServletContext().getRealPath("/resources/upload"); // 업로드할 디렉토리 경로
	               String originalFilename = noticeFileUpload.getOriginalFilename();
	               String uniqueFilename = UUID.randomUUID().toString() + "_" + originalFilename;
	               //String filePath = uploadDirectory + File.separator + uniqueFilename;

	               // 새로 업로드한 파일로 설정
	               notice.setNoticeFile(uniqueFilename);
	               
	               // 파일 저장
	               noticeFileUpload.transferTo(new File(uploadDirectory, uniqueFilename));

            } else {
               // 파일이 업로드되지 않았을 때 기존 파일 정보를 그대로 사용
               notice.setNoticeFile(existingNotice.getNoticeFile());
            }
		
	    //============================================================
		// =>︎ 사진 업로드 방법 
	    // 전달파일(사진)을 저장하기 위한 서버 디렉토리의 시스템 경로 반환
		String uploadDirectory = context.getServletContext().getRealPath("/resources/upload");
		
		String uploadNoticeImg = UUID.randomUUID().toString()+"-"+noticeImg.getOriginalFilename();
		notice.setNoticeImg(uploadNoticeImg);
		
		// 파일 업로드 처리 - 서버에 넣음
		noticeImg.transferTo(new File(uploadDirectory, uploadNoticeImg));
		
	    // 공지사항 수정 
	    noticeService.modifyNotice(notice);
		
		return "success";
		
	}
	
	// 공지사항 등록 요청
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping
	public String noticeModisadfy(@ModelAttribute Notice notice
			, @RequestParam(value="noticeFile", required = false) MultipartFile noticeFileUpload
			, @RequestParam(value = "noticeImg" ,required = false) MultipartFile noticeImg
			) throws IllegalStateException, IOException {
		
		// 첨부 파일을 저장하기 위한 서버 디렉토리의 시스템 경로 반환
		String uploadDirectory = context.getServletContext().getRealPath("/resources/upload"); // 업로드할 디렉토리 경로
        String originalFilename = noticeFileUpload.getOriginalFilename();
        String uniqueFilename = UUID.randomUUID().toString() + "_" + originalFilename;
        //String filePath = uploadDirectory + File.separator + uniqueFilename;

        // 새로 업로드한 파일로 설정
        notice.setNoticeFile(uniqueFilename);
        
        // 파일 저장
        noticeFileUpload.transferTo(new File(uploadDirectory, uniqueFilename));
		
		//============================================================
		// 사진 저장
		String uploadNoticeImg = UUID.randomUUID().toString()+"-"+noticeImg.getOriginalFilename();
		notice.setNoticeImg(uploadNoticeImg);
		
		// 파일 업로드 처리 - 서버에 넣음
		noticeImg.transferTo(new File(uploadDirectory, uploadNoticeImg));
		
		noticeService.modifyNotice(notice);
		
		return "success";
	}

	

}
