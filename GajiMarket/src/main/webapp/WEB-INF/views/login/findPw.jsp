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
	<%@ include file="../includes/header.jsp"%>
	<h3 align="center">비밀번호가 기억나지 않는다면<br>가입 시 등록한 이메일을 입력해주세요.<br>
					   해당 이메일로 비밀번호 재설정 가능한 링크를 보내드립니다.</h3>
	<div id="registerArea">
		<form action="findPw" method="post">
			<table>
				<tr>
					<td>
						<input type="text" name="email" placeholder="이메일">
					</td>
				</tr>
				<tr>
					<td id="error">${msg1}</td>
				</tr>
				<tr>
					<td id="error">${msg2}</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="비밀번호 재설정">
					</td>
				</tr>
			</table>
		</form>
		<div id="buttonArea">
			<a href="/"><button id="halfBtn">로그인</button></a>
			<a href="/member/register"><button id="halfBtn">회원가입</button></a>
		</div>
	</div>
	<%@ include file="../includes/footer.jsp"%>
</body>
</html>