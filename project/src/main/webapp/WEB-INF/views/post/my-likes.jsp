<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<meta charset="UTF-8">
<title>나의 추천글</title>
<head>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/my-likes.css">
</head>

<header>
  <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>
<body>
<div class="section">
  <div class="container" style="margin-top: 150px;">
    <div class="row" id="myLikesList">
    
    </div>
  </div>
</div>

<sec:csrfInput/>





<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
var userinfoId = "${sessionScope.userinfoId}";

$(document).ajaxSend(function(e, xhr){
   	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

$(document).ready(function() {
	myLikesPost(userinfoId);
});

//게시글 목록 출력
function myLikesPost(userinfoId) {
	$('#loading').show();
	
    $.ajax({
        method: "GET",
        url: "<c:url value='/post/my-postlikes'/>",
        data: {"userinfoId": userinfoId},
        success: function(result) {
        	$('#loading').hide();
        	
        	console.log(result);
        	
        	if (result.length === 0) { 
        		var postElement1 = $("<p style='font-size: 25px;'>내 관심글이 없습니다.</p>");
        		$("#myLikesList").append(postElement1);
            } else {
				     	
	            for (var i = 0; i < result.length; i++) {
	                var postList = result[i];
	                var postElement2 = 
	                	$("<div class='col-12 d-inline-block mb-4' data-aos='fade-up' data-aos-delay='100'>" +
	                		"<a href='${pageContext.request.contextPath}/post/" + postList.postIdx + "'>" +
	                            "<div class='likes m-body'>" +
	                              "<span class='date'>" + postList.postRegdate + "</span>" +
	                              "<span class='float-left' title='"+postList.postLoc+"'>" + postList.postLoc + "</span>" +
	                              "<p class='styled-text' title='"+postList.postTitle+"'>" + postList.postTitle + "</p>" +
	                              "<hr class='position-line'>" +
	                              "<img src='${pageContext.request.contextPath}/assets/images/login.png' class='login-image'>" +
	                              "<span class='bottom-left'>" + (postList.nickname === null || postList.nickname === "" ? "닉네임없음" : postList.nickname) + "</span>" +
	                            "</div>" +
	                        "</a>" +
	                    "</div>");
	                
	                $("#myLikesList").append(postElement2);
	                
	            }
            }
        	
        },
        error: function(error) {
        	console.log(error);
        }
    });
}
</script>
</body>
</html>