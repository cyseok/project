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
	      <input name="noticeTitle" id="noticeTitle" type="text" class="" placeholder="제목을 입력해주세요" required>
	      <div class=""></div>
	  </div>
	    <div class="">
	      <label for="noticeContent">내용</label>
	      <textarea name="noticeContent" id="noticeContent" class="form-control" rows="15" placeholder="내용을 입력해주세요" required></textarea>
	    <div class=""></div>
	    
 		<div>
 			<img id="preview" style="width:30%; height: 30%;">
 		</div>
	    <label for="noticeImg">사진 올리기
 			<input type="file" class="" id="noticeImg" name="noticeImgFile" onchange="readURL(this);">
 		</label>
	  </div>
	  
	  <div class="">
	    <label>파일 첨부</label>
	    <input type="file" id="noticeFile" name="noticeFileUpload">
	    <div class=""></div>
	  </div>
	  <br>
	    <button type="button" id="cancelBtn" onclick="location.href='${pageContext.request.contextPath}/notice'">취 소</button>
	    <button type="submit" id="enrollBtn" class="" >등 록</button>
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

// 수정
$("form").submit(function(e) {
    e.preventDefault(); // Prevent the default form submission

    var formData = new FormData();
    formData.append("noticeTitle", $("[name='noticeTitle']").val());
    formData.append("noticeContent", $("[name='noticeContent']").val());
    formData.append("noticeImgFile", $("[name='noticeImgFile']")[0].files[0]);
    formData.append("noticeFileUpload", $("[name='noticeFileUpload']")[0].files[0]);

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
    /*
$(document).ready(function(){
    $("#enrollBtn").click(function() {
    	var formData = new FormData();
		// var idx=${sessionScope.idx};
		
		formData.append("noticeTitle", $("#noticeTitle").val());
        formData.append("noticeContent", $("#noticeContent").val());
        formData.append("noticeImg", $("#noticeImg")[0].files[0]);
        formData.append("noticeFileUpload", $("#noticeFile")[0].files[0]);
        
        
        $.ajax({
            type: "POST",
            url: "<c:url value='/notice'/>",
            data: formData,
            contentType: false,
            processData: false,
            dataType: "text",
            success: function(result) {
                if (result == "success") {
	                alert("공지 사항을 등록하였습니다.");
	                window.location.href = "${pageContext.request.contextPath}/notice"
                    // notice_detail(idx);
                } else {
                	alert("글 등록을 실패하였습니다.");
                }
            }
        });
    });
});
    */
    /*
// 업로드 이미지 파일 미리보기
function previewURL(input) {
 	  if (input.images && input.images[0]) {
 	    var reader = new FileReader();
 	    reader.onload = function(e) {
 	      document.getElementById('preview').src = e.target.result;
 	    };
 	    reader.readAsDataURL(input.images[0]);
 	  } else {
 	    document.getElementById('preview').src = "";
 	  }
 	}
 	
$(document).ready(function(){
    $("#noticeImg").on('change', function() {
        var input = this;
        if (input.images && input.images[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $("#preview").attr('src', e.target.result);
            };
            reader.readAsDataURL(input.images[0]);
        } else {
            $("#preview").attr('src', "");
        }
    });
    
});
 	
 	*/
 	function readURL(input) {
 		  if (input.files && input.files[0]) {
 		    var reader = new FileReader();
 		    reader.onload = function(e) {
 		      document.getElementById('preview').src = e.target.result;
 		    };
 		    reader.readAsDataURL(input.files[0]);
 		  } else {
 		    document.getElementById('preview').src = "";
 		  }
 		}
 	
 	
//확장자가 이미지 파일인지 확인
function isImageFile(file) {

    var ext = file.name.split(".").pop().toLowerCase(); // 파일명에서 확장자를 가져온다. 

    var isImage = $.inArray(ext, ["jpg", "jpeg", "gif", "png"]) !== -1;

    if (!isImage) {
        console.log("이미지 파일이 아닙니다. 확장자를 다시 확인해주세요.");
        alert("이미지 파일이 아닙니다. 확장자를 다시 확인해주세요.");
    }

    return isImage;
}
    
    
</script>
</body>
</html>