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
		<form:form action="${qna.qnanum}" method="post" modelAttribute="qna">
		<input type="hidden" name="membernum" value="${qna.member.membernum}">
		<input type="hidden" name="boardnum" value="${qna.qnanum}">	
			<table id="board_tb" style="text-align: left;">
				<tr>
					<td>
						<label>문의유형</label>
						<select name="typenum">
							<option value="0">선택</option>
							<option value="1" <c:if test="${qna.type.typenum == 1}">selected</c:if>>거래 환불 / 분쟁 및 사기 신고</option>
							<option value="2" <c:if test="${qna.type.typenum == 2}">selected</c:if>>비매너 회원 신고</option>
							<option value="3" <c:if test="${qna.type.typenum == 3}">selected</c:if>>계정 문의</option>
							<option value="4" <c:if test="${qna.type.typenum == 4}">selected</c:if>>게시글 문의</option>
							<option value="5" <c:if test="${qna.type.typenum == 5}">selected</c:if>>기타 문의</option>
							<option value="6" <c:if test="${qna.type.typenum == 6}">selected</c:if>>오류 / 개선 / 제안</option>
						</select>
					</td>
				</tr>
				<tr><td id="error">${msg}</td></tr>
				<tr>
					<td>
						<label>제목</label>
						<form:input path="title" placeholder="제목" value="${qna.title}"/>
					</td>
				</tr>
				<tr><td><form:errors path="title" id="error"/></td></tr>
				<tr>
					<td>
						<label>내용</label>
						<form:textarea path="content" cols="100" rows="20" placeholder="내용" value="${qna.content}"/>
					</td>
				</tr>
				<tr>
					<td><form:errors path="content" id="error"/></td>
				</tr>
			</table>
			<a href="/myInfo/qna/modify/${qna.qnanum}"><button type="submit">수정</button></a>
			<a href="/myInfo/qna"><button>취소</button></a>
		</form:form>
		<div id="buttonArea">
			<a href="/myInfo/qna"><button>목록</button></a>
		</div>
	</div>	
</div>	

<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>

<%@ include file="../../../includes/footer.jsp"%>
</body>
</html>