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
<!--  수정 랜더링되면 URL 값 가져와서 기존 폼에 붙여넣고 수정하는 거해서 ajax 두개 쓰기???  -->
	<form class="" action="${pageContext.request.contextPath}/notice/modify" method="post" id="modifyForm" enctype="multipart/form-data">            
	   <p>공지사항 번호</p>
	        <input class="text" type="text" name="noticeIdx" value="${notice.noticeIdx }" readonly>
	  
	   <p>작성자</p>
	        <input class="text" type="text" name="userinfoId" value="${notice.userinfoId }" readonly>
	  <p>제목</p>
	         <input class="text" type="text" name="noticeTitle" value="${notice.noticeTitle}">
	   <%-- <p>파일</p>
	         <input type="file" name="noticeImgFile" id="noticeImgFile">
	           <img src="<c:url value='/assets/img/upload/${notice.noticeImg}'/>" alt=""> --%>
	    <p>내용</p>
	        <textarea name="noticeContent">${notice.noticeContent}</textarea>
	   <div class="">
	       <button type="button" id="" onclick="location.href='${pageContext.request.contextPath}/notice/list'">목록으로</button>
	       <button type="button" id="" onclick="location.href='${pageContext.request.contextPath}/notice/detail/${noticeIdx}'">취 소</button>
           
	       <button type="submit" class="">수 정</button>
	   </div>
	</form>
</body>
</html>