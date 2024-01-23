package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@Autowired
	private final NoticeService noticeService;
	
	@Autowired
	private final WebApplicationContext context; 
	
	// 공지사항 리스트
	@GetMapping("/list")
	public ResponseEntity<Map<String, Object>> noticeList(
			@RequestParam(defaultValue = "1") int pageNum
			, @RequestParam(defaultValue = "10") int pageSize
			, @RequestParam(defaultValue = "") String selectKeyword) {
		
		try {
	        return new ResponseEntity<>(noticeService.getSelectNoticeList(pageNum, pageSize, selectKeyword), HttpStatus.OK);
	    } catch (Exception e) {
	    	return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
		
	}
	
	// 공지사항 상세보기
	@GetMapping("/detail/{noticeIdx}")
	public Map<String, Object> noticeDetail(@PathVariable("noticeIdx") int noticeIdx) {
		
		Notice notice = new Notice();
		notice.setNoticeIdx(noticeIdx);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("notice", noticeService.getSelectNotice(noticeIdx));
        resultMap.put("prevNumNextNum", noticeService.getSelectPreNumNextNum(noticeIdx));
        
		noticeService.getViewNoticeCount(noticeIdx);
		
	   return resultMap;
	}
	
	// 공지사항 삭제
	@DeleteMapping("/{noticeIdx}")
	public String noticeDelete(@PathVariable("noticeIdx") int noticeIdx) {
		noticeService.removeNotice(noticeIdx);
		return "success";
	}
	
	// 공지사항 등록 요청
	@PreAuthorize("hasRole('ROLE_MASTER')")
	@PostMapping
	public String noticeAdd(Notice notice
			, @RequestParam(value = "noticeFileUpload", required = false) MultipartFile noticeFileUpload
			, @RequestParam(value = "noticeImgUpload", required = false) MultipartFile noticeImgUpload
			, Authentication authentication) throws IllegalStateException, IOException {
		// 업로드할 디렉토리 경로 서버 디렉토리의 시스템 경로 반환
		String uploadDirectory = context.getServletContext().getRealPath("/resources/assets/images/upload"); 
		
		if (noticeFileUpload != null && !noticeFileUpload.isEmpty()) {
			try {
				// 인코딩
				String uniqueFilename = UUID.randomUUID().toString();
				//파일 저장
				noticeFileUpload.transferTo(new File(uploadDirectory, uniqueFilename));
				// 새로 업로드한 파일로 설정
				notice.setNoticeFile(uniqueFilename);
				// 업로드 파일 이름 설정
				String fileNameEncoding = noticeFileUpload.getOriginalFilename();
				notice.setNoticeFileName(fileNameEncoding);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			notice.setNoticeFile(null);
	        notice.setNoticeFileName(null);
		}
		//  사진업로드
		if (noticeImgUpload != null && !noticeImgUpload.isEmpty()) {
			
			String originalFileName = noticeImgUpload.getOriginalFilename();
			
			String fileExtension = "";
			if (originalFileName != null) {
			    int lastDotIndex = originalFileName.lastIndexOf(".");
			    if (lastDotIndex != -1) {
			        fileExtension = originalFileName.substring(lastDotIndex);
			    }
			}
			String uploadNoticeImg = UUID.randomUUID().toString() + fileExtension;

			noticeImgUpload.transferTo(new File(uploadDirectory, uploadNoticeImg));

			notice.setNoticeImg(uploadNoticeImg);
		} else {
			notice.setNoticeImg(null);
		}
		
		noticeService.addNotice(notice);
		System.out.println("Upload Directory: " + uploadDirectory);
		return "success";
	}
	
	// 공지사항 수정
	@PreAuthorize("hasRole('ROLE_MASTER')")
	@PostMapping("/{noticeIdx}")
	public String noticeModify(@ModelAttribute Notice notice
			, @PathVariable("noticeIdx") int noticeIdx
			, @RequestParam(value="noticeFileUpload", required = false) MultipartFile noticeFileUpload
			, @RequestParam(value = "noticeImgUpload" ,required = false) MultipartFile noticeImgUpload
			) throws IllegalStateException, IOException {
		
		Notice existingNotice = noticeService.getSelectNotice(noticeIdx);
		// 업로드할 디렉토리 경로 서버 디렉토리의 시스템 경로 반환
		String uploadDirectory = context.getServletContext().getRealPath("/resources/assets/images/upload");
		
		if (noticeFileUpload != null && !noticeFileUpload.isEmpty()) {
			try {
				String uniqueFilename = UUID.randomUUID().toString();
				//String filePath = uploadDirectory + File.separator + uniqueFilename;
				//파일 저장
				noticeFileUpload.transferTo(new File(uploadDirectory, uniqueFilename));
				// 새로 업로드한 파일로 설정
				notice.setNoticeFile(uniqueFilename);
				// 업로드 파일 이름 설정
				String fileNameEncoding = noticeFileUpload.getOriginalFilename();
				notice.setNoticeFileName(fileNameEncoding);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			notice.setNoticeFile(existingNotice.getNoticeFile());
			notice.setNoticeFileName(existingNotice.getNoticeFileName());
		}
		//  사진업로드
		if (noticeImgUpload != null && !noticeImgUpload.isEmpty()) {
			// 사진 저장
			String originalFileName = noticeImgUpload.getOriginalFilename();
			
			String fileExtension = "";
			if (originalFileName != null) {
			    int lastDotIndex = originalFileName.lastIndexOf(".");
			    if (lastDotIndex != -1) {
			        fileExtension = originalFileName.substring(lastDotIndex);
			    }
			}
			String uploadNoticeImg = UUID.randomUUID().toString() + fileExtension;

			noticeImgUpload.transferTo(new File(uploadDirectory, uploadNoticeImg));

			notice.setNoticeImg(uploadNoticeImg);
		} else {
			notice.setNoticeImg(null);
		}
		
	    // 공지사항 수정 
	    noticeService.modifyNotice(notice);
		
		return "success";
		
	}
	

	

}
