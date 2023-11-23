<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!doctype html>
<html lang="UTF-8">

<head>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
	<title>웨이팅 확인!!</title>
	<style>
.content-section {
    padding-top: 100px; /* 원하는 높이만큼 헤더 아래로 내립니다. */
}
	</style>
</head>

<header>
  <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>

<body>
  <div class="content-section">
	<div class="hero overlay ">
		<div class="img-bg rellax" >
			<img src="${pageContext.request.contextPath}/assets/images/hero_2.jpg" alt="Image" class="img-fluid" >
		</div>
		
		<div class="container">
			<div class="row align-items-center justify-content-start">
				<div class="col-lg-6 mx-auto text-center">

					<h1 class="heading" data-aos="fade-up">제목~~~</h1>
					<p class="mb-4" data-aos="fade-up">설명이 들어갈 공간입니다.</p>
				</div>
			</div>
		</div>
	</div>
  </div>

	<div class="section">
		<div class="container">
			<div class="row align-items-stretch">
				<div class="col-6 col-sm-6 col-md-6 col-lg-3 mb-4" data-aos="fade-up" data-aos-delay="100">
					<div class="media-entry">
						<div class="bg-white m-body">
							<span class="date">날짜 들어감</span>
							<span class="float-right">지역이름 들어감</span>
							<span class="float-left">공휴일,휴일</span>
							<p class="styled-text" id="">제목이 들어갈 공간입니다ㅁㄴㅇㅁㄴㄹㅁㄴㄹㅁ나ㅣ루먼우먼오ㅓㅁ노어모아몽마노어ㅏ모아ㅗㅁㄴ왐노아모오ㅓㅏㅁ나어ㅗㅁ너ㅏ옴너ㅏ오머나오마너온머ㅏ오마ㅗㄴ암놩모나온망마ㅗㄴ암노어ㅏㅁ노어ㅏ몬.</p>
							<hr class="position-line">
							<img src="${pageContext.request.contextPath}/assets/images/login.png" class="login-image">
							<span class="bottom-left">닉네임</span>
							<span class="bottom-right">조회수 00회</span>
						</div>
					</div>
				</div>
			</div>	
		</div>		
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
    <button class="top-button">⬆︎</button>
		<!-- Preloader -->
		<!-- <div id="overlayer"></div>
		<div class="loader">
			<div class="spinner-border text-primary" role="status">
				<span class="visually-hidden">Loading...</span>
			</div>
		</div> -->
<script>
$(".top-button").click(function() {
	  window.scrollTo(0, 0);
});
</script>

	
</body>
</html>
