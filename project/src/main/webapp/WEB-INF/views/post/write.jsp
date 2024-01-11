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
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
	<!-- include summernote css/js -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
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
	  <hr style="width: 70%; margin-left: auto; margin-right: auto;">
	  <div class="post-form">
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postDayType" id="dayType" value="1" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">평일</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postDayType" id="dayType" value="2" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">주말, 공휴일</span>				
	    </label>
	  </div>
	  <hr style="width: 70%; margin-left: auto; margin-right: auto;">
	  <div class="post-form">
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="1" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">사람없음</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="2" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">웨이팅없음</span>				
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="3" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">웨이팅 조금</span>
	    </label>
	    <label class="radio-inline" style="width: 20%">
		  <input type="radio" name="postTag" id="postTag" value="4" style="width: 20%">
		  <br>
		  <br>
		  <br>
		  <span class="radio-font">웨이팅 김</span>				
	    </label>
	  </div>
	  
	  <div class="post-form">
	      <label for="postLoc" class="post-label">지역</label>
	      <div class="post-search">
	        <input type="hidden" name="postAddress" id="postAddress">
	        <input name="postLoc" id="postLoc"  placeholder="내용을 입력해주세요.">
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
	      <button type="submit" class="btn btn-primary">등 록</button>
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

// Ajax 기능을 사용하여 요청하는 모든 웹 프로그램에게 CSRF 토큰 전달 가능
// ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음

// 등록
$("form").submit(function(e) {
    e.preventDefault(); 
   
    if ($("#postTitle").val() === "") {
        alert("제목을 작성해주세요 :) "); 
        return false;
      }
    
    if (!$("input[name='postDayType']:checked").val()) {
        alert("요일 구분을 선택해주세요."); 
        return false; 
      }
    
    if (!$("input[name='postTag']:checked").val()) {
        alert("사람이 얼마나 많았는지 선택해주세요!!"); 
        return false; 
      }
    
    if ($("#postLoc").val() === "") {
        alert("지역을 검색해주세요 :) "); 
        return false;
      }
    
    $('#loading').show();
    
    var editorContent = $('#summernote').summernote('code');
    
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
	              
	              for (var i = 0; i < result.items.length; i++) {
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
</script>

</body>
</html>