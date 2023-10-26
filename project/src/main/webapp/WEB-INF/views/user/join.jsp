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
   <style type="">
      /* 회원가입 폼 스타일 */
      .join_form_section {
         max-width: 400px;
         margin: 0 auto;
         padding: 20px;
         background-color: #f7f7f7;
         border-radius: 5px;
      }

      .join_form_section h2 {
         text-align: center;
         font-size: 24px;
         margin-bottom: 20px;
      }

      .join_form_section label {
         display: block;
         margin-bottom: 10px;
      }

      .join_form_section input[type=text],
      .join_form_section input[type=password] {
         width: 95%;
         padding: 10px;
         border-radius: 5px;
         border: none;
      	margin-top :10 px;
      }

    	.join_button {
    	  display:block ;
    	  width :100% ;
    	  height : 35px;
    	  padding :12 px ;
    	  background-color:#4CAF50 ;
    	  color:white ;
    	  text-align:center ;
    	  font-size:18px;
        border:none ; 
        cursor:pointer ; 
        margin-top :15 px; 

    	}

   </style>
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
                           <form:input path="id" type="text" class="id_input input_f" name="id" id="id" placeholder="영문, 숫자만 가능하며 4 ~ 20자리까지 가능합니다."/>
                           <form:errors path="id" />
                       </label>
                        
                        <!-- 비밀번호 -->
                        <label for="pw" class="sp" >
                           <p class="s_tit">비밀번호</p>
                           <form:password path="pw" class="pw_input input_f" name="pw" id="pw" placeholder="8~16자의 영문 대소문자 숫자 및 특수문자를 최소 하나씩 입력해주세요."/>
                           <form:errors path="pw" />
                        </label>
                        
                   <label for="confirmPw" class="sp">
                     <p class="s tit">비밀번호 확인</p>
                     <input type="password" id="confirmPw" name="confirmPw" placeholder="8~16자의 영문 대소문자 숫자 및 특수문자를 최소 하나씩 입력해주세요."/>
                     <!-- 에러 메시지 출력 -->
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
	    var id = $('#id').val(); // 입력된 아이디 값 가져오기
	    var email = $('#email').val(); // 입력된 아이디 값 가져오기
	    var password = $('#pw').val(); // 입력된 비밀번호 값 가져오기
	    var confirmPassword = $('#confirmPw').val(); // 입력된 비밀번호 확인 값 가져오기

	    // 비밀번호 확인 체크
	    if (password !== confirmPassword) {
	      alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
	      return;
	    }

	     // 아이디 및 이메일 중복 검사 AJAX 요청
	     $.ajax({
	       url: '/user/memberDuplicateCheck',  // 아이디 및 이메일 중복 검사 URL 주소 설정
	       type: 'POST',
	       data: { id: id, email: email },  // 전송할 데이터 설정 (아이디 및 이메일 정보)
	       success: function(response) {
	         if (response === 'failId') {  
	           alert('중복된 아이디입니다. 다른 아이디를 입력해주세요.');
	           return;
	         } else if (response === 'failEmail') {  
	           alert('중복된 이메일입니다. 다른 이메일을 입력해주세요.');
	           return;
	         } else {  
	           var formData = $('#join_form').serialize();

	           $.ajax({
	             url: '/user/join',
	             type: 'POST',
	             data: formData,
	             success: function(response) {
	               console.log(response);
	               alert('가입 완료');
	               window.location.href = '/user/login';
	             },
	             error: function(xhr, status, error) {
	               console.error(error);
	               alert('가입 오류 발생');
	             }
	           });
	         }
	       },
	       error: function(xhr, status, error) {
	         console.error(error);
	         alert('중복 검사 오류 발생');
	       }
	     });
	   });
	});
      </script>
   </body>
</html>