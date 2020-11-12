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
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
</head>
<body>
<%@ include file="../../includes/header.jsp"%>
<div id="container">
	<div id="wrap">
		<table id="board_tb">
			<tr>
				<td colspan="5" align="right">
					<a href="qna/register"><button style="text-align: right;">1:1 문의하기</button></a>
				</td>
			</tr>
			<tr>
				<th>문의유형</th><th>제목</th><th>작성자</th><th>작성일자</th><th>문의번호</th>
			</tr>
			<tr>
			<c:forEach var="qna" items="${qna}">
			<tr>
				<td><c:out value="${qna.type.typename}"/></td>
				<td>
				<a href="qna/${qna.qnanum}" id="link"/><c:out value="${qna.title}"/></a>
				</td>
				<td><c:out value="${qna.member.nickname}"/></td>
				<td><c:out value="${qna.regdate}"/></td>
				<td><c:out value="${qna.qnanum}"/></td>
			</tr>
			</c:forEach>	
		</table>
	</div>	
</div>	
<%@ include file="../../includes/footer.jsp"%>
</body>
</html>