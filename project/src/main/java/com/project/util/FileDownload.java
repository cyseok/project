package com.project.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

// 파일 다운로드 기능을 제공하기 위한 클래스
// ▶ BeanNameViewResolver 객체에 의하여 실행되는 클래스
// ▶ Spring Bean Configuration File(servlet-context.xml)에 Spring Bean으로 등록
// BeanNameViewResolver 객체에 의하여 실행될 클래스는 반드시 AbstractView 클래스를 상속받아 작성
// ▶ renderMergedOutputModel() 메소드를 오버라이드 선언하여 응답 처리에 필요한 명령을 작성해야 함

public class FileDownload extends AbstractView {
	public FileDownload() {
		// AbstractView.setContentType(String contentType): AbstractView 객체에 저장될 클라이언트의 응답 파일 형식(MimeType)을 변경하는 메소드
		setContentType("application/download; utf-8");
	}

	// BeanNameViewResolver 객체에 의하여 자동 호출되는 메소드 - 실행 메소드
	// ▶ model 매개 변수에는 요청 처리 메소드에서 제공된 속성값이 엔트리로 저장된 Map 객체를 제공받아 사용
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 요청 처리 메소드에서 제공된 속성값(다운로드 관련 파일 정보)을 객체로 반환받아 저장
		String uploadDirectory = (String) model.get("uploadDirectory");
		String originalFilename = (String) model.get("originalFilename");
		String uploadFilename = (String) model.get("uploadFilename");

		// 서버 디렉토리에 저장된 업로드 파일에 대한 File 객체 생성
		File file = new File(uploadDirectory, uploadFilename);
		
		// 클라이언트에게 파일을 전달하여 저장하기 위한 파일 형식(MimeType)을 클라이언트에게 전달
		// AbstractView.getContentType(): AbstractView 객체에 저장될 클라이언트의 응답 파일 형식(MimeType)을 반환하는 메소드
		response.setContentType(getContentType());
		
		// 클라이언트에게 응답될 파일의 크기를 클라이언트에게 전달
		// response.setContentLengthLong(long length): 클라이언트에게 파일의 크기를 전달하는 메소드
		response.setContentLengthLong(file.length());
		
		// 클라이언트에 저장될 파일명을 클라이언트에게 전달
		// ▶ 전달될 파일의 이름에 한글이 존재할 경우 부호화 처리 후 전달
		originalFilename=URLEncoder.encode(originalFilename, "utf-8");
		response.setHeader("Content-Disposition", "attachement;filename=\""+originalFilename+"\";");
		
		// 파일을 클라이언트에게 전달하기 위한 출력 스트림을 반환받아 저장
		OutputStream out = response.getOutputStream();
		
		// 서버 디렉토리에 저장된 업로드 파일을 읽기 위한 입력 스트림을 생성하여 저장
		InputStream in = new FileInputStream(file);
		
		// FileCopyUtils.copy(InputStream in, OutputStream out): 입력 스트림으로 원시 데이터를 읽어 출력 스트림으로 전달하여 저장하는 메소드 - 파일 복사
		FileCopyUtils.copy(in, out); // 다운로드 처리
		
		in.close();
	}
}

