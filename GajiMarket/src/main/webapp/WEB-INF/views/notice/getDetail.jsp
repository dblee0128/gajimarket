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
			<h4>공지사항</h4>
		</div>
		
		<!-- 글 출력 영역 -->
		<div class="writeArea">
			<table class="detailtb">
				<tr>
					<td class="title">${notice.title}</td>
				</tr>
				<tr>
					<td class="content"><pre><c:out value="${notice.content}"/></pre></td>
				</tr>
			</table>
					
			<!-- 버튼 영역 -->
			<div class="writeBtnArea">
				<a href="/notice?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
				<button>목록</button></a>
				
				<c:if test="${member.isadmin == 1}">
					<a href="/notice/modify/${notice.noticenum}?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
					<button>수정</button></a>
					
					<a href="/notice/delete/${notice.noticenum}">
					<button id="deleteBtn">삭제</button></a><br>${msg}
				</c:if>
			</div>
		</div>
		
		<!-- /notice/modify라는 요청이 들어왔을 때 각각의 값을 보내준다  -->
		<form action="/notice/modify" method="get">
			<input type="hidden" name="noticenum" value="<c:out value="${notice.noticenum}"/>">
			<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
			<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
			<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
			<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
		</form>
		
	</div>
	<%@ include file="../includes/footer.jsp"%>		
</div>

<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
<script>
$(document).ready(function(){
	$("#deleteBtn").on("click", function(){
	
		if(confirm("정말 삭제하시겠습니까?") == true){
			alert('공지사항이 삭제되었습니다.');
		} else {
			return false;
		}
	})
})
</script>
</body>
</html>