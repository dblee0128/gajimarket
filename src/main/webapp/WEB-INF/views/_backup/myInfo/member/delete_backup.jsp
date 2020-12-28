<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<link href="<c:url value="/resources/css/market.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
</head>
<body>
	<%@ include file="../../../includes/header.jsp"%>
	<h3 align="center">가지마켓 회원 탈퇴 페이지입니다.</h3>
	<h4 align="center">${nickname}님, 탈퇴를 위해서는 비밀번호를 입력해주세요.</h4>
	<form action="/myInfo/member/delete" method="post">
		<input type="hidden" name="email" value="${email}"> <!-- 세션으로 사용할수도 있지만, 이번에는 hidden으로 넘겨보기 -->
		<table>
			<tr>
				<td><input type="password" name="password" placeholder="비밀번호"></td>
			</tr>
			<tr>
				<td>${msg}</td>
			</tr>
			<tr>
				<td><input type="submit" value="탈퇴"></td>
			</tr>
		</table>
	</form>
	
	<%@ include file="../../../includes/footer.jsp"%>
</body>
</html>