<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <style>
        body {
            text-align: center;
        }

        .container {
            width: 50%;
            margin: 0 auto;
        }
    </style>
<title>권한 없음</title>
</head>
<body>
<div class="container">
<img src="${pageContext.request.contextPath}/assets/images/error.png" style="width: 100px; height: 100px;">
    <h1>페이지에 접근할 수 없습니다.</h1>
    <hr>
    <p>해당 페이지에 접근할 권한이 없습니다.</p>
    <p>로그인 후 다시 시도해주세요.</p>
    <hr>
    <a href="javascript:window.history.back()">이전 페이지로</a>
    <br>
    <a href="/">메인페이지로 이동</a>
</div>
</body>
</html>