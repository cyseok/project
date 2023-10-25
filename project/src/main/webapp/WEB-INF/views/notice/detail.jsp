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
  </head> 
  
<body>

           <div class="view">
              <h3 class="" id="title"></h3>
              <input type="text" id="content">
              <p class="" id="regdate"></p>
              <p class="" id="viewCount"></p>
           </div>
           <hr>
           
             <img id="image" src="" >
       	   
               <!-- 파일 다운로드 링크 -->
               <p>첨부 파일 다운로드 : 
                 <a id="download" href="" download=""></a>
               </p>
              <hr>
 		<!-- 수정, 삭제에 권한 주기!!!!! 
 		<sec:authorize access="hasRole('ROLE_ADMIN')"></sec:authorize> 
 		-->
           	<div class="">
              	<button type="button" onclick="location.href='${pageContext.request.contextPath}/notice'">목록으로</button>
              	<button type="button" onclick="noticeModify();">수정하기</button>
                <button type="button" class="" onclick="noticeDelete();">삭 제</button>
             </div>
              
              <!-- 이전글 다음글 버튼 출력 -->
    		  <div id="preNextNum"></div>
              
                
              
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

	});
   	


// 공지사항 상세 페이지 출력  
function noticeDetail() {
	// 
	$("#preNextNum").show();
	if (typeof noticeidx === "undefined" || noticeidx === null) {
        window.location.href = "${pageContext.request.contextPath}/notice";
        return;
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
					
	        	var prevNum = result.prevNumNextNum.prevNum;
	        	var nextNum = result.prevNumNextNum.nextNum;
				var notice = result.notice;
				
				// .html : 마크업, html 태그 포함 / .val : 텍스트필드, 택스트값에 쓰기 / .text : 텍스트 내용 설정
	            $("#regdate").html("작성일 : " + notice.noticeRegdate);
	            $("#title").text(notice.noticeTitle);
	            $("#content").val(notice.noticeContent);
	            $("#viewCount").html(notice.noticeViewcnt);
	            $("#image").attr("src", "<c:url value='/resources/upload/' />" + notice.noticeImg);
	            
	            // "<c:url value='/resources/upload/"+  ${festivalinfo.mainImg}     +"' />"
	            
	            $("#download")
	            	.attr("href", "<c:url value='/resources/upload/' />" + notice.noticeFile)
	            	.attr("download", notice.noticeFile)
	            	.text(notice.noticeFileName);
	           // $("prevNum").attr("href", "<c:url value='/notice/' />" + prevNum);
	           // $("nextNum").attr("href", "<c:url value='/notice/' />" + nextNum );
	            
	            // 이전글 다음글 출력
	            noticePrevNumNextNum(prevNum, nextNum);
	        	}
	        },
        error: function(xhr) {
            alert("공지 사항을 불러오는 중에 오류가 발생했습니다. 에러 코드 = (" + xhr.status + ")");
	    }
    });
}
// 이전글 다음글 출력
function noticePrevNumNextNum(prevNum, nextNum) {
	var html = "";
	
	// 이전글이 있으면 출력 
    if (prevNum != 0) {
        html += "<a href='<c:url value= '/notice/'/>" + prevNum + "'" + "class=''><span>이전글</span></a>";
    }
	
	// 다음글이 있으면 출력
    if (nextNum != 0) {
        html += "<a href='<c:url value= '/notice/'/>" + nextNum + "'" + "class=''><span>다음글</span></a>";
    }
	
	$("#preNextNum").html(html);
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
                    // notice_detail(idx);
                } else {
                	alert("글 삭제에 실패했습니다.");
                	window.location.href = "${pageContext.request.contextPath}/notice/"+noticeidx;
                }
           }
      });
    } 
}

//공지사항 수정페이지 이동
function noticeModify() {     
	window.location.href = "${pageContext.request.contextPath}/notice/modify/"+noticeidx;
}
        	
    
</script>
</body>
</html>