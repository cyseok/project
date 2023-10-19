<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
   
</head>

<body>
   <section class="">
      <div class="container">
         <div class="py-10">
            <div class="join_form_section">
               <h2 class="title_f">회원가입</h2>
                  <form:form id="join_form" name="login" action="/join" method="post" modelAttribute="Userinfo">
                        
                        <!-- 아이디 -->
                        <label for="id" class="sp">
                           <p class="s_tit">아이디</p>
                           <form:input path="id" type="text" class="id_input input_f" name="id" id="id" placeholder="아이디를 입력하세요."/>
                           <form:errors path="id" />
                       </label>
                        
                        <!-- 비밀번호 -->
                        <label for="pw" class="sp" >
                           <p class="s_tit">비밀번호</p>
                           <form:password path="pw" class="pw_input input_f" name="pw" id="pw" placeholder="비밀번호를 입력하세요."/>
                           <form:errors path="pw" />
                        </label>
                        

                        <!-- 이름 -->         
                     <label for="name" class="sp">
                        <p class="s_tit">이름</p>
                        <form:input path="name" type="text" class="name_input input_f" name="name" id="name" value=""  placeholder="이름을 입력하세요."/>
                        <form:errors path="name" />
                     </label>
            
            
            
                        <!-- 이메일 -->
                         <div class="sp">  
                        <label for="user_email"><p class="s_tit">이메일</p></label>
                        
                          <div class="join_tt">
                          <div class="join_right">
                           <form:input path="email" type="text" class="email_input input_f" id="email" placeholder="이메일을 입력해주세요" />
                          <form:errors path="email" />
                        </div>  
                        </div>
                        <br>
                        	<input type="hidden" name="userinfoRole" value="ROLE_USER" >
                        	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                           <input type="button" class="join_button" value="가입하기">
               </form:form>
            </div>
         </div>
      </div> 
   </section>
<script>
$(document).ready(function() {
	  // 가입하기 버튼 클릭 이벤트 핸들러
	  $('.join_button').click(function() {
	    var formData = $('#join_form').serialize();
	    
	    // AJAX 요청으로 서버에 데이터 전송
	    $.ajax({
	      url: '/user/join',  // 요청할 URL 주소 설정
	      type: 'POST',  // HTTP 요청 방식 설정 (POST로 변경 가능)
	      data: formData,  // 전송할 데이터 설정
	      success: function(response) {
	        // 성공적으로 응답받았을 때의 처리 로직 작성
	        
	        console.log(response);  // 응답 데이터 출력 (개발자 도구 콘솔에 표시)
	        
	        // 예를 들어, 가입 성공 시 메시지를 표시하고 페이지를 리다이렉트하는 등의 동작 수행 가능
	        
	        alert('가입이 완료되었습니다.');
	        window.location.href = '/login';  // 로그인 페이지로 리다이렉트
	        
	      },
	      error: function(xhr, status, error) {
	        // 요청 실패 시의 처리 로직 작성
	        
	        console.error(error);  // 에러 메시지 출력 (개발자 도구 콘솔에 표시)
	        
	        alert('가입 중 오류가 발생했습니다. 다시 시도해주세요.');
	        
	      }
	    });
	    
	  });
	});
      </script>
   </body>
</html>