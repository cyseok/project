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
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
	<!-- include summernote css/js -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
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
        	  <span class="" id="comment-count">댓글 수 : 0</span>
        	</div>	
        	
		 	<div class="comment-input">
		 		<textarea name="commentContent" id="commentContent" rows="3" placeholder="댓글을 입력해주세요."></textarea>
		 		<button type="button" id="commentAdd" class="btn btn-primary">댓글 등록</button>
		 	</div>
  
			<div class="post-comment" style="margin-top: 50px;">
			
				<div class="col-12 mb-4" data-aos="fade-up" data-aos-delay="100">
					<div class="media-entry">
							<input type="hidden" value="">
							<img src="${pageContext.request.contextPath}/assets/images/login.png" class="comment-image">
							<span class="comment-nickname">닉네임이 들어감</span>
							<span class="comment-date">댓글 날짜</span>
							<p class="comment-content" id="comment-content" style="font-size: 25px;">댓글 내용이 들어감</p>
								<button type="button" id="comment-modify-button" class="btn btn-danger">수정</button>
								<button type="button" id="comment-delete-button" class="btn btn-danger" onclick="commentDelete();">삭제</button>
								<button type="button" id="comment-button" class="btn btn-success">답글</button>
							<hr class="position-line">
						
					</div>
				</div>
				
			</div>	
	    </div>
	    <!-- 댓글 -->
        </section>
      
      </div>
    </div>
  </div>
  
  <form id="postModifyForm" style="display: none;">
	  <div class="post-form">
	    <label for="postTitle" class="post-label">제목</label>
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
	      <label for="postLoc" class="post-label">지역</label>
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
	// commentList();
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
        url: "<c:url value='/comment-list'/>",
        data: {"postIdx": postIdx},
        dataType: "json",
        success: function(result) {
        	console.log(result);
        	
        	if (result.content.length === 0) { 
        		
            } else {
				// 댓글 목록 출력            	
	            for (var i = 0; i < result.content.length; i++) {
	                var postList = result.content[i];
	                var postElement2 = 
	                	$("<div class='col-12 col-sm-6 col-md-4 col-lg-3 mb-4 clickable-post' data-aos='fade-up' data-aos-delay='100'>" +
	                		"<a href='${pageContext.request.contextPath}/post/" + postList.postIdx + "'>" +
	                          "<div class='media-entry'>" +
	                            "<div class='bg-white m-body'>" +
	                              "<span class='date'>" + postList.postRegdate + "</span>" +
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
        }, error: function(error) {
            console.log("comment-Error:", error);
        }
    });
}

// 댓글 수정

// 댓글 삭제
function commentDelete() {   

    if (confirm("자료를 정말로 삭제 하시겠습니까?")) {
    	
        $.ajax({
            type: "DELETE",
            url: "<c:url value='/comment'/>/" + commentIdx,
            data: {'commentIdx' : commentIdx},
            contentType: false,
            success: function(data, textStatus, xhr) {
            	
                if (xhr.status == 204) {
	                // 댓글 목록 출력 함수
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

// 댓글 등록
$("#commentAdd").click(function(e) {
    e.preventDefault();
    
    var commentInput = document.getElementById('commentContent');
    commentInput.value = '';
    
    var formData = new FormData();
    formData.append("postIdx", postIdx);
    formData.append("userinfoId", $("#userinfoId").val());
    formData.append("parentIdx", 0);
    formData.append("commentContent", $("#commentContent").val());
    
    $.ajax({
        type: "POST",
        url: "<c:url value='/comment'/>",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "text",
        success: function (data, textStatus, xhr) {
            if (xhr.status == 200) {
            	commentList();
            }
        }, error: function(error) {
            console.log("comment-Error:", error);
        }
    });
});
</script>

<script>		
// 글 내용 수정할 때 이미지 업로드 기능
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