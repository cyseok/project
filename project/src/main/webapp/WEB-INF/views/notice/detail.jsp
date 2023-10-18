<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="UTF-8">
   <head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  </head> 
  
<body>

		<div class="">
           <div class="view">
              <h3 class="tit">제목 : ${notice.noticeTitle}</h3>
              <p class="t1">작성자: ${notice.userinfoId}</p>
              <p class="t1">작성일: ${notice.noticeRegDate }</p>
              <p class="t1">조회수: ${notice.noticeViewcnt }</p>
           </div>
           <hr>
           <div class="view_con" style="white-space:pre;">${notice.noticeContent}</div>
           

           <div class="">
              <div class="">
              	<button type="button" id="" onclick="location.href='${pageContext.request.contextPath}/notice/list'">목록으로</button>
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
              
<script type="text/javascript">
    // 삭제 버튼 클릭 이벤트 핸들러
    $("#deleteBtn").on("click", function() {
        if (confirm("자료를 정말로 삭제 하시겠습니까?")) {
            // 페이지 리다이렉션
            window.location.href = "${pageContext.request.contextPath}/notice/remove/${noticeIdx}";
        }
    });
</script>
</body>
</html>