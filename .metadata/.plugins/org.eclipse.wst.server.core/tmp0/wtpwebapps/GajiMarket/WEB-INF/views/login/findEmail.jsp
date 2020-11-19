<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<link href="<c:url value="/resources/css/member.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrap">
<%@ include file="../includes/header_logo.jsp"%>

	<div class="mainArea" style="margin-top: -17%;">
	
		<!-- 코멘트 영역 -->
		<div class="writeCmt" style="width: 30%;">
			<h4>이메일 찾기</h4>
		</div><br>
		
		<!-- 글 출력 영역 -->
		<div class="writeArea" style="width: 30%;">	
			<h4 align="center">
			이메일이 기억나지 않는다면<br> 가입 시 등록한 핸드폰 번호를 입력해주세요.
			</h4>
			
			<form action="findEmail" method="post">
				<table class="membertb">
					<tr>
						<td class="content">
							<input type="text" name="phone" placeholder="핸드폰 번호" class="memberInput">
						</td>
					</tr>
					<tr><td class="errors">${msg1}</td></tr>
					<tr><td class="errors">${msg2} ${email} ${msg3}</td></tr>
				</table>
				
				<div class="writeBtnArea">
					<button type="submit" class="bigBtn">이메일 찾기</button>
				</div>
			</form>
			
		</div>
		
	</div>
	<%@ include file="../includes/footer.jsp"%>		
</div>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
<script>
$(document).ready(function(){
	$("#deleteBtn").on("click", function(){
	
		alert('그동안 가지마켓을 이용해주셔서 감사합니다.');
	})
})
</script>
</body>
</html>