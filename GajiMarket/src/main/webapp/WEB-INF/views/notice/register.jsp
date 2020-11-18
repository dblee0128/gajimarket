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
<link href="<c:url value="/resources/css/includes.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrap">
<%@ include file="../includes/header.jsp"%>

	<div class="mainArea">
	
		<!-- 코멘트 영역 -->
		<div class="writeCmt">
			<h4>공지사항 등록하기</h4>
		</div>
		
		<!-- 글 출력 영역 -->
		<div class="writeArea">
			<form:form action="register" method="post" modelAttribute="notice">
				<input type="hidden" name="membernum" value="${member.membernum}">
			
				<table class="writetb">
					<tr>
						<td class="cmt">제목</td>
						<td><form:input path="title" placeholder="제목을 입력하세요." class="writeInput"/></td>
					</tr>
					<tr><td colspan="2"><form:errors path="title" class="errors"/></td></tr>
					
					<tr>
						<td class="cmt">내용</td>
						<td><form:textarea path="content" cols="80" rows="20" placeholder="내용을 입력하세요." class="writeTextArea"/></td>
					</tr>
					<tr><td colspan="2"><form:errors path="content" class="errors"/></td></tr>
				</table>
					
			<!-- 버튼 영역 -->
			<div class="writeBtnArea">
				<button type="submit">등록</button>
				<button type="button" onclick="location.href='/notice'">목록</button>
			</div>
			</form:form>
		</div>	
	</div>
	<%@ include file="../includes/footer.jsp"%>	
</div>
</body>
</html>