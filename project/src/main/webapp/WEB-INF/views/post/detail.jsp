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
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/post-detail.css">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- include summernote css/js -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<title>게시글</title>
</head>

<header>
  <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>
<body>
  <div class="section">
    <div class="container">
      <div class="row">
      <section class="post-detail">
      
      	<input type="hidden" name="userinfoId" id="userinfoId" value="${sessionScope.userinfoId}">
        
        <div class="post-button">
          <sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_SOCIAL')">
          <button type="button" class="btn btn-primary" id="editButton" style="display: none;">수정 하기</button>
          <button type="button" class="btn btn-primary" id="deleteButton" onclick="postDelete()" style="display: none;">삭제 하기</button>
          </sec:authorize>
          <sec:authorize access="hasAnyRole('ROLE_MASTER')">
          <button type="button" class="btn btn-primary" id="editButton">수정 하기</button>
          <button type="button" class="btn btn-primary" id="deleteButton" onclick="postDelete()">삭제 하기</button>
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
            <img role="button" src="" id="postLike" class="heart-image" onclick="login()">
          </sec:authorize>
          <sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_SOCIAL', 'ROLE_MASTER')">
            <img role="button" src="" id="postLike" class="heart-image" onclick="likesCheck()">
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
        
        
        <!-- 댓글 -->
        <div class="" style="margin-top: 300px;">
        <hr style="width: 100%; margin-left: auto; margin-right: auto;">
        	<div class="">
        	  <span class="" id="comment-number">댓글 수 : </span>
        	  <span class="" id="comment-count"></span>
        	</div>	
        	
		 	<div class="comment-input">
		 		
		 		<sec:authorize access="isAnonymous()">
		 		  <textarea name="commentContent" id="commentContent" rows="3" placeholder=" 댓글을 입력해주세요." disabled></textarea>
	              <button type="button" id="commentAdd" class="btn btn-primary" onclick="login()">댓글 등록</button>
	            </sec:authorize>
	            <sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_SOCIAL', 'ROLE_MASTER')">
	              <textarea name="commentContent" id="commentContent" rows="3" placeholder=" 댓글을 입력해주세요." maxlength="300"></textarea>
	              <button type="button" id="commentAdd" class="btn btn-primary" onclick="commentAdd()">댓글 등록</button>
	            </sec:authorize>
		 	</div>
  
			<div class="post-comment" id="comment-list" style="margin-top: 50px;">
			</div>	
	    </div>
	    <!-- 댓글 -->
        </section>
      
      </div>
    </div>
  </div>
  
  <form id="postModifyForm" style="display: none;">
	  <div class="post-form">
	    <label class="post-label">제목</label>
	    <textarea name="postTitle" id="postTitleModify" class="form-control" rows="2" placeholder="제목을 입력해주세요."></textarea>
	  </div>
	  <hr style="width: 60%; margin-left: auto; margin-right: auto;">
	  <div class="post-form">
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postDayType" id="dayTypeModify" value="1" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">평일</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postDayType" id="dayTypeModify" value="2" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">주말, 공휴일</span>				
	    </label>
	  </div>
	  <hr style="width: 60%; margin-left: auto; margin-right: auto;">
	  <div class="post-form">
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTagModify" value="1" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">사람없음</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTagModify" value="2" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">웨이팅없음</span>				
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTagModify" value="3" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">웨이팅 조금</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTagModify" value="4" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">웨이팅 김</span>				
	    </label>
	  </div>
	  
	  <div class="post-form">
	      <label class="post-label">지역</label>
	      <div class="post-search">
	        <input type="hidden" name="postAddress" id="postAddressModify">
	        <input name="postLoc" id="postLocModify" placeholder="내용을 입력해주세요.">
	        <img id="searchImg" role="button" src="${pageContext.request.contextPath}/assets/images/search.png">
	        <img id="xImg" role="button" src="${pageContext.request.contextPath}/assets/images/xmark.png" onclick="clearInput()">
	      </div>
	      <div id="resultContainer"></div>
	  </div>
	  
	  <div class="post-form">
	    <textarea name="postContent" id="summernote">
	    </textarea>
	  </div>  
	  
	    <div class="post-form d-flex justify-content-end">
	      <button type="submit" class="btn btn-primary" >수정하기</button>
	      <button type="button" id="cancelBtn" class="btn btn-secondary ml-2">취 소</button>
	    </div>
	  <sec:csrfInput/>
  </form>
  

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
	commentList();
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
        	var likes = result.content[0].likes;
        	
        	if (post === null) {
        		alert("존재하지 않는 글입니다.");
        		window.location.href = "${pageContext.request.contextPath}/post"
        	} else {
        		
        		if(post.nickname === null) {
        			$("#postNickname").html("닉네임 없음");
        		} else {
        			$("#postNickname").text(post.nickname);
        		}
        		
        		if(likes === null) {
        			$("#postLike").attr("src", "${pageContext.request.contextPath}/assets/images/heart_before.jpg");
        		} else {
        			$("#postLike").attr("src", "${pageContext.request.contextPath}/assets/images/heart_after.jpg");
        			$("#postLike").attr("onclick", "likesCancel()");
        		}
        		// 게시글 작성자와 로그인한 사용자를 비교해 삭제, 수정버튼 활성화
        		if (userinfoId === post.userinfoId) {
        			$("#editButton").show();
        		    $("#deleteButton").show();
        		}
        		
        		$("#postTitle").text(post.postTitle);
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
	            
				// 수정 폼 데이터
        		$("#postTitleModify").text(post.postTitle);
        		$("#postLocModify").val(post.postLoc);
        		$("#postAddressModify").val(post.postAddress);
        		$("#editor").append(post.postContent);
        		
			    var tagCheck = document.querySelector('input[name="postTag"][value="' + post.postTag + '"]');
			    
			    if (tagCheck) {
			    	tagCheck.checked = true;
			    }
			    
				var dayTypeCheck = document.querySelector('input[name="postDayType"][value="' + post.postDayType + '"]');
			    
			    if (dayTypeCheck) {
			    	dayTypeCheck.checked = true;
			    }
			    
			    $('#summernote').summernote('code', post.postContent);
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

// 추천 기능
function likesCheck() {   
	
	var postLikecnt = document.querySelector('#postLikecnt').textContent;
	postLikecnt = parseInt(postLikecnt) + 1;
	$("#postLikecnt").text(postLikecnt);
	
	$("#postLike").attr("src", "${pageContext.request.contextPath}/assets/images/heart_after.jpg");
	$("#postLike").removeAttr("onclick");
	setTimeout(function() {
        $("#postLike").attr("onclick", "likesCancel()");
    }, 3000);
	
       $.ajax({
           type: "POST",
           url: "<c:url value='/post/likesCheck'/>/",
           data: {"postIdx" : postIdx
        	      , "userinfoId": userinfoId
        	   },
           success: function(response) {
           },
           error: function(error) {
           	console.log(error);
           	postLikecnt = parseInt(postLikecnt) - 1;
     	    $("#postLikecnt").text(postLikecnt);
   	       }
      });
}

// 추천 취소
function likesCancel() {  
	
	var postLikecnt = document.querySelector('#postLikecnt').textContent;
	postLikecnt = parseInt(postLikecnt) - 1;
	$("#postLikecnt").text(postLikecnt);
	
	$("#postLike").attr("src", "${pageContext.request.contextPath}/assets/images/heart_before.jpg");
	$("#postLike").removeAttr("onclick");
	setTimeout(function() {
        $("#postLike").attr("onclick", "likesCheck()");
    }, 3000);

       $.ajax({
           type: "POST",
           url: "<c:url value='/post/likesCancel'/>/",
           data: {"postIdx" : postIdx
     	        , "userinfoId": userinfoId
    	      },
    	   success: function(response) {
           },
           error: function(error) {
           	console.log(error);
           	postLikecnt = parseInt(postLikecnt) + 1;
     	    $("#postLikecnt").text(postLikecnt);
   	       }
      });
}

function clearInput() {
    var searchInputTitle = document.getElementById('postLocModify');
    var searchInputAdress = document.getElementById('postAddressModify');

    searchInputTitle.value = '';
    searchInputAdress.value = '';
}
// 수정하기
$(document).ready(function() {
	$("#editButton").click(function() {
	    // 수정 폼을 표시하거나 숨기기
	    $("#postModifyForm").toggle();
	    $(".post-detail").hide();
	});
	$("#cancelBtn").click(function() {
	    // 수정 폼을 표시하거나 숨기기
	    $("#postModifyForm").toggle();
	    $(".post-detail").show();
	});
});

// 수정 폼 제출시
$("form").submit(function(e) {
    e.preventDefault(); 
    
    $('#loading').show();
    var editorContent = $('#summernote').summernote('code');
    
    console.log(editorContent);
    
    var formData = new FormData();
    formData.append("postTitle", $("#postTitleModify").val());
    formData.append("postIdx", postIdx);
    formData.append("postDayType", $("input[name='postDayType']:checked").val());
    formData.append("postTag", $("input[name='postTag']:checked").val());
    formData.append("postLoc", $("#postLocModify").val());
    formData.append("postAddress", $("#postAddressModify").val());
    formData.append("postContent", editorContent);

    $.ajax({
        type: "post",
        url: "<c:url value='/post/modify'/>",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "text",
        success: function (data, textStatus, xhr) {
        	console.log(data);
        	console.log(xhr.status);
            if (xhr.status == 201) {
            	$('#loading').hide();
                alert("게시글을 수정하였습니다.");
                window.location.reload();
            } else {
                alert("수정을 실패하였습니다.");
            }
        }, error: function(error) {
        	$('#loading').hide();
            console.log("post-Error:", error);
        }
    });
});
</script>

<script>
// 댓글 목록 출력
function commentList() {
	
    $.ajax({
        method: "GET",
        url: "<c:url value='/comment/comment-list'/>/" + postIdx,
        data: {"postIdx": postIdx},
        dataType: "json",
        success: function(result) {
        	$("#comment-count").text(result.length);
        	
        	// 댓글이 1개 이상일때
        	if (result.length > 0) { 
        		
				// 댓글 목록 출력            	
	            for (var i = 0; i < result.length; i++) {
	                var commentList = result[i];
	                var commnetElement = 
	                	$("<div class='col-12 mb-4' id='comment-"+commentList.commentIdx+"' data-aos='fade-up' data-aos-delay='10'>" +
	                          "<div class='media-entry' id=''>" +
	                              "<img src='${pageContext.request.contextPath}/assets/images/login.png' class='comment-image'>" +
	                              "<p class='comment-nickname' id='comment-nickname-"+commentList.commentIdx+"'>" + (commentList.nickname === null || commentList.nickname === "" ? "닉네임없음" : commentList.nickname + " (" + commentList.userinfoId.substring(0, 3) + "***)") + "</p>" +
	                              "<p class='comment-date' id='comment-date-"+commentList.commentIdx+"' title='"+commentList.commentRegdate+"'>" + commentList.commentRegdate + "</p>" +
	                              "<div id='comment-modify-"+commentList.commentIdx+"'>" +
	                                "<p class='comment-content' id='comment-content-"+commentList.commentIdx+"' title='"+commentList.commentContent+"'>" + commentList.commentContent + "</p>" +
	                                (function() {
	                                    if (userinfoId === commentList.userinfoId) {
	                                        return "<button type='button' id='comment-modify-button' class='btn btn-danger' data-comment-modifyButton-idx='"+commentList.commentIdx+"' onclick='commentModifyButton();'>수정</button>" +
	              					        	   "<button type='button' id='comment-delete-button' class='btn btn-danger' data-comment-delete-idx='"+commentList.commentIdx+"' onclick='commentDelete();'>삭제</button>";
	                                    } else {
	                                	    // else 처리하지 않으면 undefined 출력됨
	                                        return "";
	                                    }
	                                 })() +
	                              "</div>" +
	                              
	                              "<div class='commentArea' id='comment-textarea-"+commentList.commentIdx+"'>" +
	                                "<textarea class='comment-content-modify' id='comment-modify-content-"+commentList.commentIdx+"' rows='3' maxlength='300'>"+commentList.commentContent+"</textarea>" +
	                                "<button type='button' id='comment-modify-button' class='btn btn-danger' data-comment-modifyCancel-idx='"+commentList.commentIdx+"' onclick='commentModifyCancel();'>취소</button>" +
            				        "<button type='button' id='comment-delete-button' class='btn btn-danger' data-comment-modify-idx='"+commentList.commentIdx+"' onclick='commentModify();'>등록</button>" +
	                              "</div>" +
	                              (function() {
	                                  if (userinfoId === commentList.userinfoId) {
	                                      return "<button type='button' id='comment-button-"+commentList.commentIdx+"' class='btn btn-success'  data-comment-replyShow-idx='"+commentList.commentIdx+"' onclick='replyShowButton()'><span>답글 </span><span id='reply-count-"+commentList.commentIdx+"'></span></button>";
	                                  } else {
	                                	  // else 처리하지 않으면 undefined 출력됨
	                                      return "<button type='button' id='comment-button1-"+commentList.commentIdx+"' class='btn btn-success'  data-comment-replyShow-idx='"+commentList.commentIdx+"' onclick='replyShowButton()'><span>답글 </span><span id='reply-count-"+commentList.commentIdx+"'></span></button>";
	                                  }
	                              })() +
	                           "</div>" +
	                           
	                           "<div class='' id='reply-button-"+commentList.commentIdx+"'>" +
	                              "<div class='' id='reply-list-"+commentList.commentIdx+"'>" +
	                              "</div>" +
	                           "</div>" +
	                           
	                        "<hr class='comment-line'>" +
	                    "</div>");
	                
	                $("#comment-list").append(commnetElement);
	                
	                var replyNum = commentList.commentIdx;
	                
	                replyList(replyNum);
	                
	                // 답글 출력
	                function replyList(replyNum) {
	                	
		                $.ajax({
					        method: "GET",
					        url: "<c:url value='/comment/reply-list'/>/" + replyNum,
					        data: {"parentIdx": replyNum},
					        dataType: "json",
					        success: function(result) {
					        	 
					        	if (result.length > 0) { 
									// 답글 목록 출력            	
						            for (var i = 0; i < result.length; i++) {
						                var replytList = result[i];
						                var replyElement = 
						                	$("<div class='reply-list' id='replyList-"+replytList.commentIdx+"' data-aos='fade-up' data-aos-delay='10'>" +
						                          "<div class='media-entry'>" +
						                              "<hr class='reply-line'>" +
						                              "<img src='${pageContext.request.contextPath}/assets/images/login.png' class='reply-image'>" +
						                              "<p class='reply-nickname' id='reply-nickname-"+replytList.commentIdx+"'>" + (replytList.nickname === null || replytList.nickname === "" ? "닉네임없음" : replytList.nickname + " (" + replytList.userinfoId.substring(0, 3) + "***)") + "</p>" +
						                              "<p class='reply-date' id='reply-date-"+replytList.commentIdx+"' title='"+replytList.commentRegdate+"'>" + replytList.commentRegdate + "</p>" +
						                              
						                              // 이건 댓글에서 쓰던거
						                              "<div id='comment-modify-"+replytList.commentIdx+"'>" +
						                              "<p class='reply-content' id='comment-content-"+replytList.commentIdx+"' title='"+replytList.commentContent+"'>" + replytList.commentContent + "</p>" +
						                              (function() {
						                                  if (userinfoId === replytList.userinfoId) {
						                                	  return "<button type='button' id='reply-modify-button' class='btn btn-danger' data-comment-modifyButton-idx='"+replytList.commentIdx+"' onclick='commentModifyButton();'>수정</button>" +
						                                             "<button type='button' id='reply-delete-button' class='btn btn-danger' data-reply-delete-idx='"+replytList.commentIdx+"' data-reply-parent-idx='"+replytList.parentIdx+"' onclick='replyDelete();'>삭제</button>";
						                                  } else {
						                                	  // else 처리하지 않으면 undefined 출력됨
						                                      return "";
						                                  }
						                              })() +
						                          "</div>" +
						                              
						                          "<div id='comment-textarea-"+replytList.commentIdx+"'>" +
					                                "<textarea class='reply-content-modify' id='comment-modify-content-"+replytList.commentIdx+"' rows='2' maxlength='300'>"+replytList.commentContent+"</textarea>" +
					                                "<button type='button' id='reply-modify-button' class='btn btn-danger' data-comment-modifyCancel-idx='"+replytList.commentIdx+"' onclick='commentModifyCancel();'>취소</button>" +
				            				        "<button type='button' id='reply-delete-button' class='btn btn-danger' data-reply-modify-idx='"+replytList.commentIdx+"' onclick='replyModify();'>등록</button>" +
					                              "</div>" +
					                              "</div>" +
						                    "</div>");
						                
						                $("#reply-list-" + replytList.parentIdx).append(replyElement);
						                
						              }
									
						            
					                var replyButton = 
					                	$("<div class='reply-input' id='reply-"+replyNum+"' data-aos='fade-up' data-aos-delay='10'>" +
					                		  "<hr class='reply-line'>" +
					                		  "<sec:authorize access='isAnonymous()'>" +
					                		  "<textarea name='commentContent' id='reply-content-' rows='3' placeholder=' 답글을 입력해주세요.' disabled></textarea>" +
					                		  "<button type='button' id='replyAdd' class='btn btn-primary' onclick='login()'>답글 등록</button>" +
					                		  "</sec:authorize>" +
					                		  "<sec:authorize access='hasAnyRole(\"ROLE_USER\", \"ROLE_ADMIN\", \"ROLE_SOCIAL\", \"ROLE_MASTER\")'>" +
					                		  "<textarea name='commentContent' id='reply-content-"+replytList.parentIdx+"' rows='3' placeholder=' 답글을 입력해주세요.' maxlength='300'></textarea>" +
					                		  "<button type='button' id='replyAdd' class='btn btn-primary' onclick='replyAdd()' data-comment-replyAdd-idx='"+replytList.parentIdx+"'>답글 등록</button>" +
					                		  "</sec:authorize>" +
					                    "</div>");
					                
					                $("#reply-button-" + replytList.parentIdx).append(replyButton);
		 		 	
						            $("#reply-count-" + replytList.parentIdx).text(result.length);
						            
					            } else {
					            	
					            	var replyButton1 = 
					                	$("<div class='reply-input' id='reply-"+replyNum+"' data-aos='fade-up' data-aos-delay='10'>" +
					                		  "<hr class='reply-line'>" +
					                		  "<sec:authorize access='isAnonymous()'>" +
					                		  "<textarea name='commentContent' id='reply-content-' rows='3' placeholder=' 댓글을 입력해주세요.' disabled></textarea>" +
					                		  "<button type='button' id='replyAdd' class='btn btn-primary' onclick='login()'>답글 등록</button>" +
					                		  "</sec:authorize>" +
					                		  "<sec:authorize access='hasAnyRole(\"ROLE_USER\", \"ROLE_ADMIN\", \"ROLE_SOCIAL\", \"ROLE_MASTER\")'>" +
					                		  "<textarea name='commentContent' id='reply-content-"+replyNum+"' rows='3' placeholder=' 댓글을 입력해주세요.' maxlength='300'></textarea>" +
					                		  "<button type='button' id='replyAdd' class='btn btn-primary' onclick='replyAdd()' data-comment-replyAdd-idx='"+replyNum+"'>답글 등록</button>" +
					                		  "</sec:authorize>" +
					                    "</div>");
					                
					                $("#reply-button-" + replyNum).append(replyButton1);
					                
					            	$("#reply-count-" + replyNum).text(result.length);
					            }
					        	 
					        }, error: function(error) {
					            console.log("comment-Error:", error);
					        }
					    });
	                }
	                
	            }
            } 
		 
        }, error: function(error) {
            console.log("comment-Error:", error);
        }
    });
}

/* 댓글, 답글 중복 제출 방지 */
var commentButton = document.getElementById("commentAdd");

function commentDisableButton() {

   commentButton.disabled = true;
	
   setTimeout(function () {
     commentButton.disabled = false;
   }, 1000);
} 

function replyDisableButton() {

	var replyButton = document.getElementById("replyAdd");
	replyButton.disabled = true;
		
	   setTimeout(function () {
		   replyButton.disabled = false;
	   }, 1000);
	}
 
//댓글 등록
function commentAdd() {  
	
	var commentContent = $("#commentContent").val();
	
	if (commentContent === "") {
      alert('댓글 내용을 작성해주세요.');
      var commentFocus = document.getElementById("commentContent");
      commentFocus.focus();

      return false;
    }
	
	var random32 = Math.random().toString(32).substr(2, 8);
	var randomNum = postIdx + "-" + random32;
	
	commentDisableButton();
	
    var formData = new FormData();
    formData.append("commentIdx", randomNum);
    formData.append("postIdx", postIdx);
    formData.append("userinfoId", $("#userinfoId").val());
    formData.append("parentIdx", 0);
    formData.append("commentContent", commentContent);
    
    $.ajax({
        type: "POST",
        url: "<c:url value='/comment'/>",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "text",
        success: function (data, textStatus, xhr) {
        	var parsedData = JSON.parse(data);
            console.log(parsedData);
            if (xhr.status == 200) {
            	// 입력 값 지워주기
			    var replyInput = document.getElementById('commentContent');
			    replyInput.value = '';
			    
			    // 댓글 개수 +1
				var commentCount = document.getElementById("comment-count").textContent;
				commentCount++;
				document.getElementById("comment-count").textContent = commentCount;
				
				// 등록한 댓글 출력
				var commnetElement = 
	                	$("<div class='col-12 mb-4' id='comment-"+parsedData.commentIdx+"' data-aos='fade-up' data-aos-delay='10'>" +
	                          "<div class='media-entry' id=''>" +
	                              "<img src='${pageContext.request.contextPath}/assets/images/login.png' class='comment-image'>" +
	                              "<p class='comment-nickname' id='comment-nickname-"+parsedData.commentIdx+"'>" + (parsedData.nickname === null || parsedData.nickname === "" ? "닉네임없음" : parsedData.nickname + " (" + parsedData.userinfoId.substring(0, 3) + "***)") + "</p>" +
	                              "<p class='comment-date' id='comment-date-"+parsedData.commentIdx+"' title='"+parsedData.commentRegdate+"'>" + parsedData.commentRegdate + "</p>" +
	                              "<div id='comment-modify-"+parsedData.commentIdx+"'>" +
	                                "<p class='comment-content' id='comment-content-"+parsedData.commentIdx+"' title='"+parsedData.commentContent+"'>" + parsedData.commentContent + "</p>" +
	                                "<button type='button' id='comment-modify-button' class='btn btn-danger' data-comment-modifyButton-idx='"+parsedData.commentIdx+"' onclick='commentModifyButton();'>수정</button>" +
	              					"<button type='button' id='comment-delete-button' class='btn btn-danger' data-comment-delete-idx='"+parsedData.commentIdx+"' onclick='commentDelete();'>삭제</button>" +
	                              "</div>" +
	                              
	                              "<div class='commentArea' id='comment-textarea-"+parsedData.commentIdx+"'>" +
	                                "<textarea class='comment-content-modify' id='comment-modify-content-"+parsedData.commentIdx+"' rows='3' maxlength='300'>"+parsedData.commentContent+"</textarea>" +
	                                "<button type='button' id='comment-modify-button' class='btn btn-danger' data-comment-modifyCancel-idx='"+parsedData.commentIdx+"' onclick='commentModifyCancel();'>취소</button>" +
            				        "<button type='button' id='comment-delete-button' class='btn btn-danger' data-comment-modify-idx='"+parsedData.commentIdx+"' onclick='commentModify();'>등록</button>" +
	                              "</div>" +
	                              
	                              "<button type='button' id='comment-button-"+parsedData.commentIdx+"' class='btn btn-success'  data-comment-replyShow-idx='"+parsedData.commentIdx+"' onclick='replyShowButton()'><span>답글 </span><span id='reply-count-"+parsedData.commentIdx+"'>0</span></button>" +
	                           "</div>" +
	                           
	                           "<div class='' id='reply-button-"+parsedData.commentIdx+"'>" +
	                              "<div class='' id='reply-list-"+parsedData.commentIdx+"'>" +
	                              "</div>" +
	                           "</div>" +
	                           
	                        "<hr class='comment-line'>" +
	                    "</div>");
	                
	                $("#comment-list").append(commnetElement);
	            
	            // 답글 등록 버튼
                var replyButton = 
                	$("<div class='reply-input' id='reply-"+parsedData.commentIdx+"' data-aos='fade-up' data-aos-delay='10'>" +
                		  "<hr class='reply-line'>" +
                		  "<sec:authorize access='isAnonymous()'>" +
                		  "<textarea name='commentContent' id='reply-content-' rows='3' placeholder=' 답글을 입력해주세요.' disabled></textarea>" +
                		  "<button type='button' id='replyAdd' class='btn btn-primary' onclick='login()'>답글 등록</button>" +
                		  "</sec:authorize>" +
                		  "<sec:authorize access='hasAnyRole(\"ROLE_USER\", \"ROLE_ADMIN\", \"ROLE_SOCIAL\", \"ROLE_MASTER\")'>" +
                		  "<textarea name='commentContent' id='reply-content-"+parsedData.commentIdx+"' rows='3' placeholder=' 답글을 입력해주세요.' maxlength='300'></textarea>" +
                		  "<button type='button' id='replyAdd' class='btn btn-primary' onclick='replyAdd()' data-comment-replyAdd-idx='"+parsedData.commentIdx+"'>답글 등록</button>" +
                		  "</sec:authorize>" +
                    "</div>");
	                
	                $("#reply-button-" + parsedData.commentIdx).append(replyButton);
            }
        }, error: function(error) {
            console.log("comment-Error:", error);
        }
    });
}

// 답글 등록
function replyAdd() {  
	
	var replyIdx = event.currentTarget.getAttribute("data-comment-replyAdd-idx");
	console.log(replyIdx);
	var replycontent = $("#reply-content-"+replyIdx).val();
	
	if (replycontent === "") {
      alert('답글 내용을 작성해주세요.');
      var replyFocus = document.getElementById("reply-content-"+replyIdx);
      replyFocus.focus();

      return false;
    }
	
	replyDisableButton();
	
	var random32 = Math.random().toString(32).substr(2, 8);
	var randomNum = postIdx + "-" + random32;
	var gsdfgsd = 123123123;
	
    var formData = new FormData();
    formData.append("commentIdx", randomNum);
    formData.append("postIdx", postIdx);
    formData.append("userinfoId", $("#userinfoId").val());
    formData.append("parentIdx", replyIdx);
    formData.append("commentContent", replycontent);
    // parentIdx 가 정수면 삽입이 잘 되는거같은데 뭐가 문제일까........
    $.ajax({
        type: "POST",
        url: "<c:url value='/comment'/>",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "text",
        success: function (data, textStatus, xhr) {
        	var parsedData = JSON.parse(data);
            console.log("parsedData:", parsedData);
            
            if (xhr.status == 200) {
            	
            	// 입력 값 지워주기
			    var replyInput = document.getElementById('reply-content-'+replyIdx);
    			replyInput.value = '';
			    
			    // 답글 개수 +1
				var replyCount = document.getElementById("reply-count-"+replyIdx).textContent;
				replyCount++;
				document.getElementById("reply-count-"+replyIdx).textContent = replyCount;
				
				// 등록한 답글 출력
            	var replyElement = 
	                	$("<div class='reply-list' id='replyList-"+parsedData.commentIdx+"' data-aos='fade-up' data-aos-delay='100'>" +
	                          "<div class='media-entry'>" +
	                              "<hr class='reply-line'>" +
	                              "<img src='${pageContext.request.contextPath}/assets/images/login.png' class='reply-image'>" +
	                              "<p class='reply-nickname' id='reply-nickname-"+parsedData.commentIdx+"'>" + (parsedData.nickname === null || parsedData.nickname === "" ? "닉네임없음" : parsedData.nickname + " (" + parsedData.userinfoId.substring(0, 3) + "***)") + "</p>" +
	                              "<p class='reply-date' id='reply-date-"+parsedData.commentIdx+"' title='"+parsedData.commentRegdate+"'>" + parsedData.commentRegdate + "</p>" +
	                              
	                              "<div id='comment-modify-"+parsedData.commentIdx+"'>" +
	                                 "<p class='reply-content' id='comment-content-"+parsedData.commentIdx+"' title='"+parsedData.commentContent+"'>" + parsedData.commentContent + "</p>" +
	                                 "<button type='button' id='reply-modify-button' class='btn btn-danger' data-comment-modifyButton-idx='"+parsedData.commentIdx+"' onclick='commentModifyButton();'>수정</button>" +
	                                 "<button type='button' id='reply-delete-button' class='btn btn-danger' data-reply-delete-idx='"+parsedData.commentIdx+"' data-reply-parent-idx='"+parsedData.parentIdx+"' onclick='replyDelete();'>삭제</button>"+
	                              "</div>" +
	                              
	                              "<div id='comment-textarea-"+parsedData.commentIdx+"'>" +
	                                "<textarea class='reply-content-modify' id='comment-modify-content-"+parsedData.commentIdx+"' rows='2' maxlength='300'>"+parsedData.commentContent+"</textarea>" +
	                                "<button type='button' id='reply-modify-button' class='btn btn-danger' data-comment-modifyCancel-idx='"+parsedData.commentIdx+"' onclick='commentModifyCancel();'>취소</button>" +
	          				        "<button type='button' id='reply-delete-button' class='btn btn-danger' data-reply-modify-idx='"+parsedData.commentIdx+"' onclick='replyModify();'>등록</button>" +
	                             "</div>" +
	                          "</div>" +
	                     "</div>");
	                
	                $("#reply-list-" + replyIdx).append(replyElement);
            }
            
        }, error: function(error) {
            console.log("reply-Error:", error);
        }
    });
}

// 댓글 수정
function commentModify() {  
	
	var commentIdx = event.currentTarget.getAttribute("data-comment-modify-idx");
	var commentModifyContent = $("#comment-modify-content-"+commentIdx).val();
	
    $.ajax({
        type: "PATCH",
        url: "<c:url value='/comment/'/>" + commentIdx,
        data: JSON.stringify({'commentIdx': commentIdx,'commentContent' : commentModifyContent}),
        contentType: 'application/json',
        dataType: "text",
        success: function (data, textStatus, xhr) {
            if (xhr.status == 200) {
            	// 기존 수정 내용 변경
			    var commentInput = document.getElementById('comment-modify-content-'+commentIdx);
			    commentInput.value = commentModifyContent;
			    // 기존 댓글 내용 변경
			    var pTags = $("p[id='comment-content-" + commentIdx + "']");
			    pTags.text(commentModifyContent);
			    
				var commentInput = document.getElementById("comment-textarea-"+commentIdx);
				var comment = document.getElementById("comment-modify-"+commentIdx);
				
				commentInput.style.display = "none";
				comment.style.display = "block";
			    
            }
        }, error: function(error) {
            console.log("comment-Error:", error);
        }
    });
}

// 답글 수정
function replyModify() {  
	
	var replyIdx = event.currentTarget.getAttribute("data-reply-modify-idx");
	var replyModifyContent = $("#comment-modify-content-"+replyIdx).val();
    
    $.ajax({
        type: "PATCH",
        url: "<c:url value='/comment/'/>" + replyIdx,
        data: JSON.stringify({'commentIdx': replyIdx,'commentContent' : replyModifyContent}),
        contentType: 'application/json',
        dataType: "text",
        success: function (data, textStatus, xhr) {
            if (xhr.status == 200) {
            	// 기존 수정 내용 변경
			    var replyInput = document.getElementById('comment-modify-content-'+replyIdx);
			    replyInput.value = replyModifyContent;
			    // 기존 댓글 내용 변경
			    var pTags = $("p[id='comment-content-" + replyIdx + "']");
			    pTags.text(replyModifyContent);
			    
				var commentInput = document.getElementById("comment-textarea-"+replyIdx);
				var comment = document.getElementById("comment-modify-"+replyIdx);
				
				commentInput.style.display = "none";
				comment.style.display = "block";
				
            	// $("#reply-list-"+replyIdx).append(commnetElement);
            }
        }, error: function(error) {
            console.log("comment-Error:", error);
        }
    });
}

// 댓글 삭제
function commentDelete() {  
	
	var deleteCommentIdx = event.currentTarget.getAttribute("data-comment-delete-idx");
	
    if (confirm("댓글을 삭제 하시겠습니까?")) {
    	
        $.ajax({
            type: "DELETE",
            url: "<c:url value='/comment'/>/" + deleteCommentIdx,
            data: {'commentIdx' : deleteCommentIdx},
            contentType: false,
            success: function(data, textStatus, xhr) {
            	
                if (xhr.status == 204) {
                	$("#comment-" + deleteCommentIdx).remove();
                	// 댓글 개수 -1
					var commentCount = document.getElementById("comment-count").textContent;
					commentCount--;
					document.getElementById("comment-count").textContent = commentCount;
                } else {
                	alert("댓글 삭제에 실패했습니다.");
                } 
            },
            error: function(error) {
            	console.log(error);
                alert("오류가 발생했습니다.");
    	    }
       });
    } 
}

// 답글 삭제
function replyDelete() {  
	
	var deleteReplyIdx = event.currentTarget.getAttribute("data-reply-delete-idx");
	var deleteParentIdx = event.currentTarget.getAttribute("data-reply-parent-idx");
	
    if (confirm("댓글을 삭제 하시겠습니까?")) {
    	
        $.ajax({
            type: "DELETE",
            url: "<c:url value='/comment'/>/" + deleteReplyIdx,
            data: {'commentIdx' : deleteReplyIdx},
            contentType: false,
            success: function(data, textStatus, xhr) {
            	
                if (xhr.status == 204) {
                	$("#replyList-" + deleteReplyIdx).remove();
                	
                	var replyCount = document.getElementById("reply-count-"+deleteParentIdx).textContent;
                	replyCount--;
					document.getElementById("reply-count-"+deleteParentIdx).textContent = replyCount;
                } else {
                	alert("댓글 삭제에 실패했습니다.");
                } 
            },
            error: function(error) {
            	console.log(error);
                alert("오류가 발생했습니다.");
    	    }
       });
    } 
}

// (숨겨진 답글 + 답글 작성 칸) 출력하는 버튼
function replyShowButton() {  
	
	var replyShow = event.currentTarget.getAttribute("data-comment-replyShow-idx");
	
	var replyInput = document.getElementById("reply-button-"+replyShow);
	replyInput.style.display = replyInput.style.display === "block" ? "none" : "block";
	
}

// 수정을 위한 textarea + 등록 버튼 출력
function commentModifyButton() {  
	
	var commentModify = event.currentTarget.getAttribute("data-comment-modifyButton-idx");
	
	var commentInput = document.getElementById("comment-textarea-"+commentModify);
	var comment = document.getElementById("comment-modify-"+commentModify);
	
	commentInput.style.display = "block";
	comment.style.display = "none";
	
}

// 수정 취소 버튼
function commentModifyCancel() { 
	
	var commentModify = event.currentTarget.getAttribute("data-comment-modifyCancel-idx");
	
	// 취소했을때 원래의 데이터로 돌려놓기
	var textarea = document.getElementById("comment-modify-content-" + commentModify);
	textarea.value = $("#comment-content-"+commentModify).text();
	
	var commentInput = document.getElementById("comment-textarea-"+commentModify);
	var comment = document.getElementById("comment-modify-"+commentModify);
	
	commentInput.style.display = "none";
	comment.style.display = "block";
	
}
</script>

<script>		
// 게시글 내용 수정시 summernote 이미지 업로드 기능
$('#summernote').summernote({
      
	  // 에디터 크기 설정
	  height: 700,
	  // 에디터 한글 설정
	  lang: 'ko-KR',
	  // 에디터에 커서 이동 (input창의 autofocus라고 생각하시면 됩니다.)
	  toolbar: [
		    // 글자 크기 설정
		    ['fontsize', ['fontsize']],
		    // 글자 [굵게, 기울임, 밑줄, 취소 선, 지우기]
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    // 글자색 설정
		    ['color', ['color']],
		    // 표 만들기
		    ['table', ['table']],
		    // 서식 [글머리 기호, 번호매기기, 문단정렬]
		    ['para', ['ul', 'ol', 'paragraph']],
		    // 줄간격 설정
		    ['height', ['height']],
		    // 이미지 첨부
		    ['insert',['picture']]
		  ],
		  // 추가한 글꼴
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
		 // 추가한 폰트사이즈
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72','96'],
		// focus는 작성 페이지 접속시 에디터에 커서를 위치하도록 하려면 설정해주세요.
		focus : true,
		// callbacks은 이미지 업로드 처리입니다.
		callbacks : {                                                    
			onImageUpload : function(files, editor, welEditable) {       
		        // 다중 이미지 처리를 위해 for문을 사용했습니다.
				for (var i = 0; i < files.length; i++) {
					imageUploader(files[i], this);
				}
			}
		}
		
  });
  
function imageUploader(file, el) {
	var formData = new FormData();
	formData.append('file', file);
	
	$.ajax({                                                              
		data : formData,
		type : "POST",
		url : '/post/image-upload',
		contentType : false,
		processData : false,
		enctype : 'multipart/form-data',                                  
		success : function(data) {   
			$(el).summernote('insertImage', "${pageContext.request.contextPath}/assets/images/upload/"+data, function($image) {
				$image.css('width', "100%");
			});
			console.log(data);
		}
	});
}

// 게시글 수정시 네이버 검색 기능
$("#postLocModify, #searchImg").on("input keypress click", function(event) {
	if(event.keyCode == 13) {
		event.preventDefault();
	}
	
	$("#resultContainer").empty();
	
	var text = $("#postLocModify").val();
	
	if (text.trim() !== "") {
	    $.ajax({
	      url: "<c:url value='/naver/search'/>",
	      type: "GET",
	      data: {"text": text},
	      dataType: "json",
	      success: function(result) {
	    	  
	    	  if (result && result.items.length > 0) {
	              
	              for (var i = 0; i < 5; i++) {
	                  var item = result.items[i];
	                  $("#resultContainer").append("<p role='button' data-title='" + item.title + "' data-address='" + item.address + "'>" + item.title + "<br>" + item.address + "</p>");
	              }
	              
	              $("#resultContainer p").on("click", function() {
                      var title = $(this).data("title");
                      var address = $(this).data("address");
                      
    				  $("#postLocModify").val(title.split("<b>").join("").split("</b>").join(""));
    				  $("#postAddressModify").val(address);
    				  $("#resultContainer").empty();
                  });
	          } else {
	        	  $("#resultContainer").empty();
	              console.log("결과없음.");
	          }
	      }, error: function(error) {
	    	  $("#resultContainer").empty();
	    	  console.log("Error:" + error.responseText);
	      }
	   });
	    
	} else {
		$("#resultContainer").empty();
		return;
	}
});


function clearInput() {
    var searchInputTitle = document.getElementById('postLocModify');
    var searchInputAdress = document.getElementById('postAddressModify');

    searchInputTitle.value = '';
    searchInputAdress.value = '';
}
</script>
</body>
</html>