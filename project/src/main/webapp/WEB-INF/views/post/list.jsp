<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="UTF-8">
<title>웨이팅 확인!!</title>
<head>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/post-list.css">
</head>

<header>
  <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>

<body>
  <div class="content-section">
	<div class="hero overlay" style="height: 670px;">
		<div class="img-bg rellax" >
			<img src="${pageContext.request.contextPath}/assets/images/hero_2.jpg" alt="Image" class="img-fluid">
		</div>
		
		<div class="container">
			<div class="row align-items-center justify-content-start">
				<div class="col-lg-6 mx-auto text-center">

					<h1 class="heading" data-aos="fade-up">웨이팅 체크!!</h1>
					<p class="mb-4" data-aos="fade-up">현재 있는 곳의 사람이 얼마나 많은지 게시물을 올려주세요!!
					<br>
					사람이 많아 가기 망설여지는 사람들에게 도움을 줄 수 있습니다.
					<br>
					<br>
					일반 사용자 계정 
					<br>
					ID : user1
					<br>
					PW : !User123
					<br>
					<br>
					관리자 계정
					<br> 
					ID : test1
					<br>
					PW : !Xptmxm1  
					</p>
				</div>
			</div>
		</div>
	</div>
  </div>

  <div class="section">
  <div class="nav-buttons">
    <span role="button" id="recentButton" onclick="recentlySearch()" style="margin-right: 17px; font-size: 35px; color: #444444;">최신순</span>
    <span role="button" id="viewButton" onclick="viewSearch()" style="margin-right: 17px; font-size: 35px; color: #999999;"> 조회순</span>
    <span role="button" id="likeButton" onclick="likeSearch()" style="margin-right: 17px; font-size: 35px; color: #999999;"> 인기순</span>
    <span role="button" id="commentButton" onclick="commentSearch()" style="margin-right: 17px; font-size: 35px; color: #999999;"> 댓글순</span>
  </div>
  
  <div class="search-buttons">
    <input class="inp-base" type="text" id="searchKeyword" name="selectKeyword" placeholder="제목, 내용으로 검색해보세요.">
    <button type="button" id="searchButton" class="btn btn-secondary" onclick="postSearch()">검색</button>
  </div>
  
	<div class="container" style="margin-top: 100px;">
		<div class="row align-items-stretch" id="postList">
		</div>	
	</div>		
  </div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
    <button class="top-button">⬆︎</button>
		
<script>

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

var recently = true;
var view = false;
var like = false;
var comment = false;

var postScroll = true;

var offset = 0; 
var limit = 16; 
var selectKeyword = ''; 
var viewType = 'recently';

$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

$(document).ready(function() {
	offset = 0; 
	limit = 16; 
    postListDisplay(offset, limit, selectKeyword, viewType);
    if(recently === true) {
    	var button = document.getElementById('recentButton');
        button.style.fontWeight = 'bold';
    }
    
    if (postScroll === true) {
    	$(window).scroll(scrollHandler);
    }
});

// 무한 스크롤 기능
function scrollHandler() {
    if (postScroll === true && $(window).scrollTop() + $(window).height() >= $(document).height() - 1) {
        $('#loading').show();
        offset += limit;
        postListDisplay(offset, limit, selectKeyword, viewType);
    }
}

$("#searchKeyword").keypress(function(){
	if(event.keyCode == 13) {
		 postSearch();
	}
});

//게시글 목록 출력
function postListDisplay(offset, limit, selectKeyword, viewType) {
	postScroll = true;
	$('#loading').show();
	
    $.ajax({
        method: "GET",
        url: "<c:url value='/api/posts'/>",
        
        data: {"offset": offset
        		, "limit": limit
        		, "selectKeyword": selectKeyword
        		, "viewType": viewType
        	},
        dataType: "json",
        success: function(result) {
        	$('#loading').hide();
        	
        	if (result.content.length === 0) { 
        		postScroll = false;
        		console.log(postScroll);
        	} else if(result.content.length < 16) {
        		for (var i = 0; i < result.content.length; i++) {
	                var postList = result.content[i];
	                var postElement2 = 
	                	$("<div class='col-12 col-sm-6 col-md-4 col-lg-3 mb-4 clickable-post' data-aos='fade-up' data-aos-delay='100' data-aos-duration='800'>" +
	                		"<a href='${pageContext.request.contextPath}/posts/" + postList.postIdx + "'>" +
	                          "<div class='media-entry'>" +
	                            "<div class='bg-white m-body'>" +
	                              "<span class='date'>" + postList.postRegdate + "</span>" +
	                              "<span class='float-right'>" + 
	                              (function() {
	                                  if (postList.postDayType === 1) {
	                                      return "평일";
	                                  } else {
	                                      return "공휴일, 주말";
	                                  }
	                              })() +
	                              "</span>" +
	                              "<span class='float-left' title='"+postList.postLoc+"'>" + postList.postLoc + "</span>" +
	                              "<p class='styled-text' title='"+postList.postTitle+"'>" + postList.postTitle + "</p>" +
	                              "<hr class='position-line'>" +
	                              "<img src='${pageContext.request.contextPath}/assets/images/login.png' class='login-image'>" +
	                              "<span class='bottom-left'>" + (postList.nickname === null || postList.nickname === "" ? "닉네임없음" : postList.nickname) + "</span>" +
	                              "<span class='bottom-right'>" + postList.postViewcnt + " views</span>" +
	                            "</div>" +
	                          "</div>" +
	                        "</a>" +
	                    "</div>");
	                
	                $("#postList").append(postElement2);
	            }
	            postScroll = false;
	            
            } else {
				         	
	            for (var i = 0; i < result.content.length; i++) {
	                var postList = result.content[i];
	                var postElement2 = 
	                	$("<div class='col-12 col-sm-6 col-md-4 col-lg-3 mb-4 clickable-post' data-aos='fade-up' data-aos-delay='100' data-aos-duration='800'>" +
	                		"<a href='${pageContext.request.contextPath}/posts/" + postList.postIdx + "'>" +
	                          "<div class='media-entry'>" +
	                            "<div class='bg-white m-body'>" +
	                              "<span class='date'>" + postList.postRegdate + "</span>" +
	                              "<span class='float-right'>" + 
	                              (function() {
	                                  if (postList.postDayType === 1) {
	                                      return "평일";
	                                  } else {
	                                      return "공휴일, 주말";
	                                  }
	                              })() +
	                              "</span>" +
	                              "<span class='float-left' title='"+postList.postLoc+"'>" + postList.postLoc + "</span>" +
	                              "<p class='styled-text' title='"+postList.postTitle+"'>" + postList.postTitle + "</p>" +
	                              "<hr class='position-line'>" +
	                              "<img src='${pageContext.request.contextPath}/assets/images/login.png' class='login-image'>" +
	                              "<span class='bottom-left'>" + (postList.nickname === null || postList.nickname === "" ? "닉네임없음" : postList.nickname) + "</span>" +
	                              "<span class='bottom-right'>" + postList.postViewcnt + " views</span>" +
	                            "</div>" +
	                          "</div>" +
	                        "</a>" +
	                    "</div>");
	                
	                $("#postList").append(postElement2);
	                
	            }
            }
        },
        error: function(error) {
      
          console.log("===============================================================");
          console.log(error);
          console.log("===============================================================");
        }
    });
}

// 검색
function postSearch() {
	$("#postList").empty();
    selectKeyword = $("#searchKeyword").val();
    offset = 0;
    postScroll = true;
    postSearchDisplay(offset, limit, selectKeyword, viewType);
}

// 검색
function postSearchDisplay(offset, limit, selectKeyword, viewType) {
	$('#loading').show();
	
    $.ajax({
        method: "GET",
        url: "<c:url value='/api/posts'/>",
        
        data: {"offset": offset
        		, "limit": limit
        		, "selectKeyword": selectKeyword
        		, "viewType": viewType
        	},
        dataType: "json",
        success: function(result) {
        	console.log(result.content.length);
        	$('#loading').hide();
        	
        	if (result.content.length === 0) { 
        		postScroll = false;
        		console.log(postScroll);
        		var postElement1 = $("<p style='font-size: 25px;'>검색결과가 없습니다.</p>");
        		$("#postList").append(postElement1);
        		
        		
        	} else if(result.content.length <= 16) {
        		for (var i = 0; i < result.content.length; i++) {
	                var postList = result.content[i];
	                var postElement2 = 
	                	$("<div class='col-12 col-sm-6 col-md-4 col-lg-3 mb-4 clickable-post' data-aos='fade-up' data-aos-delay='100' data-aos-duration='800'>" +
	                		"<a href='${pageContext.request.contextPath}/posts/" + postList.postIdx + "'>" +
	                          "<div class='media-entry'>" +
	                            "<div class='bg-white m-body'>" +
	                              "<span class='date'>" + postList.postRegdate + "</span>" +
	                              "<span class='float-right'>" + 
	                              (function() {
	                                  if (postList.postDayType === 1) {
	                                      return "평일";
	                                  } else {
	                                      return "공휴일, 주말";
	                                  }
	                              })() +
	                              "</span>" +
	                              "<span class='float-left' title='"+postList.postLoc+"'>" + postList.postLoc + "</span>" +
	                              "<p class='styled-text' title='"+postList.postTitle+"'>" + postList.postTitle + "</p>" +
	                              "<hr class='position-line'>" +
	                              "<img src='${pageContext.request.contextPath}/assets/images/login.png' class='login-image'>" +
	                              "<span class='bottom-left'>" + (postList.nickname === null || postList.nickname === "" ? "닉네임없음" : postList.nickname) + "</span>" +
	                              "<span class='bottom-right'>" + postList.postViewcnt + " views</span>" +
	                            "</div>" +
	                          "</div>" +
	                        "</a>" +
	                    "</div>");
	                
	                $("#postList").append(postElement2);
	            }
	            postScroll = false;
            } else {
				  	
	            for (var i = 0; i < result.content.length; i++) {
	                var postList = result.content[i];
	                var postElement2 = 
	                	$("<div class='col-12 col-sm-6 col-md-4 col-lg-3 mb-4 clickable-post' data-aos='fade-up' data-aos-delay='100' data-aos-duration='800'>" +
	                		"<a href='${pageContext.request.contextPath}/posts/" + postList.postIdx + "'>" +
	                          "<div class='media-entry'>" +
	                            "<div class='bg-white m-body'>" +
	                              "<span class='date'>" + postList.postRegdate + "</span>" +
	                              "<span class='float-right'>" + 
	                              (function() {
	                                  if (postList.postDayType === 1) {
	                                      return "평일";
	                                  } else {
	                                      return "공휴일, 주말";
	                                  }
	                              })() +
	                              "</span>" +
	                              "<span class='float-left' title='"+postList.postLoc+"'>" + postList.postLoc + "</span>" +
	                              "<p class='styled-text' title='"+postList.postTitle+"'>" + postList.postTitle + "</p>" +
	                              "<hr class='position-line'>" +
	                              "<img src='${pageContext.request.contextPath}/assets/images/login.png' class='login-image'>" +
	                              "<span class='bottom-left'>" + (postList.nickname === null || postList.nickname === "" ? "닉네임없음" : postList.nickname) + "</span>" +
	                              "<span class='bottom-right'>" + postList.postViewcnt + " views</span>" +
	                            "</div>" +
	                          "</div>" +
	                        "</a>" +
	                    "</div>");
	                
	                $("#postList").append(postElement2);
	                
	            }
            }
        },
        error: function(request,textStatus,errorThrown) {
      
          console.log("===============================================================");
          console.log("[textStatus] "+ JSON.stringify(textStatus));
          console.log("[errorThrown] "+ JSON.stringify(errorThrown));
          console.log("===============================================================");
        }
    });
}
            
// 최근순으로 정렬
function recentlySearch() {
	$("#postList").empty();
	offset = 0;
	limit = 16; 
    viewType = 'recently';
    
	postScroll = true;
	
    recently = true;
    view = false;
    like = false;
    comment = false;
    
    var button1 = document.getElementById('recentButton');
    var button2 = document.getElementById('viewButton');
    var button3 = document.getElementById('likeButton');
    var button4 = document.getElementById('commentButton');
    
    postListDisplay(offset, limit, selectKeyword, viewType);
    
    if(recently === true) {
    	button1.style.fontWeight = 'bold';
    	button1.style.color = '#444444';
    	button2.style.fontWeight = 'normal';
    	button2.style.color = '#999999';
    	button3.style.fontWeight = 'normal';
    	button3.style.color = '#999999';
    	button4.style.fontWeight = 'normal';
    	button4.style.color = '#999999';
    }
}

//조회순으로 정렬
function viewSearch() {
	$("#postList").empty();
	offset = 0; 
	postScroll = true;
	recently = false;
    view = true;
    like = false;
    comment = false;
    
    viewType = 'view';
    var button1 = document.getElementById('recentButton');
    var button2 = document.getElementById('viewButton');
    var button3 = document.getElementById('likeButton');
    var button4 = document.getElementById('commentButton');
    
    postListDisplay(offset, limit, selectKeyword, viewType);
    
    if(view === true) {
    	button1.style.fontWeight = 'normal';
    	button1.style.color = '#999999';
    	button2.style.fontWeight = 'bold';
    	button2.style.color = '#444444';
    	button3.style.fontWeight = 'normal';
    	button3.style.color = '#999999';
    	button4.style.fontWeight = 'normal';
    	button4.style.color = '#999999';
    }
}

// 인기순으로 정렬
function likeSearch() {
	$("#postList").empty();
	offset = 0; 
	postScroll = true;
	recently = false;
    view = false;
    like = true;
    comment = false;
    
    viewType = 'like';
    var button1 = document.getElementById('recentButton');
    var button2 = document.getElementById('viewButton');
    var button3 = document.getElementById('likeButton');
    var button4 = document.getElementById('commentButton');
    
    postListDisplay(offset, limit, selectKeyword, viewType);
    
    if(like === true) {
    	button1.style.fontWeight = 'normal';
    	button1.style.color = '#999999';
    	button2.style.fontWeight = 'normal';
    	button2.style.color = '#999999';
    	button3.style.fontWeight = 'bold';
    	button3.style.color = '#444444';
    	button4.style.fontWeight = 'normal';
    	button4.style.color = '#999999';
    }
}

// 댓글순으로 정렬
function commentSearch() {
	$("#postList").empty();
	offset = 0; 
	postScroll = true;
	recently = false;
    view = false;
    like = false;
    comment = true;
    
    viewType = 'comment';
    var button1 = document.getElementById('recentButton');
    var button2 = document.getElementById('viewButton');
    var button3 = document.getElementById('likeButton');
    var button4 = document.getElementById('commentButton');
    
    postListDisplay(offset, limit, selectKeyword, viewType);
    
    if(comment === true) {
    	button1.style.fontWeight = 'normal';
    	button1.style.color = '#999999';
    	button2.style.fontWeight = 'normal';
    	button2.style.color = '#999999';
    	button3.style.fontWeight = 'normal';
    	button3.style.color = '#999999';
    	button4.style.fontWeight = 'bold';
    	button4.style.color = '#444444';
    }
}
</script>

<script>
$(".top-button").click(function() {
	  window.scrollTo(0, 0);
});
</script>

	
</body>
</html>
