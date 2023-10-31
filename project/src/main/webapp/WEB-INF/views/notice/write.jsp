<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="UTF-8">
   <head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  </head>
  
<body>
	<form enctype="multipart/form-data">
	  <div class="">
	    <label for="noticeTitle">제목</label>
	      <textarea name="noticeTitle" id="noticeTitle" class="" placeholder="제목을 입력해주세요"></textarea>
	  </div>
	    <div class="">
	      <label for="noticeContent">내용</label>
	      <textarea name="noticeContent" id="noticeContent" class="form-control" rows="15" placeholder="내용을 입력해주세요"></textarea>
	    </div>
 		<div>
 			<img id="preview" style="width:30%; height: 30%;">
 		</div>
      <div>
	    <label for="noticeImg">사진 올리기
 			<input type="file" class="" id="noticeImg" name="noticeImgUpload" onchange="readURL(this);">
 		</label>
	  </div>
	  
	  <div class="">
	    <label>파일 첨부</label>
	      <input type="file" id="noticeFile" name="noticeFileUpload" >
	  </div>
	  <br>
	    <button type="button" id="cancelBtn" onclick="location.href='${pageContext.request.contextPath}/notice'">취 소</button>
	    <button type="submit" class="" >등 록</button>
	    <div class=""></div>
	  <sec:csrfInput/>
	</form>

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
    e.preventDefault(); // 

    var formData = new FormData();
    formData.append("noticeTitle", $("#noticeTitle").val());
    formData.append("noticeContent", $("#noticeContent").val());
    formData.append("noticeFileName", $("#noticeFileName").val());
    formData.append("noticeImgUpload", $("#noticeImg")[0].files[0]);
    formData.append("noticeFileUpload", $("#noticeFile")[0].files[0]);

    $.ajax({
        type: "POST",
        url: "<c:url value='/notice'/>",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "text",
        success: function (result) {
            if (result == "success") {
                alert("공지 사항을 등록하였습니다.");
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