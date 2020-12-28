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
<link href="<c:url value="/resources/css/board.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrap">
<%@ include file="../includes/header.jsp"%>

	<div class="mainArea">
	
		<!-- 코멘트 영역 -->
		<div class="writeCmt">
			<h4>공지사항 수정하기</h4>
		</div>
		
		<!-- 글 출력 영역 -->
		<div class="writeArea">
			<form:form action="${notice.noticenum}" method="post" modelAttribute="notice">
				<input type="hidden" name="membernum" value="${membernum}">
				<input type="hidden" name="noticenum" value="${notice.noticenum}">
			
				<table class="writetb">
					<tr>
						<td class="cmt">제목</td>
						<td><form:input path="title" placeholder="제목을 입력하세요." class="writeInput"/></td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="title"/></td></tr>
					
					<tr>
						<td class="cmt">내용</td>
						<td><form:textarea path="content" cols="80" rows="20" placeholder="내용을 입력하세요." class="writeTextArea"/></td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="content"/></td></tr>
				</table>
					
			<!-- 버튼 영역 -->
			<div class="writeBtnArea">
				<a href="/notice/modify/${notice.noticenum}?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
				<button type="submit">수정</button></a>
				
				<a href="/notice/${notice.noticenum}?pageNum=${cri.pageNum}&type=${cri.type}&keyword=${cri.keyword}">
				<button type="button">취소</button></a>
				
				<a href="/notice?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
				<button type="button">목록</button></a>
				
				<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
				<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
				<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
				<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
			</div>
			
			</form:form>
		</div>	
	</div>
	<%@ include file="../includes/footer.jsp"%>	
</div>
</body>
</html>