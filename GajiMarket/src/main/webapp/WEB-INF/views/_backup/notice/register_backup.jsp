<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<link href="<c:url value="/resources/css/board.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
</head>
<body>
<%@ include file="../../includes/header.jsp"%>
<div id="container">
	<div id="wrap">
		<form:form action="register" method="post" modelAttribute="notice">
		<input type="hidden" name="membernum" value="${member.membernum}">
			<table id="board_tb" style="text-align: left;">
				<tr>
					<td>
						<label>제목</label>
						<form:input path="title" placeholder="제목"/>
					</td>
				</tr>
				<tr><td><form:errors path="title" id="error"/></td></tr>
				<tr>
					<td>
						<label>내용</label>
						<form:textarea path="content" cols="100" rows="20" placeholder="내용"/>
					</td>
				</tr>
				<tr>
					<td><form:errors path="content" id="error"/></td>
				</tr>
			</table>
			<button type="submit">등록</button>
			<input type="button" value="목록" onclick="location.href='/notice'">
		</form:form>
	</div>
</div>
<%@ include file="../../includes/footer.jsp"%>
</body>
</html>