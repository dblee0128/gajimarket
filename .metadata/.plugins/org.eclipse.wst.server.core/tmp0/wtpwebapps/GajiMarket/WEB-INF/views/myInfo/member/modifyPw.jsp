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
	<%@ include file="../../includes/header.jsp"%>
	<h3 align="center">비밀번호를 수정하세요.</h3>
	<div id="registerArea">
	
	<form:form action="modifyPw" method="post" modelAttribute="changePwCmd">
		<input type="hidden" name="email" value="${member.email}">
		<table>
				<tr>
					<td>
						<label>현재 비밀번호</label><br>
						<form:password path="currentPassword" placeholder="현재 비밀번호"/>
						<form:errors path="currentPassword" id="error"/>
					</td>
				</tr>
				<tr>
					<td>${msg1}</td>
				</tr>
				<tr>
					<td>
						<label>변경할 비밀번호</label><br>
						<label>8자 - 16자의 영소문자 + 숫자 조합</label>
						<form:password path="password" placeholder="변경할 비밀번호"/>
						<form:errors path="password" id="error"/>
					</td>
				</tr>
				<tr>
					<td>
						<label>변경할 비밀번호 확인</label><br>
						<form:password path="confirmPassword" placeholder="변경할 비밀번호 확인"/>
						<form:errors path="confirmPassword" id="error"/>
					</td>
				</tr>
				<tr>
					<td>${msg2}</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="수정">
						<input type="reset" value="초기화">
					</td>
				</tr>
			</table>
		</form:form>
		
		<!-- 
		<form action="modifyPw" method="post">
			<input type="hidden" name="email" value="${member.email}">
			<table>
				<tr>
					<td>
						<label>변경할 비밀번호</label><br>
						<label>8자 - 16자의 영소문자 + 숫자 조합</label>
						<input type="password" name="password" placeholder="비밀번호">
					</td>
				</tr>
				<tr>
					<td>
						<label>변경할 비밀번호 확인</label><br>
						<input type="password" name="confirmPassword" placeholder="비밀번호">
					</td>
				</tr>
				<tr>
					<td>${msg} ${msg2}</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="수정">
						<input type="reset" value="초기화">
					</td>
				</tr>
			</table>
		</form>
		 -->
	</div>
	<%@ include file="../../includes/footer.jsp"%>
</body>
</html>