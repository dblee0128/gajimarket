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
		<div class="writeCmt" style="width: 40%;">
			<h4>비밀번호 재설정</h4>
		</div><br>
		
		<!-- 글 출력 영역 -->
		<div class="writeArea" style="width: 40%;">	
			<h4 align="center">
			비밀번호가 기억나지 않는다면 가입한 이메일을 입력해주세요.<br>
			해당 이메일로 임시 비밀번호를 보내드립니다.<br>
			</h4>
			
			<form action="findPw" method="post">
				<table class="membertb">
					<tr>
						<td class="content">
							<input type="text" name="email" placeholder="이메일" class="memberInput">
						</td>
					</tr>
					<tr><td class="errors" style="text-align: center;">${msg1}</td></tr>
					<tr><td class="errors" style="text-align: center;">${msg2}</td></tr>
				</table>
				
				<div class="writeBtnArea">
					<button type="submit" class="bigBtn" style="margin-left: -44px;">비밀번호 재설정</button>
					<a href="/" class="link" style="font-size: small;">로그인</a> 
					&nbsp;&nbsp;&nbsp;
					<a href="/member/register" class="link" style="font-size: small;">회원가입</a>
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