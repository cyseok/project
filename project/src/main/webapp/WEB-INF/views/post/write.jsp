<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
	<title>게시글 작성</title>
<style>
</style>
</head>
  
<header>
  <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>

<body>
<div class="section">
  <div class="container">
  <div class="row">
  
	<form id="post-form" enctype="multipart/form-data">
	
	<input type="hidden" name="userinfoId" id="userinfoId" value="${sessionScope.userinfoId}">
	 
	  <div class="post-form">
	    <label for="postTitle" class="post-label">제목</label>
	    <textarea name="postTitle" id="postTitle" class="form-control" rows="2" placeholder="제목을 입력해주세요."></textarea>
	  </div>
	  <hr style="width: 64%; margin-left: auto; margin-right: auto;">
	  <div class="post-form">
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postDayType" id="dayType" value="1" style="width: 20%">
		  <br>
		  <span>평일</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postDayType" id="dayType" value="2" style="width: 20%">
		  <br>
		  <span>주말, 공휴일</span>				
	    </label>
	  </div>
	  <hr style="width: 64%; margin-left: auto; margin-right: auto;">
	  <div class="post-form">
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="1" style="width: 20%">
		  <br>
		  <span>사람없음</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="2" style="width: 20%">
		  <br>
		  <span>웨이팅없음</span>				
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="3" style="width: 20%">
		  <br>
		  <span>웨이팅 조금</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="4" style="width: 20%">
		  <br>
		  <span>웨이팅 김</span>				
	    </label>
	  </div>
	  
	  <div class="post-form">
	      <label for="postLoc" class="post-label">지역</label>
	      <div class="post-search">
	        <input type="hidden" name="postAddress" id="postAddress">
	        <input name="postLoc" id="postLoc" class="form-control" placeholder="내용을 입력해주세요.">
	        <img id="searchImg" role="button" src="${pageContext.request.contextPath}/assets/images/search.png">
	        <img id="xImg" role="button" src="${pageContext.request.contextPath}/assets/images/xmark.png" onclick="clearInput()">
	      </div>
	      <div id="resultContainer"></div>
	  </div>
	  
	  <div class="post-form">
	    <textarea name="postContent" id="editor">
	    </textarea>
	  </div>  
	  
	    <div class="post-form d-flex justify-content-end">
	      <button type="submit" class="btn btn-primary" >등 록</button>
	      <button type="button" id="cancelBtn" class="btn btn-secondary ml-2" onclick="location.href='${pageContext.request.contextPath}/notice'">취 소</button>
	    </div>
	  <sec:csrfInput/>
	</form>
  </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

<script>
//CSRF 토큰 관련 정보를 자바스크립트 변수에 저장
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

// Ajax 기능을 사용하여 요청하는 모든 웹 프로그램에게 CSRF 토큰 전달 가능
// ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

// 등록
$("form").submit(function(e) {
    e.preventDefault(); 
    
    $('#loading').show();
    var editorContent = window.editor.getData();

    var formData = new FormData();
    formData.append("postTitle", $("#postTitle").val());
    formData.append("userinfoId", $("#userinfoId").val());
    formData.append("postDayType", $("input[name='postDayType']:checked").val());
    formData.append("postTag", $("input[name='postTag']:checked").val());
    formData.append("postLoc", $("#postLoc").val());
    formData.append("postAddress", $("#postAddress").val());
    formData.append("postContent", editorContent);

    $.ajax({
        type: "POST",
        url: "<c:url value='/post'/>",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "text",
        success: function (data, textStatus, xhr) {
        	console.log(data);
        	console.log(xhr.status);
            if (xhr.status == 201) {
            	$('#loading').hide();
                alert("게시글을 등록하였습니다.");
                window.location.href = "${pageContext.request.contextPath}/post"
            } else {
                alert("글 등록을 실패하였습니다.");
            }
        }, error: function(error) {
        	$('#loading').hide();
            console.log("post-Error:", error);
        }
    });
});
</script>

<script>
$(document.body).on("click", function(event) {
    if (!$(event.target).closest("#resultContainer").length) {
        $("#resultContainer").empty();
    }
});

$("#postLoc, #searchImg").on("input keypress click", function(event) {
	
	if(event.keyCode == 13) {
		event.preventDefault();
	}
	
	$("#resultContainer").empty();
	
	var text = $("#postLoc").val();
	
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
                      
    				  $("#postLoc").val(title.split("<b>").join("").split("</b>").join(""));
    				  $("#postAddress").val(address);
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
    var searchInputTitle = document.getElementById('postLoc');
    var searchInputAdress = document.getElementById('postAddress');

    searchInputTitle.value = '';
    searchInputAdress.value = '';
}
</script>

<script>		
	ClassicEditor
	.create(document.querySelector('#editor'), {
		ckfinder: {
			uploadUrl : "/post/imgUpload"
			,uploadMethod : "json"
		},
		image: {
	        toolbar: [  'imageTextAlternative',
                'toggleImageCaption',
                'imageStyle:inline',
                'imageStyle:block',
                'imageStyle:side' ],
                fileExtensions: ['png', 'jpg', 'gif'],
                // 업로드할 수 있는 파일의 최대 크기
                fileSizeLimit: 2097152
	    }
	})
	.then(editor => {
		console.log('Editor was initialized');
		window.editor = editor;
	})
	.catch(error => {
		console.error(error);
	});
</script>
</body>
</html>