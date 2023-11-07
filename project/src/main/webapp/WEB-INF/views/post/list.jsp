<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!doctype html>
<html lang="UTF-8">

<head>
	<style>
	  .bg-white.m-body {
	    border: 2px solid #d3d3d3; 
	    padding: 10px; 
	    width: 280px; 
	    height: 300px; 
	    border-radius: 35px;
	  }
	  .bg-white.m-body {
	  position: relative;
	}
	/* 날짜 */
	.bg-white.m-body > span.date {
	  position: absolute;
	  top: 10%;
	}
	/* 지역이름 */
	.bg-white.m-body > span.float-right {
	  position: absolute;
	  top: 10%;
	  right: 10%;
	  font-size: 15px;
	}
	/* 평일, 공휴일 */
	.bg-white.m-body > span.float-left {
	  position: absolute;
	  top: 17%;
	  right: 10%;
	  font-size: 14px;
	 
	}
	/* 제목 */
	.bg-white.m-body > p.styled-text {
	  position: absolute;
	  top: 31%;
	  width: 80%;
	  transform: translateX(5%);
	  left: 5%;
	  font-size: 23px !important;
      font-weight: bold;
	  
	  white-space: normal;
      overflow: hidden;
      line-height: 1.3;
      height: 3.9em;
      text-overflow: ellipsis;
      display: -webkit-box;
      -webkit-line-clamp : 3;
      -webkit-box-orient: vertical;
	}
	/* 날짜 */
	.bg-white.m-body > hr.position-line {
	  position: absolute;
	  top: 73%;
	  width: 90%;
	  margin: 5% 5%;
	  border: 1px solid black;
	  left: 0;
	}
	/* 아이디(닉네임) */
	.bg-white.m-body > span.bottom-left {
	  position: absolute;
	  bottom: 8%;
	  left: 13%;
	  font-size: 13px;
	}
	/* 조회수 */
	.bg-white.m-body > span.bottom-right {
	  position: absolute;
	  bottom: 8%;
	  right: 13%;
	  font-size: 13px;
	}
	</style>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>

	<title>웨이팅 확인!!</title>
</head>

<header>
  <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>

<body>

	<div class="hero overlay" style="height: 600px;">
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
							<span class="bottom-left">닉네임</span>
							<span class="bottom-right">조회수 00회</span>
						</div>
					</div>
				</div>
			</div>	
		</div>		
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

		<!-- Preloader -->
		<div id="overlayer"></div>
		<div class="loader">
			<div class="spinner-border text-primary" role="status">
				<span class="visually-hidden">Loading...</span>
			</div>
		</div>
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

</script>

	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/aos.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/navbar.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/counter.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/rellax.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/flatpickr.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/glightbox.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/custom.js"></script>
</body>
</html>
