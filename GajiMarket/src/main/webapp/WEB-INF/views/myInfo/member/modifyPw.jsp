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
<%@ include file="../../includes/header.jsp"%>

	<div class="mainArea" style="margin-top: -17%;">
	
		<!-- 코멘트 영역 -->
		<div class="writeCmt" style="width: 40%;">
			<h4>비밀번호 수정</h4>
		</div>
		
		<!-- 글 출력 영역 -->
		<div class="writeArea" style="width: 40%;">	
			<p>* 비밀번호는 주기적으로 변경해주세요.</p>
			
			<form:form action="modifyPw" method="post" modelAttribute="changePwCmd">
				<input type="hidden" name="email" value="${member.email}">
				
				<table class="membertb">
					<tr>
						<td class="title">현재 비밀번호</td>
						<td class="content">
							<form:password path="currentPassword" placeholder="현재 비밀번호" class="memberInput"/>
							<form:errors path="currentPassword" class="errors"/>
						</td>
					</tr>
					<tr><td colspan="2" class="errors">${msg1}</td></tr>
					
					<tr>
						<td class="title" style="width:35%;">변경할 비밀번호</td>
						<td class="content">
							<form:password path="password" placeholder="8-16자 영문자 + 숫자" class="memberInput"/>
							<form:errors path="password" class="errors"/>
						</td>
					</tr>
					
					<tr>
						<td class="title">변경할 비밀번호 확인</td>
						<td class="content">
							<form:password path="confirmPassword" placeholder="8-16자 영문자 + 숫자" class="memberInput"/>
							<form:errors path="confirmPassword" class="errors"/>
						</td>
					</tr>
					<tr><td colspan="2" class="errors">${msg2}</td></tr>
				</table>
				<br>
				
				<div class="writeBtnArea">
					<button type="submit">수정</button>
					<button type="reset">취소</button>
				</div>
				
			</form:form>
			
		</div>
		
	</div>
	<%@ include file="../../includes/footer.jsp"%>		
</div>
</body>
</html>