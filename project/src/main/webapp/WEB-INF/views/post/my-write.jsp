<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<meta charset="UTF-8">
<title>나의 작성글</title>
<head>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
</head>

<header>
  <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>
<body>
<div class="section">
  <div class="container" style="margin-top: 150px;">
    <div class="row" id="myWriteList">
    
    </div>
  </div>
</div>



<sec:csrfInput/>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
var userinfoId = "${sessionScope.userinfoId}";
console.log(userinfoId);

$(document).ajaxSend(function(e, xhr){
   	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

$(document).ready(function() {
	myWritePost(userinfoId);
});

function myWritePost(userinfoId) {
	$('#loading').show();
	
    $.ajax({
        method: "GET",
        url: "<c:url value='/post/my-postwrite'/>",
        data: {"userinfoId": userinfoId},
        success: function(result) {
        	$('#loading').hide();
        	
        	console.log(result);
        	if (result.length === 0) { 
        		var postElement1 = $("<p style='font-size: 25px;'>검색결과가 없습니다.</p>");
        		$("#myWriteList").append(postElement1);
            } else {
				// 공지사항 목록 출력            	
	            for (var i = 0; i < result.length; i++) {
	                var postList = result[i];
	                var postElement2 = 
	                	$("<div class='col-12 d-inline-block mb-4' data-aos='fade-up' data-aos-delay='100'>" +
	                		"<a href='${pageContext.request.contextPath}/post/" + postList.postIdx + "'>" +
	                            "<div class='write m-body'>" +
	                              "<span class='date'>" + postList.postRegdate + "</span>" +
	                              "<span class='float-left' title='"+postList.postLoc+"'>" + postList.postLoc + "</span>" +
	                              "<p class='styled-text' title='"+postList.postTitle+"'>" + postList.postTitle + "</p>" +
	                              "<hr class='position-line'>" +
	                            "</div>" +
	                        "</a>" +
	                    "</div>");
	                
	                $("#myWriteList").append(postElement2);
	                
	            }
            }
        },
        error: function(error) {
        	console.log("error");
        	console.log(error);
        }
    });
}
</script>
</body>
</html>