<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
	<title>공지사항</title>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
	<style>
body {
    padding-top: 50px;
  }
#preview {
  width: 100%;
  height: 100%;
}
p {
  font-size : 22px;
}
#noticeTitle {
  font-size: 24px; 
}
#noticeContent {
  font-size: 22px; 
}
	</style>
</head>

<header>
  <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>

<body>
<div class="section">
  <div class="container">
    <div class="row">
	  <form enctype="multipart/form-data">
	    <div class="post-form">
	      <p>공지사항 작성</p>
	    </div> 
	    
	    <div class="post-form">
	      <label for="noticeTitle" class="post-label">제목</label>
	        <textarea name="noticeTitle" id="noticeTitle" class="form-control" placeholder="제목을 입력해주세요"></textarea>
	    </div>
	    
	    <div class="post-form">
	      <label for="noticeContent" class="post-label">내용</label>
	      <textarea name="noticeContent" id="noticeContent" class="form-control" rows="13" placeholder="내용을 입력해주세요"></textarea>
	    </div>
	    
 		<div class="post-form">
 			<img id="preview">
 		</div>
 		
        <div class="post-form">
	      <label for="noticeImg">사진 올리기
	      <br>
 			<input type="file" class="" id="noticeImg" name="noticeImgUpload" onchange="readURL(this);" style="width: 250px;">
 		  </label>
	    </div>
	  
	    <div class="post-form">
	      <label for="noticeFile">파일 첨부
	      <br>
	        <input type="file" id="noticeFile" name="noticeFileUpload" style="width: 250px;">
	      </label>
	    </div>
	    <br>
	    <div class="post-form d-flex justify-content-end">
	    <button type="submit" class="btn btn-primary" >등 록</button>
	    <button type="button" class="btn btn-secondary ml-2" id="cancelBtn" onclick="location.href='${pageContext.request.contextPath}/notices'">취 소</button>
	    </div>
	  <sec:csrfInput/>
	  </form>
	</div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<script>
//CSRF 토큰 관련 정보를 자바스크립트 변수에 저장
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

// Ajax 기능을 사용하여 요청하는 모든 웹 프로그램에게 CSRF 토큰 전달 가능
// ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

// 등록
$("form").submit(function(e) {
    e.preventDefault();
    $('#loading').show();

    var noticeImgUpload = $("#noticeImg")[0].files[0];
    var noticeFileUpload = $("#noticeFile")[0].files[0];
    
    var formData = new FormData();
    formData.append("noticeTitle", $("#noticeTitle").val());
    formData.append("noticeContent", $("#noticeContent").val());
    formData.append("noticeFileName", $("#noticeFileName").val());
    
    if (noticeImgUpload !== undefined) {
        formData.append("noticeImgUpload", noticeImgUpload);
    }

    if (noticeFileUpload !== undefined) {
        formData.append("noticeFileUpload", noticeFileUpload);
    }

    $.ajax({
        type: "POST",
        url: "<c:url value='/api/notices'/>",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "text",
        success: function (result) {
        	$('#loading').hide();
            if (result == "success") {
                alert("공지 사항을 등록하였습니다.");
                window.location.href = "${pageContext.request.contextPath}/notices"
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
	    	document.getElementById('preview').style.display = "block";
	    	document.getElementById('preview').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	    
	    
	  } else {
	    document.getElementById('preview').src = "";
	    document.getElementById('preview').style.display = "none";
	  }
	}
</script>
</body>
</html>