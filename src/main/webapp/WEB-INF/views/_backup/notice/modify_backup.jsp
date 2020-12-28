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
		<form:form action="${notice.noticenum}" method="post" modelAttribute="notice">
		<input type="hidden" name="membernum" value="${notice.membernum}">
		<input type="hidden" name="noticenum" value="${notice.noticenum}">	
			<table id="board_tb" style="text-align: left;">
				<tr>
					<td>
						<label>제목</label>
						<form:input path="title" placeholder="제목" value="${notice.title}"/>
					</td>
				</tr>
				<tr><td><form:errors path="title" id="error"/></td></tr>
				<tr>
					<td>
						<label>내용</label>
						<form:textarea path="content" cols="100" rows="20" value="${notice.content}" placeholder="내용"/>
					</td>
				</tr>
				<tr>
					<td><form:errors path="content" id="error"/></td>
				</tr>
			</table>
			
			<a href="/notice/modify/${notice.noticenum}?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
			<button>수정</button></a>
			
			<a href="/notice?pageNum=${cri.pageNum}&type=${cri.type}&keyword=${cri.keyword}">
			<button>취소</button></a>
			
			<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
			<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
			<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
			<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
		</form:form>
		<div id="buttonArea">
			<a href="/notice?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
			<button>목록</button></a>
		</div>
	</div>
</div>	

<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>

<%@ include file="../../includes/footer.jsp"%>
</body>
</html>