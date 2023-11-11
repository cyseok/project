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
	.col-lg-6.d-none.d-lg-inline-block.text-center.nav-center-wrap {
	  margin-top: -20px; /* Adjust the value as needed */
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
        width: 58px; 
        height: 57px;
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
      position: relative;
      top: -13px; 
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
					<div class="col-lg-6 d-none d-lg-inline-block text-center nav-center-wrap">
						<ul class="js-clone-nav  text-center site-menu p-0 m-0">
							<li><a href="" style="color: gray; font-size: 19px;">Home</a></li>
							<li><a href="" style="color: gray; font-size: 19px;">About us</a></li>
							<li><a href="" style="color: gray; font-size: 19px;">Services</a></li>
							<li class="active"><a href="" style="color: gray; font-size: 19px;">xxxxx</a></li>
						</ul>
					</div>
					
				<sec:authorize access="hasRole('ROLE_USER')">
				<div class="col-6 col-lg-3 text-lg-end">
					<div class="col-lg-6 d-none d-lg-inline-block text-center nav-center-wrap">
						<ul class="js-clone-nav  text-center site-menu p-0 m-0">
							<li class="has-children">
								<img src="${pageContext.request.contextPath}/assets/images/login.png" id="login-image" role="button">
								<ul class="dropdown">
									<li><a href="" style="font-size: 1.2em; width: 200px;">내정보</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;">내 작성글</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;">내 관심글</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;" onclick="logout()">로그아웃 </a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				</sec:authorize>
				
				<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div class="col-6 col-lg-3 text-lg-end">
					<div class="col-lg-6 d-none d-lg-inline-block text-center nav-center-wrap">
						<ul class="js-clone-nav  text-center site-menu p-0 m-0">
							<li class="has-children">
								<img src="${pageContext.request.contextPath}/assets/images/login.png" id="login-image" role="button">
								<ul class="dropdown">
									<li><a href="" style="font-size: 1.2em; width: 200px;">내정보</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;">관리자 페이지</a></li>
									<li><a href="" style="font-size: 1.2em; width: 200px;" onclick="logout()">로그아웃 </a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				</sec:authorize>
				
				<sec:authorize access="isAnonymous()">
				  <div class="col-6 col-lg-3 text-lg-end">
					 <ul class="js-clone-nav d-none d-lg-inline-block text-end site-menu">
						<li class="cta-button"><a role="button" id="login-button">로그인</a></li>
						
					 </ul>
				  </div>
				</sec:authorize>
					
					
				</div>
			</div>
			
		</div>
	</nav>
				<%-- <form id="logoutForm" action="<c:url value='/logout'/>" method="post">
				  <sec:csrfInput />
				</form> --%>
	
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
              <input type="text" class="form-control" name="id" id="idInput" placeholder="아이디를 입력하세요">
              <c:remove var="idInput"/>
            </div>
            <div class="mb-3">
              <label for="pwInput" class="form-label">비밀번호</label>
              <input type="password" class="form-control" name="pw" id="pwInput" placeholder="비밀번호를 입력하세요">
            </div>
            
            <div class="d-flex justify-content-center">
              <button type="submit" class="btn btn-primary" style="width: 350px;">로그인</button>
              <script>
				$(function() {
			        $("#loginForm").submit(function(e) {
			          e.preventDefault();
				
                   /*  var formData = new FormData();
                    formData.append("id", $("#idInput").val());
                    formData.append("pw", $("#pwInput").val()); */
                    
                    var id = $("#idInput").val();
                    var pw = $("#pwInput").val();
                    
				    $.ajax({
				        type: "POST",
				        url: "<c:url value='/user/login'/>",
				        data: {"id":id, "pw":pw},
				        dataType: "text",
				        success: function (result) {
				            if (result == "success") {
				            	alert(result.success);
				            	location.reload();
				
				            } else {
				                alert("아이디와 비밀번호를 확인해주세요.");
				            }
				        },
				          error: function(error) {
				            alert("에러가 발생했습니다.");
			            }
				     });
				  });
			   });
			</script>
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
  
	
	<script>
      function logout() {
        if (confirm("로그아웃 하시겠습니까?")) {
        	
        	$.ajax({

        	    

        		type: 'POST',

        		url: "<c:url value='/logout'/>",

        	    success : function(data) {

        	    	location.reload();

        	

        	    },error : function(data){

        	    	alert("실패");

        	    }

        	});
        }
      }
      
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
      
      </script>
     
	
	

</header>
</div>
</html>
   