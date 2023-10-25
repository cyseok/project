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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 <style> 
  a{
     text-align: right;
     color: black;
  }
  table{
    border-collapse: collapse;
    width: 1000px;    
    margin-top: 100px;
    margin-bottom : 50px;
    margin-left : 350px;
    text-align: center;
  }
  td, th{
     border-bottom: 1px solid black;
     height: 50px;
  }
  th{
     font-size : 17px;
     text-align: center;
  }
  th.idx {
     width: 10%;
  }
  th.title {
     width: 60%;
  }
  th.day {
     width: 18%;
  }
  th.count {
     width: 12%;
  }
  thead{
     font-weight: 700;
  }
 
  .top_btn{
    font-size: 20px;
    padding: 6px 12px;
    background-color: #fff;
    border: 1px solid #ddd;
    font-weight: 600;
  }
  h1{
     text-align: center;
  }
 .categories-sidebar-widget {
    max-width: 150px;
    margin-top: 150px;
    margin-left: 50px;
 }
 .widget-title {
    margin-top: 20px;
 }
 .noinBtn {
    width: 150px;
    margin-bottom: 50px;
    display: block;
 }
 #pageNumDiv {
    text-align: center;
   	margin-bottom: 50px;
   	margin-left: 100px;
 }
 .button-and-page-num {
    display: flex; /* Flexbox를 사용하여 내부 요소를 가로로 나열 */
    justify-content: center;
    align-items: center; /* 수직 가운데 정렬 */
 }
 #pageSizeSelect {
    margin-top: 10px;
 }
 </style>
</head>  
  
<body>
	<div>
		<span>전체 게시글 수 : <b><span id="totalBoard"></span></b>개</span>
	</div>
	<!-- 게시글 수를 출력 -->
    <select id="pageSizeSelect"></select>
    
    <!-- 검색 창 출력 -->
    <div id="searchDiv"></div>
  <form action="<c:url value="/notice"/>" method="GET" class="">
	<div style="text-align:right;">
  	  <button class="" name="type" value="recently" type="submit" style="padding: 9px 20px; margin-top: -18px;">
        최신순
      </button>
      <button class="" name="type" value="count" type="submit" style="padding: 9px 20px; margin-top: -18px;" >
        조회순
      </button>
    </div>
   </form>

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
    
    <sec:authorize access="hasRole('ROLE_ADMIN')">
    <button type="button" id="" onclick="location.href='${pageContext.request.contextPath}/notice/write'">
    글쓰기
    </button>
    </sec:authorize>
    
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    
    <!-- 페이지 번호 출력 -->
    <div id="pageNumDiv"></div>
    
<script type="text/javascript">
//CSRF 토큰 관련 정보 저장
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

// Ajax 기능을 사용하여 요청하는 모든 웹 프로그램에게 CSRF 토큰 전달 가능
// ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

$(document).ready(function() { // JSP가 렌더링되자마자,
	
    $("#pageSizeSelect").hide(); 
    page = 1;
    size = 10;
    keyword ='';   
    noticeListDisplay(page, size, keyword);

    $("#pageSizeSelect").change(function() {
  	  var functionName =  "noticeListDisplay";
  	  
        var selectedPageSize = parseInt($(this).val());
        window[functionName](page, selectedPageSize, keyword);
   });
    
 
	   // 공지 사항 버튼 클릭 시
	   $("#notice-info").click(function() {
		   $("#pageSizeSelect").show();
		   $("#pageNumDiv").show();
		   $("#searchDiv").show();
	      page = 1;
	      size = 10;
	      keyword ='';
	       noticeListDisplay(page, size, keyword);
	       
	       $("#pageSizeSelect").val(size);
	    });
	
	   // 검색 버튼 클릭 시
	   $("#searchDiv").on("click", "#searchButton", function() {
	        performSearch();
	    });
	   
	   // 초기화 버튼
	   $("#searchDiv").on("click", "#resetButton", function() {
		   noticeListDisplay();
	    });
	   
	   // 작성 버튼
	   $("#searchDiv").on("click", "#addButton", function() {
		   window.location.href = "${pageContext.request.contextPath}/notice/write";
	    });

	});

var page = 1; // 기본 페이지 번호 설정
var size = 10; // 기본 페이지 크기 설정
var keyword = ''; // 기본 검색어 = NULL

//공지 사항 목록 출력
function noticeListDisplay(pageNum, pageSize, selectKeyword) {
	$("#pageSizeSelect").show();
	$("#pageNumDiv").show();
	$("#searchDiv").show();
	
   page=pageNum;
   size=pageSize;
   keyword=selectKeyword;
   
    $.ajax({
        method: "GET",
        url: "<c:url value='/notice/list'/>",
        data: {"pageNum": pageNum, "pageSize": pageSize, "selectKeyword": selectKeyword},
        dataType: "json",
        success: function(result) {
        	
        	var totalBoard = result.pager.totalBoard;
			
        	$("#totalBoard").html(totalBoard);
            $("#tbody").empty();
            
            if (result.noticeList.length == 0) { 
            	("#tbody").append("<tr><td colspan='4'>등록된 공지 사항이 없습니다.</td></tr>");
            } else {
            
	            for (var i = 0; i < result.noticeList.length; i++) {
	                var noticeList = result.noticeList[i];
	                var row = "<tr data-idx='" + noticeList.noticeIdx + "'>" +
	                   		  "<td>" + noticeList.noticeIdx + "</td>" +
	                   		  "<td><a href=\"<c:url value='/notice'/>/" + noticeList.noticeIdx + "\">" + noticeList.noticeTitle + "</a></td>" +
	                   		  "<td>" + noticeList.noticeRegdate + "</td>" +
	                   		  "<td>" + noticeList.noticeViewcnt + "</td>" +
	                   		  "</tr>";
	                $("#tbody").append(row);
	            }
            }
            var searchDiv = $("#searchDiv");
           
            // 기존 테이블 및 내용 삭제
            searchDiv.empty();

         	searchDiv.append(
             	"<button id='searchButton' class='' style='float:right; margin-right:150px; height:48px;'>검색</button>"+
            	"<button id='resetButton' class='' style='float:right; margin-right:150px; height:48px;'>초기화</button>"+
             	"<button id='addButton' class='' style='float:right; margin-right:150px; height:48px;'>작성하기</button>"+
             	"<input type='text' class='' id='selectKeyword' placeholder='제목, 내용으로 검색해보세요!' style='width:250px; height:4px; float:right; margin-right:10px;'>"
            	);
          
            // 페이지 번호 출력
            pageNumDisplay(result.pager);
            // 페이지 당 출력 갯수를 출력
           pageSizeDisplay();
        },
        error: function(xhr) {
            alert("공지 사항 목록을 불러오는 중에 오류가 발생했습니다. (에러 코드 = " + xhr.status + ")");
        }
    });
}

//페이지 번호를 출력
function pageNumDisplay(pager) {
    var html = "";
    if (pager.startPage > pager.blockSize) {
        html += "<a href=\"javascript:noticeListDisplay(" + pager.prevPage + ", " + size + ", '" + keyword + "');\" class=''><i class='fa fa-long-arrow-left'/></a>";
    } else {
        html += "<a class='' disabled ><i class='dasasd'><</i></a>";
    }

    for (var i = pager.startPage; i <= pager.endPage; i++) {
        if (pager.pageNum != i) {
            html += "<a class='' href=\"javascript:noticeListDisplay(" + i + ", " + size + ", '" + keyword + "');\">" + i + "</a>";
        } else {
            html += "<a class='' disabled>" + i + "</a>";
        }
    }

    if (pager.endPage != pager.totalPage) {
        html += "<a href=\"javascript:noticeListDisplay(" + pager.prevPage + ", " + size + ", '" + keyword + "');\" class=''><i class='fa fa-long-arrow-left'/></a>";
    } else {
        html += "<a class='' disabled><i class='asdasd'>></i></a>";
    }

    $("#pageNumDiv").html(html);
}

// 페이지 당 출력 갯수를 설정
function pageSizeDisplay() {
    // 페이지 크기 선택
    var pageSizeSelect = $("#pageSizeSelect");

    pageSizeSelect.empty(); // 기존 옵션 초기화

    var pageSizeOptions = [10, 20, 50, 100];
    for (var i = 0; i < pageSizeOptions.length; i++) {
        var optionValue = pageSizeOptions[i];
        var optionText = optionValue + "개씩 보기";

        var option = $("<option>").val(optionValue).text(optionText);

        if (optionValue === size) {
            option.prop("selected", true);
        }
        pageSizeSelect.append(option);
    }
}

//공지 사항 상세 정보 보기
function noticeDetail(noticeidx) {
    $.ajax({
        method: "GET",
        url: "<c:url value='/notice'/>/" + noticeidx,
        data: {"noticeidx": noticeidx},
        dataType: "html",
        success: function(html) {
            var noticeDetailDiv = $("<div>").html(html); // HTML을 DOM 요소로 변환
            $("#noticeListInfo").empty().append(noticeDetailDiv); // 기존 내용 지우고 새로운 내용 삽입
        },
        error: function(xhr) {
            alert("공지 사항 상세보기를 불러오는 중에 오류가 발생했습니다. 에러 코드 = (" + xhr.status + ")");
        }
    });
}

//검색
function performSearch() {
    var selectKeyword = $("#selectKeyword").val();
      
        noticeListDisplay(1, size, selectKeyword);
}

document.addEventListener("keyup", function(event) {
    if (event.keyCode === 13) {
        alert('Enter is pressed!');
    }
});

</script>
</body>
</html>