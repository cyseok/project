<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<!DOCTYPE html>
<html lang="en">

<head>

<style>
.login_warn {
   color: red;
}

.py-10 {
   max-width: 400px;
   margin: 0 auto;
   padding: 20px;
   background-color: #f7f7f7;
   border-radius: 5px;
}

.logo_wrap {
   text-align: center;
   font-size: 24px;
}

.id_wrap,
.pw_wrap {
   margin-bottom: 10px;
}

.id_input_box,
.pw_input_box {
    position:relative ;
}

.id_input,
.pw_iput {
   width: 95%;
   padding: 10px;
   border-radius: 5px;
   border: none;
   margin-top: 10px;
}

.login_warn {
    margin-top :10 px ;
    color:red ;

}

.join_button ,.login_button {
   display: block;
   width: 100%;
   padding: 12px;
   background-color: #4CAF50;
   color: white;
   text-align: center;
   border: none;
   cursor: pointer;
   margin-top: 15px;
   margin-bottom : 15px;
}

.btn_f {
    font-size :16px ;
    font-weight:bold ; 
}

.login_button{
	background-color:#af4c4c ;
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.js"
   integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
   crossorigin="anonymous"></script>

</head>

<body id="body" class="up-scroll">

   <div class="main-wrapper packages-grid"></div>


<!-- ====================================
———   로그인 SECTION
===================================== -->

   <section class="">
      <div class="container">
         <div class="py-10">
            <form id="login_form" method="post" action="<c:url value="/user/login"/>">
               <div class="logo_wrap title_f">로그인</div>
               <div class="login_wrap">
                  <div class="id_wrap ">
                     <div class="id_input_box">
                        <input class="id_input input_f" name="id" id="idInput"
                           placeholder="아이디를 입력하세요.">
                     </div>
                  </div>
                  <div class="pw_wrap">
                     <div class="pw_input_box">
                        <input type="password" class="pw_iput input_f" name="pw"
                           placeholder="비밀번호를 입력하세요.">
                     </div>
                  </div>

                  <c:if test="${result == 0 }">
                     <div class="login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
                  </c:if>

                  <div class="login_button_wrap">
                     <input type="button" class="login_button btn_f" value="로그인">
                  </div>
               </div>
                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
            </form>
            	<div class="login_con">
   					<button class="join_button btn_f" onclick="location.href='${pageContext.request.contextPath}/user/join'">회원가입</button>
				</div>


         </div>
         <!-- /py-10 -->
      </div>
      <!-- /container -->
   </section>


   <script>
      /* 로그인 버튼 클릭 메서드 */
      $(".login_button.btn_f").click(function() {
         //alert("로그인 버튼 작동");

         /* 로그인 메서드 서버 요청 */
         $("#login_form").attr("action", "login");
         $("#login_form").submit();

      });
   </script>
</body>
</html>