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
<style>
.errors {text-align: left;}
</style>
</head>
<body>
<div id="wrap">
<%@ include file="../includes/header_logo.jsp"%>

	<div class="mainArea">
	
		<!-- 코멘트 영역 -->
		<div class="writeCmt" style="width: 30%;">
			<h4>회원가입</h4>
		</div><br>
		
		<!-- 글 출력 영역 -->
		<div class="writeArea" style="width: 30%;">
			
			<form:form action="register" method="post" modelAttribute="registerCmd">
				<table class="membertb">
					<tr><td class="title">이메일</td></tr>
					<tr>
						<td style="margin:0; padding:0;">
							<form:input path="email" placeholder="abc@naver.com" class="memberInput"/>
						</td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="email"/></td></tr>
					<tr><td colspan="2" class="errors">${msg1}</td></tr>
					
					<tr><td class="title">비밀번호</td></tr>
					<tr>
						<td>
							<label>8자 - 16자의 영문자 + 숫자 조합</label><br>
							<form:password path="password" placeholder="비밀번호" class="memberInput"/>
							
						</td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="password"/></td></tr>
					
					<tr><td class="title">비밀번호 확인</td></tr>
					<tr>
						<td>
							<form:password path="confirmPassword" placeholder="비밀번호 확인" class="memberInput"/>
						</td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="confirmPassword"/></td></tr>
					<tr><td colspan="2" class="errors">${msg2}</td></tr>
					
					<tr><td class="title">닉네임</td></tr>
					<tr>
						<td>
							<label>2자 - 8자의 영문자 / 한글 / 숫자</label><br>
							<form:input path="nickname" placeholder="닉네임" class="memberInput"/>
						</td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="nickname"/></td></tr>
					<tr><td colspan="2" class="errors">${msg3}</td></tr>
					
					<tr><td class="title">핸드폰 번호</td></tr>
					<tr>
						<td>
							<label>- (하이픈) 제외하고 입력</label><br>
							<form:input path="phone" placeholder="핸드폰 번호" class="memberInput"/>
						</td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="phone"/></td></tr>
					<tr><td colspan="2" class="errors">${msg4}</td></tr>
					
					<tr><td class="title">주소</td></tr>
					<tr>
						<td>
							<form:select path="addressnum" class="memberSelectBox">
								<form:option value="0">선택</form:option>
								<form:option value="1">중구</form:option>
								<form:option value="2">동구</form:option>
								<form:option value="3">미추홀구</form:option>
								<form:option value="4">연수구</form:option>
								<form:option value="5">남동구</form:option>
								<form:option value="6">부평구</form:option>
								<form:option value="7">계양구</form:option>
								<form:option value="8">서구</form:option>
								<form:option value="9">강화군</form:option>
								<form:option value="10">옹진군</form:option>
							</form:select>
						</td>
					</tr>
					<tr><td colspan="2" class="errors">${msg5}</td></tr>
				</table><br>
				
				<div class="writeBtnArea">
					<button type="submit" class="bigBtn">회원가입</button>
				</div><br>
				
			</form:form>
			
		</div>
	<%@ include file="../includes/footer.jsp"%>		
	</div>
</div>
</body>
</html>