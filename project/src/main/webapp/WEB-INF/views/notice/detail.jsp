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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<style>
	#noticeImg {
        width: 30%;
        height: 30%;
        max-width: 100%;
        max-height: 100%;
        display: block;
        margin: auto;
        }
        
    #noticeModifyForm {
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    background-color: rgba(0, 0, 0, 0.7);
	    z-index: 1000;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
	
	#noticeModifyForm > div {
	    display: block; /* Set the child div elements to be block-level, so they stack vertically */
	    background-color: #fff;
	    padding: 20px;
	    border-radius: 5px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	    margin: 10px; /* Add margin to space them out vertically */
	}
	</style>
  </head> 
  
<body>

           <div class="">
              <h3 class="" id="title"></h3>
              <input type="text" id="content">
              <p class="" id="noticeRegdate"></p>
              <p class="" id="viewCount"></p>
           </div>
           
             <img id="noticeImg" src="" >
       	   
               <!-- 파일 다운로드 링크 -->
               <b id="noticeFileName"></b>
                 <a id="noticeDownload" href="" download=""></a>
               
               
              	<!-- 관리자 권한 주기 -->
            <%-- <sec:authorize access="hasRole('ROLE_ADMIN')"></sec:authorize> --%>
           	   <div class="">
              	  <button type="button" id="noticeModify" class="">수정하기</button>
                  <button type="button" class="" onclick="noticeDelete();">삭 제</button>
               </div>
             
            
            <!-- 이전글 다음글 -->
            <div class="">
              	<button id="noticeListButton" type="button" onclick="location.href='${pageContext.request.contextPath}/notice'"><span>목록으로</span></button>
            	<button id="prevNum" type="button" onclick=""></button>
            	<button id="nextNum" type="button" onclick=""></button>
            </div>
              
            <!-- 수정 폼 출력 -->
            <form enctype="multipart/form-data" id="noticeModifyForm" style="display: none;">
              <div>
              <div class="" id="">
                <label for="noticeTitle">제목</label>
                <textarea id="noticeTitle" name="noticeTitle" class=""></textarea>
              </div>
              
              <div class="">
                  <label for="noticeContent">내용</label>
                  <textarea id="noticeContent" name="noticeContent" class="" rows="15"></textarea>
              </div>
              <div>
                <img id="preview" src="" style="width:30%; height: 30%;">
              </div>
              <div>
                <label for="noticeImgFile">사진 올리기
	 		      <input type="file" class="" id="noticeImgFile" name="noticeImgUpload" onchange="readURL(this);">
	 		    </label>
              </div>
	 		  <button type="button" onclick="clearPreview()">사진 삭제</button>
              <div class="">
                 <label>파일 첨부</label>
                 <input type="file" id="noticeFile" name="noticeFileUpload">
              </div>
              <hr>
              <input type="hidden" id="noticeIdx" name="noticeIdx">
              <!-- 수정 버튼 -->
              <button id="modifyBtn" type="submit">저장</button>
              <button id="noticeModifyCancel" type="button">취소</button>
              </div>
            </form>
                
              
<script type="text/javascript">
    
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";
    
    var currentURL = window.location.href;
    var parts = currentURL.split('/');
    var noticeidx = parts[parts.length - 1];
    

    //  CSRF 토큰 전달
    // ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
    $(document).ajaxSend(function(e, xhr){
    	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    });
   	
    // 페이지 렌더링 시 동작
   	$(document).ready(function() {
   		noticeDetail();
   		
	 	$("#noticeModifyCancel").click(function(){
	 	    $("#noticeModifyForm").toggle();
	 	});
 	   
	 	$("#noticeModify").click(function() {
	 	    // 수정 폼을 표시하거나 숨기기
	 	    $("#noticeModifyForm").toggle();
	 	});
	 	
	 	 // 공지사항 수정
	   $("form").submit(function(e) {
	    	e.preventDefault();
	       /* var imageInput = document.getElementById("noticeImgFile");
	       var selectedImage = imageInput.files[0];
	       
	       var fileInput = document.getElementById("noticeFile");
	       var selectedFile = fileInput.files[0]; */
	       //var img = $("#noticeImgFile")[0].files[0];
	       //var file = $("#noticeFile")[0].files[0];
	       
	       var formData = new FormData();
	       // formData.append("noticeIdx", noticeidx);
	       formData.append("noticeTitle", $("#noticeTitle").val());
	       formData.append("noticeContent", $("#noticeContent").val());
	       formData.append("noticeFileName", $("#noticeFileName").val());
	       formData.append("noticeImgUpload", $("#noticeImgFile")[0].files[0]);
	       formData.append("noticeFileUpload", $("#noticeFile")[0].files[0]);
	       
	       $.ajax({
	          type: "PATCH",
	          url: "<c:url value='/notice/'/>" + noticeidx,
	          data: formData,
	          processData: false, // 중요: FormData 사용 시 false로 설정
	          contentType: false,
	          dataType: "text",
	          success: function(result) {
	        	  if (result == "success") {
	                  alert("공지 사항을 수정하였습니다.");
	                  window.location.href = "${pageContext.request.contextPath}/notice/"+noticeidx;
	              } else {
	                  alert("글 수정을 실패하였습니다.");
	              }
	          },
	          error: function(xhr) {
	             alert("공지 사항 수정 중 오류가 발생하였습니다("+ xhr.status+")");
	          }
	       });
	    });

	});

// 공지사항 상세 페이지 출력  
function noticeDetail() {

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
					
	        	var prevNum = result.prevNumNextNum.prevNum;
	        	var nextNum = result.prevNumNextNum.nextNum;
				var notice = result.notice;
				
				// .html : 마크업, html 태그 포함 / .val : 텍스트필드, 택스트값에 쓰기 / .text : 텍스트 내용 설정
	            $("#noticeRegdate").html("작성일 : " + notice.noticeRegdate);
	            $("#title").text(notice.noticeTitle);
	            $("#content").val(notice.noticeContent);
	            $("#viewCount").html("조회수 : "+notice.noticeViewcnt);
	            $("#noticeIdx").attr("value",notice.noticeIdx);
	            
	            // 수정 폼 출력
	            $("#noticeTitle").val(notice.noticeTitle);
	            $("#noticeContent").val(notice.noticeContent);
	            alert(notice.noticeImg);
	            if (notice.noticeImg != null || notice.noticeImg != "null" || notice.noticeImg != 0) {
	           	    $("#noticeImg").attr("src", "<c:url value='/resources/upload/' />" + notice.noticeImg);
	           	 	$("#noticeImg").before("<hr>");
	           	 	$("#noticeImg").after("<hr>");
	           	 	
	           	    $("#preview").attr("src", "<c:url value='/resources/upload/' />" + notice.noticeImg);
	            } else {
	            	$("#noticeImg").remove();
	            	$("#preview").remove();
				}
	            
	            if (notice.noticeFile != null || notice.noticeFile != "null" || notice.noticeFile != 0) {
	            	$("#noticeFileName").html("첨부파일 : ");
		            $("#noticeDownload")
		            	.attr("href", "<c:url value='/resources/upload/' />" + notice.noticeFile)
		            	.attr("download", notice.noticeFile)
		            	.text(notice.noticeFileName);
	            } else {
	            	$("#noticeFileName").remove();
	            	$("#noticeDownload").remove();
				}
	            // 이전글 다음글 버튼 번호 출력 
	            if(prevNum != 0) {
	            	$("#prevNum").attr("onclick", "location.href='${pageContext.request.contextPath}/notice/" + prevNum +"'")
	            	.html("<span>이전글</span>");
	            } else {
	            	$("#prevNum").remove();
				}
	            
	            if(nextNum != 0) {
	            	$("#nextNum").attr("onclick", "location.href='${pageContext.request.contextPath}/notice/" + nextNum +"'")
	            	.html("<span>다음글</span>");
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
function noticeDelete(noticeidx) {   
	
    if (confirm("자료를 정말로 삭제 하시겠습니까?")) {
        $.ajax({
            type: "DELETE",
            url: "<c:url value='/notice'/>/" + noticeidx,
            data: {'noticeIdx' : noticeidx},
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