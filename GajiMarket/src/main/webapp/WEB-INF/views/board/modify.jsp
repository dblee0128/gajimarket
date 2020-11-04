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
		<form:form action="${board.boardnum}" method="post" modelAttribute="board">
		<input type="hidden" name="membernum" value="${board.member.membernum}">
		<input type="hidden" name="boardnum" value="${board.boardnum}">
			<table id="board_tb" style="text-align: left;">
				<tr>
					<td>
						<label>판매여부</label>
						<select name="sell">
							<option value="판매중" <c:if test="${board.sell eq '판매중'}">selected</c:if>>판매중</option>
							<option value="판매완료" <c:if test="${board.sell eq '판매완료'}">selected</c:if>>판매완료</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<label>제목</label>
						<form:input path="title" placeholder="제목" value="${board.title}"/>
					</td>
				</tr>
				<tr><td><form:errors path="title" id="error"/></td></tr>
				<tr>
					<td>
						<label>가격</label>
						<form:input path="price" placeholder="가격" value="${board.price}"/>
					</td>
				</tr>
				<tr>
					<td><form:errors path="price" id="error"/></td>
				</tr>
				<tr>
					<td>
						<label>내용</label>
						<form:textarea path="content" cols="100" rows="20" value="${board.content}" placeholder="내용"/>
					</td>
				</tr>
				<tr>
					<td><form:errors path="content" id="error"/></td>
				</tr>
				<tr>
					<td>
						<label>카테고리</label>
						<select name="categorynum">
							<option value="0">선택</option>
							<option value="1" <c:if test="${board.category.categorynum == 1}">selected</c:if>>디지털</option>
							<option value="2" <c:if test="${board.category.categorynum == 2}">selected</c:if>>가구</option>
							<option value="3" <c:if test="${board.category.categorynum == 3}">selected</c:if>>생활용품</option>
							<option value="4" <c:if test="${board.category.categorynum == 4}">selected</c:if>>스포츠</option>
							<option value="5" <c:if test="${board.category.categorynum == 5}">selected</c:if>>의류/잡화</option>
							<option value="6" <c:if test="${board.category.categorynum == 6}">selected</c:if>>미용</option>
							<option value="7" <c:if test="${board.category.categorynum == 7}">selected</c:if>>애완동물</option>
							<option value="8" <c:if test="${board.category.categorynum == 8}">selected</c:if>>도서</option>
							<option value="9" <c:if test="${board.category.categorynum == 9}">selected</c:if>>기타</option>
						</select>
					</td>
				</tr>
				<tr><td id="error">${msg}</td></tr>
			</table>
			
			<a href="/board/modify/${board.boardnum}?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
			<button>수정</button></a>
			
			<a href="/board?pageNum=${cri.pageNum}&type=${cri.type}&keyword=${cri.keyword}">
			<button>취소</button></a>
			
			<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
			<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
			<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
			<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
		</form:form>
		<div id="buttonArea">
			<a href="/board?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}"><button>목록</button></a>
		</div>
	</div>	
</div>	
<%@ include file="../includes/footer.jsp"%>
</body>
</html>