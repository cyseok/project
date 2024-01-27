<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div id="header-wrapper">
<header>
	<nav class="site-nav mt-3">
		<div class="container">
			<div class="site-navigation">
				<div class="row">
				    <div class="col-6 col-lg-3">
						<a href="${pageContext.request.contextPath}/" class="logo m-0 float-start" style="color: gray;">Waiting Check</a>
					</div>
					
					<sec:authorize access="isAnonymous()">
					<div class="col-lg-6 d-none d-lg-inline-block text-center nav-center-wrap ">
						<ul class="js-clone-nav  text-center site-menu p-0 m-0">
							<li><a href="${pageContext.request.contextPath}/" style="color: gray; font-size: 19px;">HOME</a></li>
							<li><a href="${pageContext.request.contextPath}/notice" style="color: gray; font-size: 19px;">공지사항</a></li>
							<li class="active"><a onclick="loginMessage()" role="button" style="color: gray; font-size: 19px;">글작성</a></li>
						</ul>
					</div>
					</sec:authorize>
					
					<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_SOCIAL', 'ROLE_MASTER')">
					<div class="col-lg-6 d-none d-lg-inline-block text-center nav-center-wrap ">
						<ul class="js-clone-nav  text-center site-menu p-0 m-0">
							<li><a href="${pageContext.request.contextPath}/" style="color: gray; font-size: 19px;">HOME</a></li>
							<li><a href="${pageContext.request.contextPath}/notice" style="color: gray; font-size: 19px;">공지사항</a></li>
							<li class="active"><a href="${pageContext.request.contextPath}/post/write" style="color: gray; font-size: 19px;">글작성</a></li>
						</ul>
					</div>
					</sec:authorize>
					
					<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_SOCIAL', 'ROLE_ADMIN')">
					<div class="col-6 col-lg-3 text-lg-end">
						<ul class="js-clone-nav d-block text-end site-menu">
							<li class="has-children">
								<img src="${pageContext.request.contextPath}/assets/images/login.png" id="login-image" role="button">
								<ul class="dropdown">
								    <li><a href="${pageContext.request.contextPath}/user/my-page" style="font-size: 1.2em; width: 200px;">닉네임 변경</a></li>
									<li><a href="${pageContext.request.contextPath}/post/my-write" style="font-size: 1.2em; width: 200px;">내 작성글</a></li>
									<li><a href="${pageContext.request.contextPath}/post/my-likes" style="font-size: 1.2em; width: 200px;">내 관심글</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;" id="logoutButton">로그아웃 </a></li>
								</ul>
							</li>
						</ul>
					</div>
					</sec:authorize>
					
					<sec:authorize access="hasRole('ROLE_MASTER')">
					<div class="col-6 col-lg-3 text-lg-end">
						<ul class="js-clone-nav d-block text-end site-menu">
							<li class="has-children">
								<img src="${pageContext.request.contextPath}/assets/images/login.png" id="login-image" role="button">
								<ul class="dropdown">
								    <li><a href="${pageContext.request.contextPath}/user/my-page" style="font-size: 1.2em; width: 200px;">닉네임 변경</a></li>
								    <li><a href="${pageContext.request.contextPath}/post/my-write" style="font-size: 1.2em; width: 200px;">내 작성글</a></li>
									<li><a href="${pageContext.request.contextPath}/post/my-likes" style="font-size: 1.2em; width: 200px;">내 관심글</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;" id="logoutButton">로그아웃 </a></li>
								</ul>
							</li>
						</ul>
					</div>
					</sec:authorize>
					
					<sec:authorize access="isAnonymous()">
					  <div class="col-6 col-lg-3 text-lg-end">
						 <ul class="js-clone-nav d-block text-end site-menu">
							<li class="cta-button"><a role="button" id="login-button">로그인</a></li>
						 </ul>
					  </div>
					</sec:authorize>
					
				</div>
			</div>
		</div>
    <hr>	
	</nav>
	
	<form id="logoutForm">
	  <sec:csrfInput />
	</form>
	
  <div class="modal fade" id="login-modal" tabindex="-1" aria-labelledby="login-modal-label" aria-hidden="true">
    <div class="modal-dialog" style="max-height: 600px;">
      <div class="modal-content" style="height:450px; width: 400px;">
        <div class="modal-header">
          <h5 class="modal-title" id="login-modal-label">로그인</h5>
          <button type="button" id="close-button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" >
          <form id="loginForm">
            <div class="mb-3">
              <label for="idInput" id="idLabel" class="form-label">아이디</label>
              <input type="text" class="form-control" name="id" id="idInput" placeholder="아이디를 입력해주세요.">
              <c:remove var="idInput"/>
            </div>
            <div class="mb-3">
              <label for="pwInput" id="pwLabel" class="form-label">비밀번호</label>
              <input type="password" class="form-control" name="pw" id="pwInput" placeholder="비밀번호를 입력해주세요.">
            </div>
            
            <div class="d-flex justify-content-center">
              <button type="submit" id="loginButton" class="btn btn-primary" style="width: 350px;" disabled>로그인</button>
            </div>
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
          </form>
          <div style="margin-top: 20px;">
	        <a href="${pageContext.request.contextPath}/user/find" class="id-button">아이디찾기</a> 
	        <a href="${pageContext.request.contextPath}/user/find" class="pw-button"></a> 
	        <a href="${pageContext.request.contextPath}/user/join" class="join-button">회원가입</a>
	      </div>
        </div>
        <div class="social-login-buttons">
			<img class="naver-login-img" alt="네이버로그인" src="<c:url value="/assets/images/naver_login.png"/>" 
				  onclick="location.href='<c:url value="/naver/login"/>';" role="button">
			<img class="kakao-login-img" alt="카카오로그인" src="<c:url value="/assets/images/kakao_login.png"/>"
			      onclick="location.href='<c:url value="/kakao/login"/>';" role="button">
			<img class="google-login-img" alt="구글로그인" src="<c:url value="/assets/images/google_login.png"/>"
			      onclick="location.href='<c:url value="/google/login"/>';" role="button">
		</div>
      </div>
    </div>
  </div>
 
  
  <div id="loading" style="display: none;">
	  <div class="spinner-border text-primary" role="status">
       <span class="visually-hidden">Loading...</span>
     </div>
  </div>
  
<script>
//CSRF 토큰 관련 정보를 자바스크립트 변수에 저장
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

// Ajax 기능을 사용하여 요청하는 모든 웹 프로그램에게 CSRF 토큰 전달 가능
// ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

var idLengthInput = document.getElementById("idInput");
var pwLengthInput = document.getElementById("pwInput");
var loginButton = document.getElementById("loginButton");

function checkPasswordLength() {
	  
  if (pwLengthInput.value.length >= 8 && idLengthInput.value.length >= 5) {
       loginButton.disabled = false;
    } else {
       loginButton.disabled = true;
    }
}

pwLengthInput.addEventListener("input", checkPasswordLength);

function disableButton() {

    loginButton.disabled = true;

    setTimeout(function () {
      loginButton.disabled = false;
    }, 3000);
  }
	

   $("#loginForm").submit(function(event) {
   	 event.preventDefault();
   	 disableButton();
   	 
   	 $('#loading').show();
            
     var formData = JSON.stringify({
         id: $("#idInput").val(),
         pw: $("#pwInput").val()
     });
     
	    $.ajax({
	    	type: "POST",
	        url: "<c:url value='/user/login'/>",
	        dataType: "text",
	        data: formData,
	        contentType: "application/json",
	        success: function (response) {
	            if (response === "ok") {
	            	$('#loading').hide();
	            	window.location.reload();
	            } else {
	                alert("아이디와 비밀번호를 확인해주세요.");
	                $('#loading').hide();
	            }
	        }, error: function(error) {
	            $('#loading').hide();
	            alert(error.responseText);
	            console.log("Error:", error);
	           }
	     });
  });
</script>
	
<script>
   $(document).ready(function() {
 	    
 	    $("#logoutButton").click(function(event) {
 	        event.preventDefault(); 
 	        if (confirm("로그아웃 하시겠습니까?")) {
 	        	
	  	        $.ajax({
	  	            type: 'POST',
	  	            url: "<c:url value='/logout'/>",
	  	            data: $("#logoutForm").serialize(), 
	  	            success: function(data) {
	  	            	window.location.href = "${pageContext.request.contextPath}/";
	  	            },
	  	            error: function(data) {
	  	                alert("로그아웃 실패");
	  	            }
	  	        });
 	        }
 	    });
 	});
   
	// 로그인 버튼을 클릭하면 모달창을 열기
	$("#login-button").click(function() {
    	$("#login-modal").modal("show");
   });
	
	$("#close-button").click(function(){
	    $("#idInput").val('');
	    $("#pwInput").val('');
	  });
	
	$("#idInput").keypress(function(){
	     if(event.keyCode == 13) { 
		 	  $("#pwInput").focus();
		   }
	});
	    
   $("#pwInput").keypress(function(){
 		if(event.keyCode == 13) {
 			$("#loginForm").submit();
 		}
   });
   
   function loginMessage() {
       alert("로그인 후 이용해주세요!!");
       event.preventDefault();
   }
   function errorMessage() {
       alert("페이지를 만드는 중입니다..");
       event.preventDefault();
   }
</script>

</header>
</div>
</html>
   