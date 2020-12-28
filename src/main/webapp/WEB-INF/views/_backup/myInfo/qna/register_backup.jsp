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
<%@ include file="../../../includes/header.jsp"%>
<div id="container">
	<div id="wrap">
		<form:form action="register" method="post" modelAttribute="qna">
		<input type="hidden" name="membernum" value="${member.membernum}">
			<table id="board_tb" style="text-align: left;">
				<tr>
					<td>
						<label>문의유형</label>
						<form:select path="typenum">
							<form:option value="0">선택</form:option>
							<form:option value="1">거래 환불 / 분쟁 및 사기 신고</form:option>
							<form:option value="2">비매너 회원 신고</form:option>
							<form:option value="3">계정 문의</form:option>
							<form:option value="4">게시글 문의</form:option>
							<form:option value="5">기타 문의</form:option>
							<form:option value="6">오류 / 개선 / 제안</form:option>
						</form:select>
					</td>
				</tr>
				<tr><td id="error">${msg}</td></tr>
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
			<input type="button" value="목록" onclick="location.href='/myInfo/qna'">
		</form:form>
	</div>
</div>

<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>


<%@ include file="../../../includes/footer.jsp"%>
</body>
</html>