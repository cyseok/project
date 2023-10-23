<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 목록</title>
</head>
<body>

	<div class="">
	  <select class="select" name="column" >
	     <option value="">전체</option>
	     <option value="diy_title">제목</option>
	     <option value="diy_content">내용</option>
	     <option value="diy_loc" >지역</option>
	  </select>
	</div>
	
	<div style="text-align:right;">
	  <button class="" name="type" value="recently" type="submit" style="padding: 9px 20px; margin-top: -18px;">
	    최신순
	  </button>
	  <button class="" name="type" value="love" type="submit" style="padding: 9px 20px; margin-top: -18px;" >
	    인기순
	  </button>
	</div>

</body>
</html>