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
</style>
<header>
	<nav class="site-nav mt-3">
		<div class="container">

			<div class="site-navigation">
				<div class="row">
					<div class="col-6 col-lg-3">
						<a href="${pageContext.request.contextPath}/post" class="logo m-0 float-start">Waiting Check</a>
					</div>
					<div class="col-lg-6 d-none d-lg-inline-block text-center nav-center-wrap">
						<ul class="js-clone-nav  text-center site-menu p-0 m-0">
							<li><a href="index.html">Home</a></li>
							<li><a href="about.html">About us</a></li>
							<li><a href="services.html">Services</a></li>
							<li class="active"><a href="">xxxxx</a></li>

						</ul>
					</div>
					
				<sec:authorize access="hasRole('ROLE_USER')">
				<div class="col-6 col-lg-3 text-lg-end">
					<div class="col-lg-6 d-none d-lg-inline-block text-center nav-center-wrap">
						<ul class="js-clone-nav  text-center site-menu p-0 m-0">
							<li class="has-children">
								<img src="${pageContext.request.contextPath}/assets/images/login.png" id="login-image">
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
				
				<sec:authorize access="isAnonymous()">
				  <div class="col-6 col-lg-3 text-lg-end">
					 <ul class="js-clone-nav d-none d-lg-inline-block text-end site-menu ">
						<li class="cta-button"><a href="${pageContext.request.contextPath}/user/login">로그인</a></li>
					 </ul>
				  </div>
				</sec:authorize>
					
					
				</div>
			</div>
			
		</div>
	</nav>
	<script>
      function logout() {
        alert("로그아웃하시겠습니까?");
        if (confirm("확인")) {
          // 로그아웃 처리
        }
      }
    </script>
</header>
   </body>
</html>
   