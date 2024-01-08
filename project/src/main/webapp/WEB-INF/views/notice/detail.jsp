<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 'ROLE_ADMIN'만 공지사항 수정 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
	<title>공지사항</title>
<style>
  #noticeImg {
    width: 30%;
    height: 30%;
    max-width: 100%;
    max-height: 100%;
    display: block;
    margin: auto;
}
       
  .notice-detail {
    margin-top: 20px; 
    margin-bottom: 50px; 
    width: 65%;
    margin-left: auto;
    margin-right: auto;
  }	
   .notice-button {
    display: flex;
    justify-content: flex-end;
  }

  .notice-button button {
    float: right;
  }
  #noticeImg {
    width: 75%;
    height: 60%;
    margin-top: 100px;
  }
  #noticeFileName {
    font-size: 18px; 
  }
  #noticeDownload {
    font-size: 18px; 
  }
  #title {
    font-size: 40px; 
  }
  #noticeRegdate {
    font-size: 15px; 
  }
  #viewCount {
    font-size: 15px; 
  }
  #content {
    font-size: 25px; 
  }
  .modifyButton {
    margin-top: 50px;
  }
  #noticeListButton {
    margin-right: 10px;
}

#prevNum {
    margin-right: 10px;
}

#nextNum {
    margin-right: 10px;
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
      <section class="notice-detail">
      
	    <div class="notice-button">
	      <button id="noticeListButton" class="btn btn-secondary" type="button" onclick="location.href='${pageContext.request.contextPath}/notice'">목록으로</button>
	      <button id="prevNum" class="btn btn-secondary" type="button" onclick="">이전글</button>
	      <button id="nextNum" class="btn btn-secondary" type="button" onclick="">다음글</button>
	    </div>
	    
		<div>
		   <h3 id="title"></h3>
		   <span id="noticeRegdate"></span>
		   <br>
		   <span id="viewCount"></span>
		</div>
		<hr>
		<div id="content">
        </div>
        
	    <img id="noticeImg" src="" >
	    <hr>   	   
	    <!-- 파일 다운로드 링크 -->
	    <b id="noticeFileName"></b>
	    <a id="noticeDownload" href="" download=""></a>
	               
	    <sec:authorize access="hasRole('ROLE_MASTER')">
	 	<div class="modifyButton">
	      <button type="button" id="noticeModify" class="btn btn-primary">수정하기</button>
	      <button type="button" class="btn btn-secondary ml-2" onclick="noticeDelete();">삭 제</button>
	    </div>
	    </sec:authorize>          
	            
	    
	  </section>  
      </div>
    </div>
  </div>              
	<!-- 수정 폼 -->
    <form enctype="multipart/form-data" id="noticeModifyForm" style="display: none;">
      <div class="post-form">
        <label for="noticeTitle" class="post-label">제목</label>
        <textarea id="noticeTitle" name="noticeTitle" class="form-control"></textarea>
      </div>
      
      <div class="post-form">
          <label for="noticeContent">내용</label>
          <textarea id="noticeContent" name="noticeContent" class="form-control" rows="15"></textarea>
      </div>
      
      <div class="post-form">
        <p id="beforePreview">기존 사진<br>사진을 변경할 경우에만 첨부해주세요.</p>
        <img id="preview" src="" style="width:75%; height: 60%;">
      </div>
      
      <div class="post-form">
        <label for="noticeImgFile">사진 올리기
   		<input type="file" class="" id="noticeImgFile" name="noticeImgUpload" onchange="readURL(this);">
        </label>
      </div>
      
      <div class="post-form">
        <button type="button" onclick="clearPreview()" class="btn btn-secondary ml-2">사진 삭제</button>
      </div>
      
      <div class="post-form">
        <p id="beforeFile">기존 파일<br>파일을 변경할 경우에만 첨부해주세요.</p>
        <b id="beforenoticeFileName"></b>
	    <a id="beforenoticeDownload" href="" download=""></a>
      </div>
        
      <div class="post-form">
         <label>파일 첨부</label>
         <input type="file" id="noticeFile" name="noticeFileUpload">
      </div>
      
      <input type="hidden" id="noticeIdx" name="noticeIdx">
      
      <div class="post-form">
      <!-- 수정 버튼 -->
      <button id="modifyBtn" type="submit" class="btn btn-primary">저장</button>
      <button id="noticeModifyCancel" type="button" class="btn btn-secondary ml-2">취소</button>
      </div>
      <sec:csrfInput/>
    </form>
    
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>                
              
<script type="text/javascript">
    
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";
    
    var currentURL = window.location.href;
    var parts = currentURL.split('/');
    var noticeIdx = parts[parts.length - 1];
    

    //  CSRF 토큰 전달
    // ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
    $(document).ajaxSend(function(e, xhr){
    	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    });
   	
    // 페이지 렌더링 시 동작
   	$(document).ready(function() {
   		noticeDetail();
   		
	 	$("#noticeModify").click(function(){
	 	    $("#noticeModifyForm").toggle();
	 	    $(".notice-detail").hide();
	 	});
	 	
	 	$("#noticeModifyCancel").click(function() {
	 	    // 수정 폼을 표시하거나 숨기기
	 	    $("#noticeModifyForm").toggle();
	 	    $(".notice-detail").show();
	 	});
	});
	 	
   // 공지사항 수정
   $("form").submit(function(e) {
       e.preventDefault();
       $('#loading').show();
       
       var formData = new FormData();
       
       formData.append("noticeTitle", $("#noticeTitle").val());
       formData.append("noticeContent", $("#noticeContent").val());
       formData.append("noticeFileName", $("#noticeFileName").val());
       
       var noticeImgUpload = $("#noticeImgFile")[0].files[0];
       if (noticeImgUpload !== undefined) {
           formData.append("noticeImgUpload", noticeImgUpload);
       }

       var noticeFileUpload = $("#noticeFile")[0].files[0];
       if (noticeFileUpload !== undefined) {
           formData.append("noticeFileUpload", noticeFileUpload);
       }
       
       $.ajax({
          type: "POST",
          url: "<c:url value='/notice/'/>" + noticeIdx,
          data: formData,
          processData: false, // 중요: FormData 사용 시 false로 설정
          contentType: false,
          dataType: "text",
          success: function(result) {
        	  $('#loading').hide();
        	  if (result == "success") {
                  alert("공지 사항을 수정하였습니다.");
                  window.location.href = "${pageContext.request.contextPath}/notice/"+noticeIdx;
              } 
          },
          error: function(xhr) {
             alert("공지 사항 수정 중 오류가 발생하였습니다("+ xhr.status+")");
          }
       });
    });


// 공지사항 상세 페이지 출력  
function noticeDetail() {

    $.ajax({
        method: "GET",
        url: "<c:url value='/notice/detail'/>/" + noticeIdx,
        data: {"noticeidx": noticeIdx},
        dataType: "json",
        success: function(result) { 
        	 
	        	if (result.notice == null) {
	        		alert("존재하지 않는 글입니다.");
	        		window.location.href = "${pageContext.request.contextPath}/notice"
	        	} else {
					
	        	var prevNum = result.prevNumNextNum.prevNum;
	        	var nextNum = result.prevNumNextNum.nextNum;
				var notice = result.notice;
				console.log(notice.noticeImg)
				console.log(notice.noticeContent)
				// .html : 마크업, html 태그 포함 / .val : 텍스트필드, 택스트값에 쓰기 / .text : 텍스트 내용 설정
	            $("#noticeRegdate").html("작성일 : " + notice.noticeRegdate);
	            $("#title").text(notice.noticeTitle);
	            $("#content").text(notice.noticeContent);
	            $("#viewCount").html("조회수 : "+notice.noticeViewcnt);
	            $("#noticeIdx").attr("value",notice.noticeIdx);
	            
	            // 수정 폼 출력
	            $("#noticeTitle").val(notice.noticeTitle);
	            $("#noticeContent").val(notice.noticeContent);
	           
	            if (notice.noticeImg !== null) {
	           	    $("#noticeImg").attr("src", "${pageContext.request.contextPath}/assets/images/upload/" + notice.noticeImg);
	           	 	
	           	    $("#preview").attr("src", "${pageContext.request.contextPath}/assets/images/upload/" + notice.noticeImg);
	            } else {
	            	$("#noticeImg").remove();
	            	$("#preview").remove();
	            	$("#beforePreview").remove();
				}
	            
	            if (notice.noticeFile !== null) {
	            	$("#noticeFileName").html("첨부파일 : ");
		            $("#noticeDownload")
		            	.attr("href", "${pageContext.request.contextPath}/assets/images/upload/" + notice.noticeFile)
		            	.attr("download", notice.noticeFile)
		            	.text(notice.noticeFileName);
		            
		            $("#beforenoticeFileName").html("첨부파일 : ");
		            $("#beforenoticeDownload")
		            	.attr("href", "${pageContext.request.contextPath}/assets/images/upload/" + notice.noticeFile)
		            	.attr("download", notice.noticeFile)
		            	.text(notice.noticeFileName);
	            } else {
	            	$("#noticeFileName").remove();
	            	$("#noticeDownload").remove();
	            	$("#beforeFile").remove();
				}
	            // 이전글 다음글 버튼 번호 출력 
	            if(prevNum != 0) {
	            	$("#prevNum").attr("onclick", "location.href='${pageContext.request.contextPath}/notice/" + prevNum +"'");
	            } else {
	            	$("#prevNum").remove();
				}
	            
	            if(nextNum != 0) {
	            	$("#nextNum").attr("onclick", "location.href='${pageContext.request.contextPath}/notice/" + nextNum +"'");
	            } else {
	            	$("#nextNum").remove();
				}
	            
	        	}
	        },
        error: function(xhr) {
            alert("공지 사항을 불러오는 중에 오류가 발생했습니다. 에러 코드 = (" + xhr.status + ")");
            window.location.href = "${pageContext.request.contextPath}/notice";
	    }
    });
}

// 공지사항 삭제
function noticeDelete(noticeIdx) {   
	
    if (confirm("자료를 정말로 삭제 하시겠습니까?")) {
        $.ajax({
            type: "DELETE",
            url: "<c:url value='/notice'/>/" + noticeIdx,
            data: {'noticeIdx' : noticeIdx},
            contentType: false,
            success: function(result) {
                if (result == "success") {
	                alert("공지 사항이 삭제되었습니다");
	                window.location.href = "${pageContext.request.contextPath}/notice"
                } else {
                	alert("글 삭제에 실패했습니다.");
                	window.location.href = "${pageContext.request.contextPath}/notice/"+noticeidx;
                }
            }
       });
    } 
}

   


// 수정된 이미지 확장자 유효성 검사 & 이미지 미리보기
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

// 사진 삭제
function clearPreview() {
    var previewImage = document.getElementById('preview');
    previewImage.src = "";
}
    
</script>
</body>
</html>