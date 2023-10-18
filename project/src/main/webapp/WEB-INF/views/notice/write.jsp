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
<!-- action : 컨트롤러에서 받아지는 ... -->
	<form class="" action="add" method="post" id="enrollForm" enctype="multipart/form-data">            
	   <p>작성자</p>
	        <input class="text" type="text" name="userinfoId" readonly>
	
	        <p>제목</p>
	   <input class="text" type="text" name="noticeTitle" placeholder="제목을 작성해주세요.">
	  
	  
	   <p>내용</p>
	   <textarea name="noticeContent" placeholder="내용을 적어주세요!"></textarea>
	   
	   <div class="btn_section">
	       <button type="button" id="cancelBtn" onclick="location.href='${pageContext.request.contextPath}/notice/list'">취 소</button>
	       <button type="submit" id="enrollBtn" class="btn enroll_btn">등 록</button>
	   </div>
	</form>
</body>
</html>