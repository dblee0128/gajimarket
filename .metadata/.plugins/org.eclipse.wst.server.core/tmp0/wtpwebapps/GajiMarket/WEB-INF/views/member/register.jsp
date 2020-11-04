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
	<%@ include file="../includes/header.jsp"%>
	<h3 align="center">가지마켓에서 중고거래를 원하시면<br> 간단한 회원가입을 진행해주세요.</h3>
	<div id="registerArea">
		<form:form action="register" method="post" modelAttribute="registerCmd">
			<table>
				<tr>
					<td>
						<label>이메일</label><br>
						<form:input path="email" placeholder="abc@naver.com"/>
						<form:errors path="email" id="error"/>
					</td>
				</tr>
				<tr><td id="error">${msg1}</td></tr>
				<tr>
					<td>
						<label>비밀번호</label><br>
						<label>8자 - 16자의 영문자 + 숫자 조합</label>
						<form:password path="password" placeholder="비밀번호"/>
						<form:errors path="password" id="error"/>
					</td>
				</tr>
				<tr>
					<td>
						<label>비밀번호 확인</label><br>
						<form:password path="confirmPassword" placeholder="비밀번호 확인"/>
						<form:errors path="confirmPassword" id="error"/>
					</td>
				</tr>
				<tr><td id="error">${msg2}</td></tr>
				<tr>
					<td>
						<label>별명</label><br>
						<label>2자 - 8자의 영문자 / 한글 / 숫자</label><br>
						<form:input path="nickname" placeholder="별명"/>
						<form:errors path="nickname" id="error"/>
					</td>
				</tr>
				<tr><td id="error">${msg3}</td></tr>
				<tr>
					<td>
						<label>핸드폰 번호</label><br>
						<label>- (하이픈) 제외하고 입력</label><br>
						<form:input path="phone" placeholder="핸드폰 번호"/>
						<form:errors path="phone" id="error"/>
					</td>
				</tr>
				<tr><td id="error">${msg4}</td></tr>
				<tr>
					<td>
						<label>주소</label><br>
						<form:select path="addressnum">
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
				<tr><td id="error">${msg5}</td></tr>
				<tr>
					<td>
						<input type="submit" value="확인">
					</td>
				</tr>
			</table>
			
		</form:form>
	</div>
	<%@ include file="../includes/footer.jsp"%>
</body>
</html>