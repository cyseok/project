<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
	<title>아이디찾기</title>
<style>
#find-id {
  margin-top: 200px; 
  width: 50%;
  margin-left: auto;
  margin-right: auto;
}
</style>
</head>

<header>
  <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>

<body>
  <div class="section">
    <div class="container">
      <div class="row">
		<section id="find-id">
			<h3 class="log-title">아이디 찾기</h3>
			<form id="find_form">
				<div class="form-group">
					<input type="text" class="form-control" id="name"
					name="name" placeholder="이름">
				</div>
				<div class="form-group">
					<input type="email" class="form-control" id="email"
					name="email" placeholder="이메일">
				</div>
				<!-- 아이디 찾기 버튼 -->
				<div class="form-group">
					<button type="button" id="check-id-button" class="btn btn-secondary">아이디 찾기</button>
				</div>
				<sec:csrfInput/>
			</form>
		</section>
	  </div>
	</div>
  </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
<script>
var findButton = document.getElementById("check-id-button");
function findDisableButton() {

	findButton.disabled = true;
	
    setTimeout(function () {
    	findButton.disabled = false;
    }, 3000);
  }
  
	  $("#check-id-button").click(function() {
	      var name = $("#name").val();
	      var email = $("#email").val();
		  var emailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		  
		  if(email === "") {
			  alert('이메일을 작성해주세요.');
			  $("#email").focus();
				return;
		   }
		  if(!emailPattern.test(email)) {
			  alert('이메일 형식을 확인해주세요.');
			  $("#email").focus();
				return;
		   }
		  if(name === "") {
			  alert('이름을 작성해주세요.');
			  $("#name").focus();
				return;
		   }
		  
		  findDisableButton();

	    $.ajax({
	      url: "<c:url value='/user/find-id'/>",
	      type: "GET",
	      data: {"email": email
	    	  , "name": name},
	      success: function(result) {
	    	  if (result.id !== undefined) {
	    		  alert("해당 정보로 찾은 아이디는 "+result.id +" 입니다.");
	    		} else {
	    		  alert("해당 정보의 계정이 없습니다.");
	    		}
	      }, error: function(error) {
	    	  alert("에러가 발생했습니다.");
	      }
	    });
	  });
</script>
</body>
</html>
