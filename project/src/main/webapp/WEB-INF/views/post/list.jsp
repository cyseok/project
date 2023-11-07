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
    height: 260px; 
    border-radius: 15px;
  }
</style>






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

					<h1 class="heading" data-aos="fade-up">Blog</h1>
					<p class="mb-4" data-aos="fade-up">A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.</p>
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
							<span class="date">May 14, 2020</span>
							<h3><a href="index.html">Far far away, behind the word mountains</a></h3>
							<p>Vokalia and Consonantia, there live the blind texts. Separated they live.</p>
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
