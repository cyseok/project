package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import com.project.dto.Notice;
import com.project.security.CustomUserDetails;
import com.project.service.NoticeService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeRestController {
	
	private final NoticeService noticeService;
	private final WebApplicationContext context; 
	
	// 공지사항 리스트
	@GetMapping("/list")
	public Map<String, Object> noticeList(
			@RequestParam(defaultValue = "1") int pageNum
			, @RequestParam(defaultValue = "10") int pageSize
			, @RequestParam(defaultValue = "") String selectKeyword) {
		
		return noticeService.getSelectNoticeList(pageNum, pageSize, selectKeyword);
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
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping
	public String noticeAdd(@ModelAttribute Notice notice
			, @RequestParam("noticeFileUpload") MultipartFile noticeFileUpload
			, @RequestParam("noticeImgUpload") MultipartFile noticeImgUpload
			, Authentication authentication) throws IllegalStateException, IOException {
		// 업로드할 디렉토리 경로 서버 디렉토리의 시스템 경로 반환
		String uploadDirectory = context.getServletContext().getRealPath("/resources/upload"); 
		
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
	        notice.setNoticeFileName("null");
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
			notice.setNoticeImg("null");
		}
		
		noticeService.addNotice(notice);
		
		return "success";
	}
	
	// 공지사항 수정
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PatchMapping("/{noticeIdx}")
	public String noticeModify(@ModelAttribute Notice notice
			, @PathVariable("noticeIdx") int noticeIdx
			, @RequestParam(value="noticeFileUpload", required = false) MultipartFile noticeFileUpload
			, @RequestParam(value = "noticeImgUpload" ,required = false) MultipartFile noticeImgUpload
			) throws IllegalStateException, IOException {
		
		Notice existingNotice = noticeService.getSelectNotice(noticeIdx);
		System.out.println("existingNotice = "+existingNotice);
		// 업로드할 디렉토리 경로 서버 디렉토리의 시스템 경로 반환
		String uploadDirectory = context.getServletContext().getRealPath("/resources/upload");
		
		if (noticeFileUpload != null && !noticeFileUpload.isEmpty()) {
			try {
				// 인코딩
				// String fileNameEncoding = new String((noticeFileUpload.getOriginalFilename()).getBytes("8859_1"),"utf-8");
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
		}
		//  사진업로드
		if (noticeImgUpload != null && !noticeImgUpload.isEmpty()) {
			// 인코딩
			// String imgNameEncoding = new String(noticeImgUpload.getOriginalFilename().getBytes("UTF-8"), "UTF-8");
			// 사진 저장
			String originalFileName = noticeImgUpload.getOriginalFilename();
			
			String fileExtension = "";
			if (originalFileName != null) {
			    int lastDotIndex = originalFileName.lastIndexOf(".");
			    if (lastDotIndex != -1) {
			        fileExtension = originalFileName.substring(lastDotIndex);
			    }
			}

			// Generate a unique name using the file extension
			String uploadNoticeImg = UUID.randomUUID().toString() + fileExtension;

			// Process file upload - put it on the server
			noticeImgUpload.transferTo(new File(uploadDirectory, uploadNoticeImg));

			notice.setNoticeImg(uploadNoticeImg);
			//=================================
//			String uploadNoticeImg = UUID.randomUUID().toString();
//		
//			// 파일 업로드 처리 - 서버에 넣음
//			noticeImgUpload.transferTo(new File(uploadDirectory, uploadNoticeImg));
//			
//			notice.setNoticeImg(uploadNoticeImg);
			///====
		} else {
			notice.setNoticeImg("null");
		}
		
			
	    // 공지사항 수정 
	    noticeService.modifyNotice(notice);
		
		return "success";
		
	}
	

	

}
