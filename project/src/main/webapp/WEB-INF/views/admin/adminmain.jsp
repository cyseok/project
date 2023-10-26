<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<!DOCTYPE html>
<html lang="en">
<head>
<title>관리자페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<div id="preloader">
		<div class="spinner spinner-round"></div>
	</div>
<section id="adminpage">
	<div class="container-fluid">
		<div class="row">
			<!-- 사이드바 -->
			<div class="d-flex justify-content-center py-3">
			    <!-- 회원 관리 -->
			    	<a href="javascript:void(0)" id="userinfo-info"><i class="fas fa-user"></i>회원목록</a>
			   
			</div>

			<!-- 본문 -->
			<div class="col">
				
				<!-- 페이지 당 출력 갯수를 출력하는 태그 -->
				<select id="pageSizeSelect" class="mb-3"></select>

				<!-- 버튼 추가
				<div id="viewSelect" class="nav nav-pills text-right mb-3"></div>
				<!-- 게시글 목록을 출력하는 태그 -->
				<div id="infoListDiv" class="mb-3"></div>

				<!-- 페이지 번호를 출력하는 태그 -->
				<div id="pageNumDiv" class="mb-3 page-number-wrapper"></div>

			</div>
		</div>
	</div>
</section>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
//CSRF 토큰 관련 정보를 자바스크립트 변수에 저장
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

// Ajax 기능을 사용하여 요청하는 모든 웹 프로그램에게 CSRF 토큰 전달 가능
// ▶ Ajax 요청 시 beforeSend 속성을 설정할 필요 없음
$(document).ajaxSend(function(e, xhr){
   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});
	
	var page = 1; // 기본 페이지 번호 설정
	var size = 20; // 기본 페이지 크기 설정
	var keyword = ''; // 기본 검색어 = NULL String
	var viewType = 'list'; // 기본 보기 설정 = 목록으로 보기
	
	//회원 정보 리스트 출력
	function userinfoListDisplay(pageNum, pageSize, selectKeyword) {
		$("#viewSelect").show();
		$("#pageSizeSelect").show();
		$("#pageNumDiv").show();
	   page=pageNum;
	   size=pageSize;
	   keyword=selectKeyword;
   
    $.ajax({
        method: "GET",
        url: "<c:url value="/admin/userinfo-list"/>",
        data: {"pageNum": pageNum, "pageSize": pageSize, "selectKeyword": selectKeyword},
        dataType: "json",
        success: function(result) {
            $("#infoListDiv").empty();
            
            var table = $("<table>").attr("id", "userinfoInfoTable").addClass('table table-striped');
            var thead = $("<thead>").append(
                "<tr>" +
                "<th style='padding: 10px; white-space: nowrap;'>아이디</th>" +
                "<th style='padding: 10px; white-space: nowrap;'>이름</th>" +
                "<th style='padding: 10px; white-space: nowrap;'>이메일</th>" +
                "<th style='padding: 10px; white-space: nowrap;'>가입일</th>" +
                "<th style='padding: 10px; white-space: nowrap;'>마지막로그인</th>" +
                "<th style='padding: 10px; white-space: nowrap;'>상태</th>" +
                "</tr>"
            );

            var tbody = $("<tbody>");

            if (result.userinfoList.length == 0) { // 검색된 게시글이 없을 때
                var row = "<tr>" +
                    "<td colspan='10'>검색된 회원 정보가 없습니다.</td>" +
                    "</tr>";
                tbody.append(row);
            } 
            for (var i = 0; i < result.userinfoList.length; i++) {
                var userinfo = result.userinfoList[i];
                var displayStatus = '';
                switch(userinfo.status) {
                    case 0: displayStatus = '일반회원'; break;
                    case 2: displayStatus = '휴면회원'; break;
                    case 3: displayStatus = '탈퇴회원'; break;
                    case 9: displayStatus = '관리자'; break;
                    default: displayStatus = userinfo.status;
                }
                
                var row = "<tr data-id='" + userinfo.id + "'>" +
                    "<td style='padding: 5px; white-space: nowrap;'>" + userinfo.id + "</td>" +
                    "<td style='padding: 5px; white-space: nowrap;'>" + userinfo.name + "</td>" +
                    "<td style='padding: 5px; white-space: nowrap;'>" + userinfo.email + "</td>" +
                    "<td style='padding: 5px; white-space: nowrap;'>" + userinfo.regdate + "</td>" +
                    "<td style='padding: 5px; white-space: nowrap;'>" + userinfo.logdate + "</td>" +
                    "<td style='padding: 5px; white-space: nowrap;'>" + displayStatus + "</td>" +
                    "</tr>";
                tbody.append(row);
           }

            table.append(thead, tbody);
            
            $("#infoListDiv").append(table);
            
          
            // 페이지 번호 출력
            pageNumDisplay(result.pager, infoType);
            
            // 페이지 당 출력 갯수를 출력
           pageSizeDisplay();
           
        }, 
        
        error: function(xhr) {
            alert("회원 정보를 불러오는 중에 오류가 발생했습니다. (에러 코드 = " + xhr.status + ")");
        }
    });
}
	
	
	
	
	//페이지 번호를 출력하는 함수
	function pageNumDisplay(pager, infoType) {
	    var html = "";
	    if (pager.startPage > pager.blockSize) {
	        html += "<a href=\"javascript:" + infoType + "ListDisplay(" + pager.prevPage + ", " + size + ", '" + keyword + "');\" class='btn btn-direction btn-default btn-rounded'><i class='fa fa-long-arrow-left'/></a>";
	    } else {
	        html += "<a class='btn btn-direction btn-default btn-rounded' disabled><i class='fa fa-long-arrow-left'/></a>";
	    }

	    for (var i = pager.startPage; i <= pager.endPage; i++) {
	        if (pager.pageNum != i) {
	            html += "<a class='btn btn-direction btn-default btn-rounded' href=\"javascript:" + infoType + "ListDisplay(" + i + ", " + size + ", '" + keyword + "');\">" + i + "</a>";
	        } else {
	            html += "<a class='btn btn-direction btn-default btn-rounded' disabled>" + i + "</a>";
	        }
	    }

	    if (pager.endPage != pager.totalPage) {
	        html += "<a href=\"javascript:" + infoType + "ListDisplay(" + pager.prevPage + ", " + size + ", '" + keyword + "');\" class='btn btn-direction btn-default btn-rounded'><i class='fa fa-long-arrow-right'/></a>";
	    } else {
	        html += "<a class='btn btn-direction btn-default btn-rounded' disabled><i class='fa fa-long-arrow-right'/></a>";
	    }

	    $("#pageNumDiv").html(html);
	}
	
	// 페이지 당 출력 갯수를 설정하는 함수
	function pageSizeDisplay() {
	    // 페이지 크기 선택
	    var pageSizeSelect = $("#pageSizeSelect");

	    pageSizeSelect.empty(); // 기존 옵션 초기화

	    var pageSizeOptions = [10, 20, 50, 100];
	    for (var i = 0; i < pageSizeOptions.length; i++) {
	        var optionValue = pageSizeOptions[i];
	        var optionText = optionValue + "개씩 보기";

	        var option = $("<option>").val(optionValue).text(optionText);

	        if (optionValue === size) {
	            option.prop("selected", true);
	        }
	        pageSizeSelect.append(option);
	    }
	}
	
	
	//회원 상세 정보를 열람하기 위한 함수
	function userinfoDetail(id) {
		$("#viewSelect").hide();
		$("#pageSizeSelect").hide();
		$("#pageNumDiv").hide();
	    $.ajax({
	        method: "GET",
	        url: "<c:url value='/admin/userinfo-detail'/>",
	        data: {"id": id},
	        dataType: "html",
	        success: function(html) {
	            var userinfoDetailDiv = $("<div>").html(html); // HTML을 DOM 요소로 변환
	            $("#infoListDiv").empty().append(userinfoDetailDiv); // 기존 내용 지우고 새로운 내용 삽입
	        },
	        error: function(xhr) {
	            alert("상세 정보를 불러오는 중에 오류가 발생했습니다. 에러 코드 = (" + xhr.status + ")");
	        }
	    });
	}
	

	$(document).ready(
			function() {
				$("#pageSizeSelect").hide();
				$("#viewSelect").hide();

				//회원 목록 버튼 클릭 시
				$("#userinfo-info").off("click").on("click", function() {
					$("#viewSelect").show();
					$("#pageSizeSelect").show();
					$("#pageNumDiv").show();
					page = 1;
					size = 20;
					infoType = "userinfo";
					userinfoListDisplay(page, size);

					$("#pageSizeSelect").val(size);
				});




				//한 페이지 당 출력 갯수를 변경햇을 시
				$("#pageSizeSelect").change(function() {
					var functionName = infoType + "ListDisplay";
					var selectedPageSize = parseInt($(this).val());

					// 동적으로 함수 호출
					window[functionName](page, selectedPageSize, keyword);
				});
				

				//목록으로 보기 버튼 클릭 시
				$("#viewSelect").on("click", "#listViewButton", function() {
					viewType = "list";
					packageListDisplay(page, size, keyword);
				});

				// 회원 tr 태그 클릭 시 상세 정보 보기로 이동
				$("#infoListDiv").on("click", "#userinfoInfoTable tbody tr",function() {
					var id = $(this).data("id");
					userinfoDetail(id);
				});
				

			
			});

</script>	
</body>
</html>
