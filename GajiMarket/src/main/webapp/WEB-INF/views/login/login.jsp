<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<link href="<c:url value="/resources/css/test.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrap">

	<div class="loginArea">
		<img src="/resources/img/logo2.jpeg" class="logo">
		
		<form:form action="/" method="post" modelAttribute="loginCmd" class="loginForm">
			<table class="logintb">
				<tr>
					<td><form:input path="email" placeholder="이메일" autofocus="required" class="inputLarge"/></td>
				</tr>
				<tr>
					<td><form:errors path="email" class="errors"/></td>
				</tr>
				<tr>
					<td><form:password path="password" placeholder="비밀번호" class="inputLarge"/></td>
				</tr>
				<tr>
					<td><form:errors path="password" class="errors" /></td>
				</tr>
				<tr>
					<td class="errors">${msg}</td>
				</tr>
				<tr>
					<td><button type="submit" class="buttonLarge">로그인</button></td>
				</tr>
			</table>
		</form:form>
		
		<div id="linkArea">
			<a href="/findEmail" class="link">이메일 찾기</a>
			<a href="/findPw" class="link">비밀번호 재설정</a>
			<a href="/member/register" class="link">회원가입</a>
		</div>
		
	</div>
	
<%@ include file="../includes/footer.jsp"%>
</div>
</body>
</html>