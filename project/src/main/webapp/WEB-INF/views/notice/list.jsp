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
<table>
	<colgroup>
	<col width="10%">
	<col width="65%">
	<col width="10%">
	<col width="15%">
	</colgroup>
	
	<tr>
		<td class="t1">번호</td>
		<td class="t1">제목</td>
		<td class="t1">작성자</td>
		<td class="t1">작성일</td>
		<td class="t1" style="white-space: nowrap;">조회수</td>
	</tr>
	
	<c:choose>
		<c:when test="${empty result.noticeList}">
		<tr>
			<td colspan="5">게시글이 없습니다.</td>
		</tr>	
		</c:when>
		<c:otherwise>  
		                     
			<c:forEach var="notice" items="${result.noticeList }">
			<tr>
				<td class="t2">${notice.noticeIdx }</td>
				<td class="t2"><a href="${pageContext.request.contextPath}/notice/view/${notice.noticeIdx}" >${notice.noticeTitle}</a></td>
				<td class="t2">${notice.userinfoId }</td>
				<td class="t2">${notice.noticeRegDate }</td>
				<td class="t2">${notice.noticeViewcnt }</td>
			</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>

</body>
</html>