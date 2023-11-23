<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
	<title>게시글 작성</title>
<style>
	.ck.ck-editor {
		width: 80%;
		max-width: 800px;
		margin: 0 auto;
	}
	
	.ck-editor__editable {
		height: 70vh;
	}
	form {
	  position: relative;
	  top: 10px;
	  width: 500px;
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
	  <div class="">
	    <label for="postTitle">제목</label>
	    <textarea name="postTitle" id="postTitle" class="form-control" rows="2" placeholder="제목을 입력해주세요"></textarea>
	  </div>
	  <hr>
	  <div>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postDayType" id="dayType" value="1" style="width: 20%">
		  <span>평일</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postDayType" id="dayType" value="2" style="width: 20%">
		  <span>주말, 공휴일</span>				
	    </label>
	  </div>
	  <hr>
	  <div>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="1" style="width: 20%">
		  <span>사람없음</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="2" style="width: 20%">
		  <span>웨이팅없음</span>				
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="3" style="width: 20%">
		  <span>웨이팅 조금</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="4" style="width: 20%">
		  <span>웨이팅 김</span>				
	    </label>
	  </div>
	  
	  <div class="">
	      <label for="postLoc">지역</label>
	      <input name="postLoc" id="postLoc" class="form-control" placeholder="내용을 입력해주세요">
	  </div>
						  
	  <textarea name="postContent" id="editor"></textarea>
	  
	    <div>
	      <button type="button" id="cancelBtn" onclick="location.href='${pageContext.request.contextPath}/notice'">취 소</button>
	      <button type="submit" class="" >등 록</button>
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
</script>

<script>		
	ClassicEditor
	.create(document.querySelector('#editor'), {
		ckfinder: {
			uploadUrl : "/post/imgUpload"
			,uploadMethod : "json"
		},
		image: {
	        toolbar: [  'imageTextAlternative',
                'toggleImageCaption',
                'imageStyle:inline',
                'imageStyle:block',
                'imageStyle:side' ]
	    }
	})
	.then(editor => {
		console.log('Editor was initialized');
	})
	.catch(error => {
		console.error(error);
	});
 </script>
</body>
</html>