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

		<div class="">
           <div class="view">
              <h3 class="tit">제목 : ${notice.noticeTitle}</h3>
              <p class="t1">작성일: ${notice.noticeRegdate }</p>
              <p class="t1">조회수: ${notice.noticeViewcnt }</p>
           </div>
           <hr>
           <div class="view_con" style="white-space:pre;">${notice.noticeContent}</div>
           
           <c:if test="${not empty notice.noticeImg}">
             <img src="<c:url value='/resources/upload/${notice.noticeImg}' />" >
       	   </c:if>
           <c:if test="${not empty notice.noticeFile}">
               <!-- 파일 다운로드 링크 -->
               <p>첨부 파일 다운로드 : 
                 <a href="<c:url value='/resources/upload/${notice.noticeFile}' />" download="${notice.noticeFile}">${notice.noticeFileName}</a>
               </p>
              <hr>
    	</c:if>

           <div class="">
              <div class="">
              	<button type="button" id="" onclick="location.href='${pageContext.request.contextPath}/notice'">목록으로</button>
              	<button type="button" id="" onclick="location.href='${pageContext.request.contextPath}/notice/modify/${notice.noticeIdx}'">수정하기</button>
              </div>

              		<!-- 폼 추가 
                      <form id="deleteForm" action="${pageContext.request.contextPath}/notice/delete/${notice.noticeIdx}" method="POST">-->
                          <!-- CSRF 토큰 등을 포함하려면 여기에 추가 -->
                          <!-- 예: <input type="hidden" name="_csrf" value="${_csrf.token}"> -->
                      
                      <!-- 삭제 버튼 -->
                     <button type="button" class="" id="deleteBtn">삭 제</button>
                </div>
              </div>
              
           <div class="" style="width:100%;"> 
                   <div class="" style="margin-right: 20px;">  
                    <c:choose>
                       <c:when test="${preNumNextNum.prevNum ne null }">
                           <a href="<c:url value='/notice'/>/${preNumNextNum.prevNum}" class="" id="prevButton"><i class=""></i><span>이전글</span></a>
                       </c:when>
                       <c:otherwise>
                          <div class="space"></div>
                       </c:otherwise>
                    </c:choose>
					<div class=""></div>
                    <c:choose>
                       <c:when test="${preNumNextNum.nextNum ne null }">
						<a href="<c:url value='/notice'/>/${preNumNextNum.nextNum}" class="" id="nextButton"><span>다음글</span><i class=""></i></a>
                       </c:when>
                    </c:choose>
                   </div>
            </div>
              
<script type="text/javascript">
    // 삭제 버튼 클릭 이벤트 핸들러
    /* $("#deleteBtn").on("click", function() {
        if (confirm("자료를 정말로 삭제 하시겠습니까?")) {
            // 페이지 리다이렉션
            window.location.href = "${pageContext.request.contextPath}/notice/remove/${noticeIdx}";
        }
    }); */
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";

    // Ajax 기능을 사용하여 요청하는 모든 웹 프로그램에게 CSRF 토큰 전달 가능
    // ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
    $(document).ajaxSend(function(e, xhr){
    	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    });
    
    $(document).ready(function(){
        $("#deleteBtn").click(function() {
        	if (confirm("자료를 정말로 삭제 하시겠습니까?")) {
        	var idx = ${notice.noticeIdx};
    		// var idx=${sessionScope.idx};
    		
    	
            $.ajax({
                type: "DELETE",
                url: "<c:url value='/notice'/>",
                data: {'noticeIdx' : noticeIdx},
                contentType: false,
                processData: false,
                success: function(result) {
                    if (result == "success") {
    	                alert("공지 사항이 삭제되었습니다");
    	                window.location.href = "${pageContext.request.contextPath}/notice"
                        // notice_detail(idx);
                    } else {
                    	alert("글 삭제에 실패했습니다.");
                    }
                }
            });
           } 
        });
    });
</script>
</body>
</html>