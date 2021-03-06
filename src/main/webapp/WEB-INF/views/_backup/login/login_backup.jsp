<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<link href="<c:url value="/resources/css/market.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrap">
	<div id="imgArea">
		<img src="resources/img/gaji.png" width="400" height="400">
	</div>

	<div id="loginArea">
		<h3>가까운 인천 지역구/군민들과의 마음 따뜻한 거래</h3>
		<h1>가지마켓</h1>
		<form:form action="/" method="post" modelAttribute="loginCmd">
			<table>
				<tr>
					<td><form:input path="email" placeholder="이메일" autofocus="required"/></td>
				</tr>
				<tr>
					<td><form:errors path="email" id="error"/></td>
				</tr>
				<tr>
					<td><form:password path="password" placeholder="비밀번호"/></td>
				</tr>
				<tr>
					<td><form:errors path="password" id="error"/></td>
				</tr>
				<tr>
					<td>${msg}</td>
				</tr>
				<tr>
					<td><input type="submit" value="로그인"></td>
				</tr>
			</table>	
		</form:form>
		<a href="/findEmail"><button id="halfBtn">이메일 찾기</button></a>
		<a href="/findPw"><button id="halfBtn">비밀번호 재설정</button></a><br>
		<a href="/member/register"><button id="btn">회원가입</button></a>
		
	</div>
</div>
	<%@ include file="../../includes/footer.jsp"%>
</body>
</html>