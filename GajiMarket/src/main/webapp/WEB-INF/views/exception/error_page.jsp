<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<link href="<c:url value="/resources/css/member.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrap">
<%@ include file="../includes/header_logo.jsp"%>


	<div class="mainArea">
		
		<h3 style="text-align: center;">잘못된 접근입니다.</h3><br>
		
		
		
		<h4><c:out value="${exception.getMessage()}"/></h4>
		
		<ul>
			<c:forEach items="${exception.getStackTrace()}" var="stack">
				<li style="font-size: small;"><c:out value="${stack}"/></li>
			</c:forEach>
		</ul>
		 
	<%@ include file="../includes/footer.jsp"%>			
	</div>
</div>
</body>
</html>