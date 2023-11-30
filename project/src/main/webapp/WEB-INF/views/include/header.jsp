<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
	.logo.m-0.float-start {
	  font-size: 32px;
	}
	
	#login-image {
	  width: 70px;
	  height: 70px;
	}
	.modal-dialog {  
      top: 200px; 
    } 
    .naver-login-img {
        width: 58px;
	    height: 57px;
	    position: absolute;
	    top: 83%; 
        left: 25%;
    }
    .google-login-img {
        width: 57px; 
        height: 56px;
        position: absolute;
	    top: 83%; 
        left: 59%;
    }
    .kakao-login-img {
        width: 64px;
        height: 57px;
        position: absolute;
	    top: 83%; 
        left: 41.3%;
    }
    .id-button {
      position: absolute;
	  text-decoration: underline;
	  text-align: center;
	  font-size: 14px;
	  left: 25%;
	  
	}
	.pw-button {
	  position: absolute;
	  text-decoration: underline;
	  left: 42.5%;
	  text-align: center;
	  font-size: 14px;
	}
	.join-button {
	  position: absolute;
	  text-decoration: underline;
	  left: 63%;
	  text-align: center;
	  font-size: 14px;
	}
	.col-6.col-lg-3.text-lg-end {
      margin-top: -5px;
   }
   /* 회원가입 전체 폼 컨테이너 */
	.join_section {
	  width: 100%;
	  margin: 0 auto;
	  padding: 0 100px;
	  background-color: #fff;
	  border: 1px solid #ccc;
	  position: relative;
	  top: 130px;
	}
	
	/* 폼 헤더 */
	.title_f {
	  font-size: 26px;
	  font-weight: bold;
	  text-align: center;
	}
	
	/* 폼 그룹 */
	.form-group {
	  margin-bottom: 20px;
	}
	
	/* 라벨 */
	.sp {
	  font-size: 14px;
	  margin-bottom: 10px;
	}
	
	/* 입력 필드 */
	input {
	  width: 100%;
	  height: 45px;
	  border: 1px solid #ccc;
	  padding: 10px;
	}
	
	/* 비밀번호 확인 필드 */
	input[name='confirmPw'] {
	  margin-top: 10px;
	}
	
	/* 에러 메시지 */
	.with-errors {
	  color: red;
	}
	
	/* 회원구분 라디오 버튼 */
	.radio-inline {
	  margin-right: 10px;
	}
	
	/* 가입하기 버튼 */
	.join_button {
	  width: 100px;
	  height: 40px;
	  background-color: #000;
	  color: #fff;
	  font-size: 14px;
	  border: none;
	  cursor: pointer;
	}
	
	/* container의 margin-top 제거 */
	.container {
	  margin-top: 0;
	}
	
	/* 폼 테두리 추가 */
	.join_section {
	  border-radius: 5px;
	  width: 700px;
	  height: 2100px;
	}
	/* 폼 테두리 추가 */
	.sp {
	  font-size: 17px;
	  font-weight: bold;
	}
	
	/* 폼 헤더의 위치 조정 */
	.join_section .title_f {
	  position: relative;
	  top: -5px;
	}
	
	/* 폼과 푸터 사이의 여백 추가 */
	.join_section,
	.footer {
	  margin-bottom: 200px;
	}
	/* 체크박스 크기 조정 */
	.radio-inline {
	  width: auto;
	}
	.join_form_section {
	  margin-top: 50px;
	}
	#check-email {
	  color: red;
	  font-size: 30px;
	  float: right;
	}
	#email-confirm-text {
	  position: relative;
	  width: calc(100% - 50px);
	}
	.top-button {
	  position: fixed;
	  bottom: 50px;
	  right: 50px;
	  width: 60px;
	  height: 60px;
	  font-size: 30px;
	  background-color: #f7f7f7;
	  color: #666;
	  border-radius: 10%;
	  border-color: black;
	  cursor: pointer;
	}
	/* 로딩이미지 */
	#loading {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      z-index: 9999;
      width: 100%;
      height: 100%;
      background: rgba(255, 255, 255, 0.8);
      display: flex;
      align-items: center;
      justify-content: center;
    }
	#loading {
      text-align: center;
    }

    .loader {
      display: inline-block;
    }	
</style>
<div id="header-wrapper">
<header>
	<nav class="site-nav mt-3">
		<div class="container">
			<div class="site-navigation">
				<div class="row">
				    <div class="col-6 col-lg-3">
						<a href="${pageContext.request.contextPath}/post" class="logo m-0 float-start" style="color: gray;">Waiting Check</a>
					</div>
					
					<sec:authorize access="isAnonymous()">
					<div class="col-lg-6 d-none d-lg-inline-block text-center nav-center-wrap ">
						<ul class="js-clone-nav  text-center site-menu p-0 m-0">
							<li><a href="${pageContext.request.contextPath}/notice" style="color: gray; font-size: 19px;">공지사항</a></li>
							<li><a href="" style="color: gray; font-size: 19px;">About us</a></li>
							<li><a href="" style="color: gray; font-size: 19px;">Services</a></li>
							<li class="active"><a onclick="loginMessage()" role="button" style="color: gray; font-size: 19px;">글작성</a></li>
						</ul>
					</div>
					</sec:authorize>
					
					<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_SOCIAL')">
					<div class="col-lg-6 d-none d-lg-inline-block text-center nav-center-wrap ">
						<ul class="js-clone-nav  text-center site-menu p-0 m-0">
							<li><a href="" style="color: gray; font-size: 19px;">Home</a></li>
							<li><a href="" style="color: gray; font-size: 19px;">About us</a></li>
							<li><a href="" style="color: gray; font-size: 19px;">Services</a></li>
							<li class="active"><a href="${pageContext.request.contextPath}/post/write" style="color: gray; font-size: 19px;">글작성</a></li>
						</ul>
					</div>
					</sec:authorize>
					
					<sec:authorize access="hasRole('ROLE_USER')">
					<div class="col-6 col-lg-3 text-lg-end">
						<ul class="js-clone-nav d-block text-end site-menu">
							<li class="has-children">
								<img src="${pageContext.request.contextPath}/assets/images/login.png" id="login-image" role="button">
								<ul class="dropdown">
									<li><a href="" style="font-size: 1.2em; width: 200px;">내정보</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;">내 작성글</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;">내 관심글</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;" id="logoutButton">로그아웃 </a></li>
								</ul>
							</li>
						</ul>
					</div>
					</sec:authorize>
					
					<sec:authorize access="hasRole('ROLE_ADMIN')">
					<div class="col-6 col-lg-3 text-lg-end">
						<ul class="js-clone-nav d-block text-end site-menu">
							<li class="has-children">
								<img src="${pageContext.request.contextPath}/assets/images/login.png" id="login-image" role="button">
								<ul class="dropdown">
									<li><a href="" style="font-size: 1.2em; width: 200px;">내정보</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;">내 작성글</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;">관리자 페이지</a></li>
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
									<li><a href="" style="font-size: 1.2em; width: 200px;">내정보</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;">관리자 페이지</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;" id="logoutButton">로그아웃 </a></li>
								</ul>
							</li>
						</ul>
					</div>
					</sec:authorize>
					
					<sec:authorize access="hasRole('ROLE_SOCIAL')">
					<div class="col-6 col-lg-3 text-lg-end">
						<ul class="js-clone-nav d-block text-end site-menu">
							<li class="has-children">
								<img src="${pageContext.request.contextPath}/assets/images/login.png" id="login-image" role="button">
								<ul class="dropdown">
									<li><a href="" style="font-size: 1.2em; width: 200px;">닉네임 설정하기</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;">내 작성글</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;">내 관심글</a></li>
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
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" >
          <form id="loginForm">
            <div class="mb-3">
              <label for="idInput" class="form-label">아이디</label>
              <input type="text" class="form-control" name="id" id="idInput" placeholder="아이디를 입력해주세요.">
              <c:remove var="idInput"/>
            </div>
            <div class="mb-3">
              <label for="pwInput" class="form-label">비밀번호</label>
              <input type="password" class="form-control" name="pw" id="pwInput" placeholder="비밀번호를 입력해주세요.">
            </div>
            
            <div class="d-flex justify-content-center">
              <button type="submit" id="loginButton" class="btn btn-primary" style="width: 350px;" disabled>로그인</button>
            </div>
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
          </form>
          <div style="margin-top: 20px;">
	        <a href="${pageContext.request.contextPath}/user/findId" class="id-button">아이디찾기</a> 
	        <a href="${pageContext.request.contextPath}/user/findPw" class="pw-button">비밀번호찾기</a> 
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
 
  
  <%-- 로딩 표시 이미지
  <div id="loading" style="display: none;">
    <img src="${pageContext.request.contextPath}/assets/images/loading.gif" alt="Loading..." />
  </div>
   --%>
  
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
             console.log("formData:", formData);
	    $.ajax({
	    	type: "POST",
	        url: "<c:url value='/user/login'/>",
	        dataType: "text",
	        data: formData,
	        contentType: "application/json",
	        success: function (response) {
	            if (response === "ok") {
	            	$('#loading').hide();
	            	location.reload();
	            } else {
	                alert("아이디와 비밀번호를 확인해주세요.");
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
  	                location.reload();
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
   }
</script>
     
	
	

</header>
</div>
</html>
   