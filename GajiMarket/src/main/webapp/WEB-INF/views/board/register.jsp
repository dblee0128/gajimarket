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
<%@ include file="../includes/header.jsp"%>
<div id="container">
	<div id="wrap">
		<form:form action="register" method="post" modelAttribute="board">
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
						<label>가격</label>
						<form:input path="price" placeholder="가격"/>
					</td>
				</tr>
				<tr>
					<td><form:errors path="price" id="error"/></td>
				</tr>
				<tr>
					<td>
						<label>내용</label>
						<form:textarea path="content" cols="100" rows="20" placeholder="내용"/>
					</td>
				</tr>
				<tr>
					<td><form:errors path="content" id="error"/></td>
				</tr>
				<tr>
					<td>
						<label>카테고리</label>
						<form:select path="categorynum">
							<form:option value="0">선택</form:option>
							<form:option value="1">디지털</form:option>
							<form:option value="2">가구</form:option>
							<form:option value="3">생활용품</form:option>
							<form:option value="4">스포츠</form:option>
							<form:option value="5">의류/잡화</form:option>
							<form:option value="6">미용</form:option>
							<form:option value="7">애완동물</form:option>
							<form:option value="8">도서</form:option>
							<form:option value="9">기타</form:option>
						</form:select>
					</td>
				</tr>
				<tr><td id="error">${msg}</td></tr>
			</table>
			<input type="submit" value="등록">
			<input type="button" value="목록" onclick="location.href='/board'">
		</form:form>
	</div>	
</div>	
<%@ include file="../includes/footer.jsp"%>
</body>
</html>