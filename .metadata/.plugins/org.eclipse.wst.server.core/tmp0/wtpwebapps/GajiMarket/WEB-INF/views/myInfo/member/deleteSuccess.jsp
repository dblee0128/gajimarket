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
	<h3 align="center">탈퇴가 완료되었습니다.<br>
	그동안 가지마켓을 이용해주셔서 감사합니다.</h3>
	<a href="/"><button>확인</button></a>
	<%@ include file="../../includes/footer.jsp"%>
</body>
</html>