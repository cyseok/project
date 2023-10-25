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
              <h3 class="tit">제목 : ${resultMap.notice.noticeTitle}</h3>
              <p class="t1" id="regdate">작성일: ${resultMap.notice.noticeRegdate }</p>
              <input type="text" id="regdate">
              <p class="t1">조회수: ${resultMap.notice.noticeViewcnt }</p>
           </div>
           <hr>
           <div class="view_con" style="white-space:pre;">${resultMap.notice.noticeContent}</div>
           
           <c:if test="${not empty resultMap.notice.noticeImg}">
             <img src="<c:url value='/resources/upload/${resultMap.notice.noticeImg}' />" >
       	   </c:if>
           <c:if test="${not empty resultMap.notice.noticeFile}">
               <!-- 파일 다운로드 링크 -->
               <p>첨부 파일 다운로드 : 
                 <a href="<c:url value='/resources/upload/${resultMap.notice.noticeFile}' />" download="${resultMap.notice.noticeFile}">${resultMap.notice.noticeFileName}</a>
               </p>
              <hr>
    	</c:if>

           <div class="">
              <div class="">
              	<button type="button" id="" onclick="location.href='${pageContext.request.contextPath}/notice'">목록으로</button>
              	<button type="button" id="" onclick="location.href='${pageContext.request.contextPath}/notice/modify/${resultMap.notice.noticeIdx}'">수정하기</button>
              </div>

              		<!-- 폼 추가 
                      <form id="deleteForm" action="${pageContext.request.contextPath}/notice/delete/${notice.noticeIdx}" method="POST">-->
                          <!-- CSRF 토큰 등을 포함하려면 여기에 추가 -->
                          <!-- 예: <input type="hidden" name="_csrf" value="${_csrf.token}"> -->
                      
                      <!-- 삭제 버튼 -->
                     <button type="button" class="" id="deleteBtn">삭 제</button>
                </div>
              </div>
              
              <div id="noticeDetail"></div>
              
              <div id="prenumNextnum"></div>
              
           <div class="" style="width:100%;"> 
                   <div class="" style="margin-right: 20px;">  
                    <c:choose>
                       <c:when test="${resultMap.preNumNextNum.prevNum ne null }">
                           <a href="<c:url value='/notice'/>/${resultMap.preNumNextNum.prevNum}" class="" id="prevButton"><i class=""></i><span>이전글</span></a>
                       </c:when>
                       <c:otherwise>
                          <div class="space"></div>
                       </c:otherwise>
                    </c:choose>
					<div class=""></div>
                    <c:choose>
                       <c:when test="${resultMap.preNumNextNum.nextNum ne null }">
						<a href="<c:url value='/notice'/>/${resultMap.preNumNextNum.nextNum}" class="" id="nextButton"><span>다음글</span><i class=""></i></a>
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
    var noticeIdx = notice.noticeIdx;

    // Ajax 기능을 사용하여 요청하는 모든 웹 프로그램에게 CSRF 토큰 전달 가능
    // ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
    $(document).ajaxSend(function(e, xhr){
    	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    });
    //=====================================
    	// 제발...
function noticeDetailDisplay(noticeIdx) {
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
        	
            $("#noticeListInfo").empty();
            
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
                var row = "<tr data-idx='" + noticeList.noticeIdx + "'>" +
                    "<td>" + noticeList.noticeIdx + "</td>" +
                    "<td><a href=\"<c:url value='/notice'/>/" + noticeList.noticeIdx + "\">" + 
                    noticeList.noticeTitle + "</a></td>" +
                    "<td>" + noticeList.noticeRegdate + "</td>" +
                    "<td>" + noticeList.noticeViewcnt + "</td>" +
                    "</tr>";
                tbody.append(row);
            }


            table.append(thead, tbody);
            
            $("#noticeListInfo").append(table);
            
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
            
           // window.location.href = "${pageContext.request.contextPath}/notice/list";
            
        },
        
        error: function(xhr) {
            alert("공지 사항 목록을 불러오는 중에 오류가 발생했습니다. (에러 코드 = " + xhr.status + ")");
        }
    });
}
    //=========================================
	$(document).ready(function() {
		var notice = ${notice.noticeIdx};
	    // Make an Ajax call to fetch the data from the REST API
	    $.ajax({
	        url: "<c:url value='/notice/detail'/>/" + noticeidx, // Replace with your actual endpoint
	        method: "GET",
	        success: function(data) {
	            // Handle the data received from the server
	            // You can access specific fields using data.fieldName
	            var noticeData = data.notice.noticeIdx;
	
	            // Insert the received data into the input element
	            $("#regdate").val(noticeData); // Assuming 'noticeData' contains the data to be inserted
	        },
	        error: function() {
	            // Handle any errors here
	            console.error("Failed to fetch notice details.");
	        }
	    });
	});
    //=================================================
function noticeDetail(noticeIdx) {
    $.ajax({
        method: "GET",
        url: "<c:url value='/notice/detail'/>/" + noticeidx,
        data: {"noticeidx": noticeidx},
        dataType: "json",
        success: function(result) {
            $("#regdate").val(result.notice.noticeRegdate)
        },
        error: function(xhr) {
            alert("공지 사항을 불러오는 중에 오류가 발생했습니다. 에러 코드 = (" + xhr.status + ")");
        }
    });
}

    $(document).ready(function(){
        $("#deleteBtn").click(function() {
        	if (confirm("자료를 정말로 삭제 하시겠습니까?")) {
        	// var idx = ${resultMap.notice.noticeIdx};
    		// var idx=${sessionScope.idx};
    		
    	
            $.ajax({
                type: "DELETE",
                url: "<c:url value='/notice'/>",
                data: {'noticeIdx' : noticeIdx},
                contentType: false,
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