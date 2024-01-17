<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
	<jsp:include page="/WEB-INF/views/include/head.jsp"/>
	<title>회원정보</title>
<style>
#find-id {
  margin-top: 170px; 
  width: 30%;
  margin-left: auto;
  margin-right: auto;
}
#email {
  font-size: 20px;
}
.log-title {
  margin-bottom: 20px;
}
.section {
  margin-bottom: 100px;
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
	        <input type="hidden" name="userinfoId" id="userinfoId" value="${sessionScope.userinfoId}">
		    <h3 class="log-title">닉네임 변경</h3>
			   <div class="form-group">
				  <input type="text" class="form-control" id="nickname" name="nickname">
			   </div>
			<sec:csrfInput/>
			   <div class="form-group">
				  <p id=email></p>
			   </div>
			   <div class="form-group">
				  <button type="button" id="nickname-button" class="btn btn-secondary" onclick="nicknameModify()">닉네임 변경하기</button>
			   </div>
	     </section>
      </div>
   </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	

<script>
$(document).ready(function() { // JSP가 렌더링되자마자,
	myNickname();
});

// 닉네임 출력
function myNickname() {
	var id = $("#userinfoId").val();
	$('#loading').show();
	$.ajax({        
		url: "<c:url value='/user/find-nickname'/>",
		data : {"id": id},
		type : "GET",
		dataType: "json",
	    success: function(result) {
	    	console.log(result.nickname);
	    	  if(result.nickname !== null) {
	    		  $('#loading').hide();
	    		  $("#nickname").val(result.nickname);
	    		  $("#email").text(result.email);
	    	  } else {
	    		  $('#loading').hide();
	    		  $("#nickname").val(result.nickname);
	    		  $("#email").text(result.email);
	    		  alert("현재 설정된 닉네임이 없습니다. 닉네임을 설정해주세요!!");
	    	  }
	    		
	      }, error: function(error) {
	    	  $('#loading').hide();
	    	  console.log(error);
	    	  alert("현재 설정된 닉네임이 없습니다. 닉네임을 설정해주세요!!");
	      }
	 });
}

// 닉네임 수정
function nicknameModify() {  
	
	var id = $("#userinfoId").val();
	var nickname = $("#nickname").val();
	$('#loading').show();
    $.ajax({
        type: "PATCH",
        url: "<c:url value='/user/'/>" + id,
        data: JSON.stringify({'id': id,'nickname' : nickname}),
        contentType: 'application/json',
        dataType: "text",
        success: function (data, textStatus, xhr) {
            if (xhr.status == 200) {
            	$('#loading').hide();
            	alert("닉네임 변경이 완료되었습니다.")
            }
            
        }, error: function(error) {
        	$('#loading').hide();
            console.log(error);
        }
    });
}
</script>
</body>
</html>