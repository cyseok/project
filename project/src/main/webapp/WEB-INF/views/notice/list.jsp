<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 'ROLE_ADMIN'만 공지사항 등록 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="UTF-8">
<head>

<title>공지사항 목록</title>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/notice-list.css">
 <style> 

 </style>
</head>  
 
<header>
  <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>
 
<body>
<div class="section">

	<div class="totalNum">
		<span>전체 게시글 수 : <b><span id="totalBoard"></span></b>개</span>
	</div>
	<!-- n개씩 보기 출력 -->
    <select id="noticeSize"></select>
    
    <button id="resetButton" class="btn btn-secondary" style="float:right; margin-right:200px; height:43px;" onclick="noticeListDisplay();">초기화</button>
    <button id="searchButton" class="btn btn-secondary" style="float:right; margin-right:10px; height:43px;" onclick="noticeSearch();">검색</button>
    <input type="text" class="" id="selectKeyword" placeholder="제목, 내용으로 검색해보세요!" style="width:250px; height:43px; float:right; margin-right:10px;">


	<!-- 게시글 목록 출력 -->
    <div id="noticeListInfo">
		<table border="1">
			<colgroup>
				<col width="10%" />
				<col width="25%" />
				<col width="15%" />
				<col width="20%" />
			</colgroup>
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성일!</th>
					<th>조회수</th>
				</tr>
			</thead>
			
			<tbody id="tbody" style="text-align:center;">
			</tbody>
		</table>
	</div>
    
    <sec:authorize access="hasRole('ROLE_MASTER')">
	    <button type="button" id="writeNotice" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/notice/write'">
	    	글쓰기
	    </button>
    </sec:authorize>
    
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    
    <!-- 페이지 번호 출력 -->
    <div id="pageNumDiv"></div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<script type="text/javascript">
//CSRF 토큰 관련 정보 저장
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
var page = 1; // 기본 페이지 번호 설정
var size = 10; // 기본 페이지 크기 설정
var keyword = ''; // 기본 검색어 = NULL

// Ajax 기능을 사용하여 요청하는 모든 웹 프로그램에게 CSRF 토큰 전달 가능
// ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

$(document).ready(function() { // JSP가 렌더링되자마자,
	
    $("#noticeSize").hide(); 
    
    noticeListDisplay(page, size, keyword);

    $("#noticeSize").change(function() {
  	    var functionName =  "noticeListDisplay";
  	  
        var selectedPageSize = parseInt($(this).val());
        window[functionName](page, selectedPageSize, keyword);
   });
 
});

//Enter 키를 눌렀을 때 검색 기능
$("#selectKeyword").keypress(function(){
	if(event.keyCode == 13) {
		 noticeSearch();
	}
});



// 공지 사항 목록 출력
function noticeListDisplay(pageNum, pageSize, selectKeyword) {
	$("#noticeSize").show();
	$("#pageNumDiv").show();
	$('#loading').show();
	
   page=pageNum;
   size=pageSize;
   keyword=selectKeyword;
   
    $.ajax({
        method: "GET",
        url: "<c:url value='/notice/list'/>",
        data: {"pageNum": pageNum, "pageSize": pageSize, "selectKeyword": selectKeyword},
        dataType: "json",
        success: function(result) {
        	$('#loading').hide();
        	// 전체 글 개수
        	var totalBoard = result.pager.totalBoard;
        	var pager = result.pager;
        	
        	$("#totalBoard").html(totalBoard);
        	
            $("#tbody").empty();
            
            // 출력된 공지사항 데이터가 없을 때
            if (result.noticeList.length == 0) { 
            	$("#tbody").append("<tr><td colspan='4'>검색된 공지사항이 없습니다.</td></tr>");
            } else {
				// 공지사항 목록 출력            	
	            for (var i = 0; i < result.noticeList.length; i++) {
	                var noticeList = result.noticeList[i];
	                var row = "<tr data-idx='" + noticeList.noticeIdx + "'>" +
	                   		  "<td>" + noticeList.rownum + "</td>" +
	                   		  "<td><a href=\"<c:url value='/notice'/>/" + noticeList.noticeIdx + "\">" + noticeList.noticeTitle + "</a></td>" +
	                   		  "<td>" + noticeList.noticeRegdate + "</td>" +
	                   		  "<td>" + noticeList.noticeViewcnt + "</td>" +
	                   		  "</tr>";
	                $("#tbody").append(row);
	            }
            }
            // 페이지 번호 출력
            pageNumDisplay(result.pager);
            // 페이지 당 출력 개수
           noticeSizeDisplay();
        },
        error: function(xhr) {
            alert("공지 사항 목록을 불러오는 중에 오류가 발생했습니다. (에러 코드 = " + xhr.status + ")");
        }
    });
}

// 페이지 번호를 출력
function pageNumDisplay(pager) {
    var html = "";
    if (pager.startPage > pager.blockSize) {
        html += "<a href=\"javascript:noticeListDisplay(" + pager.prevPage + ", " + size + ", '" + keyword + "');\" class=''><i class='fa fa-long-arrow-left'/></a>";
    } else {
        html += "<a class='page-num' disabled ><i class=''><</i></a>";
    }

    for (var i = pager.startPage; i <= pager.endPage; i++) {
        if (pager.pageNum != i) {
            html += "<a class='page-num' href=\"javascript:noticeListDisplay(" + i + ", " + size + ", '" + keyword + "');\">" + i + "</a>";
        } else {
            html += "<a class='page-num' disabled>" + i + "</a>";
        }
    }

    if (pager.endPage != pager.totalPage) {
        html += "<a href=\"javascript:noticeListDisplay(" + pager.prevPage + ", " + size + ", '" + keyword + "');\" class=''><i class='fa fa-long-arrow-left'/></a>";
    } else {
        html += "<a class='page-num' disabled><i class=''>></i></a>";
    }

    $("#pageNumDiv").html(html);
}

// 페이지 당 출력 갯수를 설정
function noticeSizeDisplay() {
    // 페이지 크기 선택
    var noticeSize = $("#noticeSize");

    noticeSize.empty(); // 기존 옵션 초기화

    var pageSizeOptions = [10, 20, 50, 100];
    for (var i = 0; i < pageSizeOptions.length; i++) {
        var optionValue = pageSizeOptions[i];
        var optionText = optionValue + "개씩 보기";

        var option = $("<option>").val(optionValue).text(optionText);

        if (optionValue === size) {
            option.prop("selected", true);
        }
        noticeSize.append(option);
    }
}

// 검색
function noticeSearch() {
    var selectKeyword = $("#selectKeyword").val();
        noticeListDisplay(1, size, selectKeyword);
}
</script>
</body>
</html>