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

                  <div class="login_con">
                   <a href="${pageContext.request.contextPath}/user/join">회원가입</a>
                  </div>

                  <div class="login_button_wrap">
                     <input type="button" class="login_button btn_f" value="로그인">

                    
                     
                     <!--<a class="p-2">
                       <img alt="카카오로그인" src="${pageContext.request.contextPath}/assets/img/kakaoBtn.png"
                             onclick="location.href='<c:url value="/kakao/login"/>';">
                       <img alt="네이버로그인" src="<c:url value="/assets/img/naverBtn.png"/>" width="200"
                           onclick="location.href='<c:url value="/naver/login"/>';">
                     </a>  -->
                  </div>
               </div>
                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
            </form>


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