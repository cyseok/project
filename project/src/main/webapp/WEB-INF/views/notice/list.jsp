<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<!-- 게시글 수를 출력 -->
    <select id="pageSizeSelect"></select>
    
    <!-- 검색 창 출력 -->
    <div id="searchDiv"></div>

	<!-- 게시글 목록 출력 -->
    <div id="infoListDiv"></div>
    
    <sec:authorize access="hasRole('ROLE_ADMIN')">
    <button type="button" id="" onclick="location.href='${pageContext.request.contextPath}/notice/write'">
    글쓰기
    </button>
    </sec:authorize>
    
    <!-- 페이지 번호 출력 -->
    <div id="pageNumDiv"></div>
    
<script type="text/javascript">
//CSRF 토큰 관련 정보를 자바스크립트 변수에 저장
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

// Ajax 기능을 사용하여 요청하는 모든 웹 프로그램에게 CSRF 토큰 전달 가능
// ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

var page = 1; // 기본 페이지 번호 설정
var size = 10; // 기본 페이지 크기 설정
var keyword = ''; // 기본 검색어 = NULL String
var infoType = ''; // 기본 검색 타입 나중에 추가해주기 => NULL String(notice, qa 등등)

//공지 사항 목록 출력 함수
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
            $("#infoListDiv").empty();
            
            var table = $("<table>").attr("id", "noticeInfoTable");
            var thead = $("<thead>").append(
                "<tr>" +
                "<th>번호</th>" +
                "<th>제목</th>" +
                "<th>작성일</th>" +
                "<th>조회수</th>" +
                "</tr>"
            );

            var tbody = $("<tbody>");

            if (result.noticeList.length == 0) { // 검색된 게시글이 없을 때
                var row = "<tr>" +
                    "<td colspan='10'>검색된 공지 사항이 없습니다.</td>" +
                    "</tr>";
                tbody.append(row);
            } 
            for (var i = 0; i < result.noticeList.length; i++) {
                var noticeList = result.noticeList[i];
                var row = "<tr data-idx='" + noticeList.noticeidx + "'>" +
                    "<td>" + noticeList.noticeidx + "</td>" +
                    "<td><a href=\"<c:url value='/notice/detail/{noticeIdx}' />?idx=" + noticeList.noticeidx + "\">" + 
                    noticeList.noticeTitle + "</a></td>" +
                    "<td>" + noticeList.noticeRegdate + "</td>" +
                    "<td>" + noticeList.noticeViewcnt + "</td>" +
                    "</tr>";
                tbody.append(row);
            }


            table.append(thead, tbody);
            
            $("#infoListDiv").append(table);
            
            var searchDiv = $("#searchDiv");
           
            // 기존 테이블 및 내용 삭제
            searchDiv.empty();

         searchDiv.append(
             "<button id='searchButton' class='' style='float:right; margin-right:150px; height:48px;'>검색</button>"+
            "<input type='text' class='' id='selectKeyword' placeholder='제목, 내용으로 검색해보세요!' style='width:250px; height:4px; float:right; margin-right:10px;'>"
            )
          
            // 페이지 번호 출력
            pageNumDisplay(result.pager, infoType);
            
            // 페이지 당 출력 갯수를 출력
           pageSizeDisplay();
            
        },
        
        error: function(xhr) {
            alert("공지 사항 목록을 불러오는 중에 오류가 발생했습니다. (에러 코드 = " + xhr.status + ")");
        }
    });
}


//페이지 번호를 출력하는 함수
function pageNumDisplay(pager, infoType) {
    var html = "";
    if (pager.startPage > pager.blockSize) {
        html += "<a href=\"javascript:" + infoType + "ListDisplay(" + pager.prevPage + ", " + size + ", '" + keyword + "');\" class=''><i class=''/></a>";
    } else {
        html += "<a class='' disabled ><i class=''/></a>";
    }

    for (var i = pager.startPage; i <= pager.endPage; i++) {
        if (pager.pageNum != i) {
            html += "<a class='' href=\"javascript:" + infoType + "ListDisplay(" + i + ", " + size + ", '" + keyword + "');\">" + i + "</a>";
        } else {
            html += "<a class='' disabled>" + i + "</a>";
        }
    }

    if (pager.endPage != pager.totalPage) {
        html += "<a href=\"javascript:" + infoType + "ListDisplay(" + pager.prevPage + ", " + size + ", '" + keyword + "');\" class=''><i class=''/></a>";
    } else {
        html += "<a class='' disabled><i class=''/></a>";
    }

    $("#pageNumDiv").html(html);
}

// 페이지 당 출력 갯수를 설정하는 함수
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
        url: "<c:url value='/notice/detail'/>?noticeidx=" + noticeidx,
        data: {"noticeidx": noticeidx},
        dataType: "html",
        success: function(html) {
            var noticeDetailDiv = $("<div>").html(html); // HTML을 DOM 요소로 변환
            $("#infoListDiv").empty().append(noticeDetailDiv); // 기존 내용 지우고 새로운 내용 삽입
        },
        error: function(xhr) {
            alert("공지 사항 상세보기를 불러오는 중에 오류가 발생했습니다. 에러 코드 = (" + xhr.status + ")");
        }
    });
}

//검색하는 함수
function performSearch() {
    var selectKeyword = $("#selectKeyword").val();
      if (infoType == "question") {
        questionListDisplay(1, size, selectKeyword);
    } else if (infoType == "notice") {
        noticeListDisplay(1, size, selectKeyword);
    }
}

$(document).ready(function() { // JSP가 렌더링되자마자,
      $("#pageSizeSelect").hide(); 
      page = 1;
      size = 10;
      keyword ='';   
      infoType = "notice";
      noticeListDisplay(page, size, keyword);

      $("#pageSizeSelect").change(function() {
    	  var functionName = infoType + "ListDisplay";
    	  
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
	      infoType = "notice";
	       noticeListDisplay(page, size, keyword);
	       
	       $("#pageSizeSelect").val(size);
	    });
	
	   // 검색 버튼 클릭 시
	   $("#searchDiv").on("click", "#searchButton", function() {
	        performSearch();
	    });
	
	    // Enter 키를 눌렀을 때 검색 버튼 클릭과 동일한 기능 실행
	    $(document).on("keydown", "#selectKeyword", function(event) {
	        if (event.key === "Enter") {
	            performSearch();
	        }
	    });
	    
	 // 공지사항 tr 태그 클릭 시 상세 정보 보기로 이동
	    $("#infoListDiv").on("click", "#noticeInfoTable tbody tr", function() {
	        var idx = $(this).data("idx");
	        window.location.href = "<c:url value='/notice/detail' />?noticeidx=" + noticeidx;
	    });


});
</script>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

<!--  기존 테이블 데이터 불러오는 방식  
		<form action="<c:url value="/notice/"/>" method="get" class="search-area">   
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
	 ======================================================== 
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
-->

</body>
</html>