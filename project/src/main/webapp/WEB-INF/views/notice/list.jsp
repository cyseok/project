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

		<form action="<c:url value="/notice/list"/>" method="get" class="search-area">   
   			<div class="">
       			<input type="text" class="" id="" name="selectKeyword" placeholder="제목, 내용 검색어를 입력하세요">
       			<button type="submit" class="" id="" >
       			검색
       			</button>
   			</div>
		</form>
		
	<table>
		<colgroup>
		<col width="10%">
		<col width="20%">
		<col width="55%">
		<col width="10%">
		<col width="5%">
		</colgroup>
		
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>내용</td>
			<td>작성자</td>
			<td>작성일</td>
			<td style="white-space: nowrap;">조회수</td>
		</tr>
		
		<c:choose>
			<c:when test="${empty result.noticeList}">
			<tr>
				<td colspan="5">게시글이 없습니다.</td>
			</tr>	
			</c:when>
			<c:otherwise>  
			                     
				<c:forEach var="noticeList" items="${result.noticeList }">
				<tr data-idx="noticeList.noticeIdx">
					<td>${noticeList.noticeIdx }</td>
					<td><a href="${pageContext.request.contextPath}/notice/detail/${noticeList.noticeIdx}" >${noticeList.noticeTitle}</a></td>
					<td>${noticeList.userinfoId }</td>
					<td>${noticeList.noticeContent }</td>
					<td>${noticeList.noticeRegDate }</td>
					<td>${noticeList.noticeViewcnt }</td>
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	
    <button type="button" id="" onclick="location.href='${pageContext.request.contextPath}/notice/write'">글쓰기</button>
	<!-- ======================================================== -->
	<div class="page_t">
        <%-- 페이지 번호 출력 --%>
        <c:choose>
           <c:when test="${result.pager.startPage > result.pager.blockSize }">
              <a
                 href="<c:url value="/notice/list"/>?pageNum=${result.pager.prevPage}&keyword=${search.keyword}">
                 [이전]
              </a>
           </c:when>
           <c:otherwise>
               [이전]
           </c:otherwise>
        </c:choose>
        <c:forEach var="i" begin="${result.pager.startPage }" end="${result.pager.endPage }" step="1">
           <c:choose>
              <c:when test="${result.pager.pageNum != i  }">
                 <a href="<c:url value="/notice/list"/>?pageNum=${i}&keyword=${search.selectKeyword}"><span class="p_num">${i }</span></a>
              </c:when>
              <c:otherwise>
                 <span class="p_num">${i }</span>
              </c:otherwise>
           </c:choose>
        </c:forEach>
        <c:choose>
           <c:when test="${result.pager.endPage != result.pager.totalPage }">
              <a href="<c:url value="/notice/list"/>?pageNum=${result.pager.nextPage}&keyword=${search.selectKeyword}"><span class="p_next">
                    [다음]</span>
              </a>
           </c:when>
           <c:otherwise>
               [다음] 
        </c:otherwise>
      </c:choose>
    </div>
	<!-- ======================================================== -->

</body>
</html>