<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="UTF-8">
   <head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link>
	<style>
	#image {
            width: 30%;
            height: 30%;
            max-width: 100%;
            max-height: 100%;
            display: block;
            margin: auto;
        }
	</style>
  </head> 
  
<body>
<!--  수정 랜더링되면 URL 값 가져와서 기존 폼에 붙여넣고 수정하는 거해서 ajax 두개 쓰기???  -->
	<form enctype="multipart/form-data">
	  <div class="">
	    <label for="title">제목</label>
	      <input id="title" name="noticeTitle" type="text" class="" placeholder="제목을 입력해주세요" required>
	      <div class=""></div>
	  </div>
	    <div class="">
	      <label for="content">내용</label>
	      <textarea id="content" name="noticeContent"  class="form-control" rows="15" placeholder="내용을 입력해주세요" required></textarea>
	    <div class=""></div>
	    
 		<div>
 			<img id="preview" style="width:30%; height: 30%;">
 		</div>
	    <label for="noticeImg">사진 올리기
 			<input id="noticeImg" type="file" class="" name="noticeImgUpload" onchange="readURL(this);">
 		</label>
	  </div>
	  
	  <div class="">
	    <label>파일 첨부</label>
	      <input id="noticeFile" type="file" name="noticeFileUpload" >
	    <div class=""></div>
	  </div>
	  <br>
	    <button type="button" id="cancelBtn" onclick="location.href='${pageContext.request.contextPath}/notice'">취 소</button>
	    <button type="submit" id="enrollBtn" class="" >수정하기</button>
	    <div class=""></div>
	</form>
	
<script>
//CSRF 토큰 관련 정보를 자바스크립트 변수에 저장
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

var currentURL = window.location.href;
var parts = currentURL.split('/');
var noticeidx = parts[parts.length - 1];

// Ajax 기능을 사용하여 요청하는 모든 웹 프로그램에게 CSRF 토큰 전달 가능
// ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

	//페이지 렌더링 시 동작
	$(document).ready(function() {
		noticeModify();
	});
	
	// 기존 공지사항 데이터 출력  
	function noticeModify() {
        var noticeFile = $("#noticeFile")[0].files[0];
        var formData = new FormData();
        if (noticeFile) {
            formData.append("noticeFile", noticeFile);
          }
	    $.ajax({
	        method: "GET",
	        url: "<c:url value='/notice/detail'/>/" + noticeidx,
	        data: {"noticeidx": noticeidx},
	        dataType: "json",
	        success: function(result) {
	        	
		        	if (result.notice == null) {
		        		alert("존재하지 않는 글입니다.");
		        		window.location.href = "${pageContext.request.contextPath}/notice"
		        	} else {
						
					var notice = result.notice;
					
					// .html : 마크업, html 태그 포함 / .val : 텍스트필드, 택스트값에 쓰기 / .text : 텍스트 내용 설정
		            $("#title").text(notice.noticeTitle);
		            $("#content").val(notice.noticeContent);
		            
		            if (notice.noticeImg != null) {
		           	    $("#noticeImg").attr("src", "<c:url value='/resources/upload/' />" + notice.noticeImg);
		           	 	$("#noticeImg").before("<hr>");
		           	 	$("#noticeImg").after("<hr>");
		            } else {
		            	$("#noticeImg").remove();
					}
		            
		            if (notice.noticeFile != null) {
		            	$("#noticeFile").html("첨부파일 : ");
		            } else {
		            	$("#noticeFile").remove();
					}
		            // 이전글 다음글 버튼 번호 출력 
		            
		        	}
		        },
	        error: function(xhr) {
	            alert("공지 사항을 불러오는 중에 오류가 발생했습니다. 에러 코드 = (" + xhr.status + ")");
	            window.location.href = "${pageContext.request.contextPath}/notice";
		    }
	    });
	}
	
// 등록
$("form").submit(function(e) {
    e.preventDefault(); // Prevent the default form submission

    var formData = new FormData();
    formData.append("noticeTitle", $("#noticeTitle").val());
    formData.append("noticeContent", $("#noticeContent").val());
    formData.append("noticeFileName", $("#noticeFileName").val());
    formData.append("noticeImgUpload", $("#noticeImg")[0].files[0]);
    formData.append("noticeFileUpload", $("#noticeFile")[0].files[0]);

    $.ajax({
        type: "PUT",
        url: "<c:url value='/notice'/>",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "text",
        success: function (result) {
            if (result == "success") {
                alert("공지 사항을 수정하였습니다.");
                window.location.href = "${pageContext.request.contextPath}/notice"
            } else {
                alert("글 등록을 실패하였습니다.");
            }
        }
    });
});

// 이미지 확장자 유효성 검사 & 이미지 미리보기
function readURL(input) {
	  if (input.files && input.files[0]) {
	    var file = input.files[0];
        var fileName = file.name;
        var fileExtension = fileName.split('.').pop().toLowerCase();
        var allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];
        
       if (allowedExtensions.indexOf(fileExtension) === -1) {
            alert("선택한 파일은 이미지 파일이 아닙니다. 유효한 이미지 파일을 선택해주세요.");
            input.value = "";
            return;
        }
	    var reader = new FileReader();
       
	    reader.onload = function(e) {
	      document.getElementById('preview').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	  } else {
	    document.getElementById('preview').src = "";
	  }
	}
</script>
</body>
</html>