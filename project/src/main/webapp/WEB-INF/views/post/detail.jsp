<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
	<title>게시글</title>
	
<style>
  .detail-image {
    width: 70px;
    height: 70px;
  }
  .heart-image {
    width: 48px;
    height: 44px;
    margin-left: 350px;
  }
  .post-detail {
    margin-top: 80px; 
    width: 75%;
    margin-left: auto;
    margin-right: auto;
  }
  #postTitle {
    font-size: 45px;
    font-weight: bold;
    margin-left: 20px;
    margin-top: 50px;
  }
  #postNickname {
    font-size: 18px;
    font-weight: bold;
    margin-left: 10px;
    margin-top: 10px;
  }
  #postNickname::after {
    content: "|";
    margin: 0 15px;
    font-weight: normal; 
  }
  #postRegdate {
    font-size: 18px;
    margin: 0 5px;
    font-weight: bold; 
  }
  #postView {
    font-size: 18px;
    margin: 0 10px;
    font-weight: bold; 
  }
  #postLikecnt {
    font-size: 20px;
    margin: 0 5px;
    font-weight: bold; 
  }
  #postRegdateDay {
    font-size: 17px;
    margin: 0 5px;
    font-weight: normal; 
  }
  .dayType {
    font-size: 25px;
    font-weight: normal; 
  }
  .dayTypeValue {
    font-size: 25px;
    font-weight: bold;
    margin-left: 25px; 
  }
  .post-button {
    display: flex;
    justify-content: flex-end;
  }

  .post-button button {
    float: right;
    margin: 7px 7px;
  }
  .post-info {
    margin-top: 10px;
  } 
  #contentTitle {
    font-size: 20px;
    font-weight: normal; 
    margin-left: 13px; 
  }
  .postContent {
    font-size: 25px;
    margin-left: 13px; 
  }
</style>
</head>

<header>
  <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>
<body>
  <div class="section">
    <div class="container">
      <div class="row">
      <section class="post-detail">
      
        
        <div class="post-button">
          <sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_SOCIAL', 'ROLE_MASTER')">
          <button type="button" class="btn btn-primary">수정 하기</button>
          <button type="button" class="btn btn-primary" onclick="postDelete()">삭제 하기</button>
          </sec:authorize>
          <button type="button" class="btn btn-secondary" id="prevButton">이전글</button>
          <button type="button" class="btn btn-secondary" id="nextButton">다음글</button>
        </div>
        
        <div>
          <p id="postTitle"></p>
        </div>
                     
        <div class="post-info">
          <img src="${pageContext.request.contextPath}/assets/images/login.png" class="detail-image">
          <span id="postNickname"></span>
          <span id="postRegdate"></span>
          <span id="postRegdateDay"></span>
          
          <sec:authorize access="isAnonymous()">
            <img role="button" src="${pageContext.request.contextPath}/assets/images/heart_before.jpg" id="postLike" class="heart-image" onclick="login()">
          </sec:authorize>
          <sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_SOCIAL', 'ROLE_MASTER')">
            <img role="button" src="${pageContext.request.contextPath}/assets/images/heart_before.jpg" id="postLike" class="heart-image">
          </sec:authorize>
          
          <span id="postLikecnt"></span>
        </div>
        
        <div>
          <span id="postView"></span>
        </div>
        
        <hr>
        <br>
        
        <section>
          <ul style="list-style-type: none; margin-left: -23px;">
            <li style="margin-bottom: 30px;">
              <span class="dayType">요일</span>
              <span class="dayTypeValue" id="postDayType"></span>
            </li>
            <li style="margin-bottom: 30px;">
              <span class="dayType">대기</span>
              <span class="dayTypeValue" id="postTag"></span>
            </li>
            <li style="margin-bottom: 30px;">
              <span class="dayType">장소</span>
              <span class="dayTypeValue" id="postLoc"></span>
            </li>
            <li style="margin-bottom: 30px;">
              <span class="dayType">주소</span>
              <span class="dayTypeValue" id="postAddress"></span>
            </li>
          </ul>
        
        </section>
        <hr>
        <p id="contentTitle">내용</p>
        <div class="postContent" id="postContent">
        </div>
        
        </section>
      
      </div>
    </div>
  </div>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
var userinfoId = "${sessionScope.userinfoId}";

var currentURL = window.location.href;
var parts = currentURL.split('/');
var postIdx = parts[parts.length - 1];

$(document).ajaxSend(function(e, xhr){
   	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

$(document).ready(function() {
	postDetail();
});

function postDetail() { 
	$('#loading').show();
	
	$.ajax({
        method: "GET",
        url: "<c:url value='/post/detail'/>/" + postIdx,
        data: {"postIdx": postIdx
        	   , "userinfoId": userinfoId
        	},
        dataType: "json",
        success: function(result) {
        	$('#loading').hide();
        	
        	var post = result.content[0].post;
        	var prevNum = result.content[0].prevNumNextNum.prevnum;
        	var nextNum = result.content[0].prevNumNextNum.nextnum;
        	
        	if (post === null) {
        		alert("존재하지 않는 글입니다.");
        		window.location.href = "${pageContext.request.contextPath}/post"
        	} else {
        		
        		$("#postTitle").text(post.postTitle);
        		
        		if(post.nickname === null) {
        			$("#postNickname").html("닉네임 없음");
        		} else {
        			$("#postNickname").text(post.nickname);
        		}
        		$("#postRegdate").text(post.postRegdate);
        		$("#postRegdateDay").text(post.day);
        		$("#postView").html("조회수 : " + post.postViewcnt);
        		$("#postLikecnt").text(post.postLikes);
        		$("#postDayType").text(getPostDayType(post.postDayType));
        		$("#postTag").text(getPostTag(post.postTag));
        		$("#postLoc").text(post.postLoc);
        		$("#postAddress").text(post.postAddress);
        		$("#postContent").html(post.postContent);
        		
        		if(prevNum != 0) {
	            	$("#prevButton").attr("onclick", "location.href='${pageContext.request.contextPath}/post/" + prevNum +"'");
	            } else {
	            	$("#prevButton").remove();
				}
	            
	            if(nextNum != 0) {
	            	$("#nextButton").attr("onclick", "location.href='${pageContext.request.contextPath}/post/" + nextNum +"'");
	            } else {
	            	$("#nextButton").remove();
				}
        	}
        },
        error: function(error) {
            alert("오류가 발생했습니다.");
            window.location.href = "${pageContext.request.contextPath}/post";
	    }
	});
}

function getPostDayType(postDayType) {
    if (postDayType === 1) {
        return "평일";
    } else {
        return "주말, 공휴일";
    }
}

function getPostTag(day) {
    if (day === 1) {
        return "사람 없어요^^";
    } else if (day === 2) {
        return "웨이팅 없어요.";
    } else if (day === 3) {
        return "웨이팅 보통..(약30분)";
    } else {
        return "웨이팅 많아요ㅠㅠ(1시간이상)";
    }
}

// 게시글 삭제 
function postDelete() {   

    if (confirm("자료를 정말로 삭제 하시겠습니까?")) {
    	$('#loading').show();
    	
        $.ajax({
            type: "DELETE",
            url: "<c:url value='/post'/>/" + postIdx,
            data: {'postIdx' : postIdx},
            contentType: false,
            success: function(data, textStatus, xhr) {
            	$('#loading').hide();
                if (xhr.status == 204) {
	                alert("게시글이 삭제되었습니다");
	                window.location.href = "${pageContext.request.contextPath}/post"
                } else {
                	alert("글 삭제에 실패했습니다.");
                	window.location.href = "${pageContext.request.contextPath}/post/"+postIdx;
                } 
            },
            error: function(error) {
            	console.log(error);
                alert("오류가 발생했습니다.");
                window.location.href = "${pageContext.request.contextPath}/post";
    	    }
       });
    } 
}

// 비로그인 시 추천 클릭
function login() {
	alert("로그인 후 이용가능합니다.");
}
</script>
</body>
</html>