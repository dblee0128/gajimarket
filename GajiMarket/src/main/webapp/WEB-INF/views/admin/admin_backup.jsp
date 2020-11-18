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
	<h3 align="center">가지마켓에서의<br>활동 내역 및 회원 정보를 관리하세요.</h3>
	<table>
		<tr>
			<td><a href="/admin/member" style="color: black;"><button>회원 관리</button></a></td>
		</tr>
		<tr>
			<td><a href="/admin/board" style="color: black;"><button>게시물 관리</button></a></td>
		</tr>
		<tr>
			<td><a href="/notice" style="color: black;"><button>공지사항 관리</button></a></td>
		</tr>
		<tr>
			<td><a href="/admin/qna" style="color: black;"><button>문의 내역</button></a></td>
		</tr>
	</table>
	<%@ include file="../includes/footer.jsp"%>
</body>
</html>