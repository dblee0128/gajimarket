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
	<%@ include file="../../../includes/header.jsp"%>
	<h3 align="center">나의 정보를 확인하고 자유롭게 수정하세요.</h3>
	<div id="registerArea">
		<form:form action="modify" method="post" modelAttribute="member">
			<table>
				<tr>
					<td>
						<label>이메일</label><br>
						<label>이메일은 수정할 수 없어요.</label>
						<form:input path="email" value="${member.email}" readonly="true"/> <!-- form 태그는 readonly="true"로 해야됨 -->
					</td>
				</tr>
				<tr>
					<td>
						<label>별명</label><br>
						<label>별명은 수정할 수 없어요.</label><br>
						<form:input path="nickname" value="${member.nickname}" readonly="true"/>
					</td>
				</tr>
				<tr>
					<td>
						<label>핸드폰 번호</label><br>
						<label>- (하이픈) 제외하고 입력</label><br>
						<form:input path="phone" value="${member.phone}"/>
						<form:errors path="phone" id="error"/>
					</td>
				</tr>
				<tr><td id="error">${msg1}</td></tr>
				<tr>
					<td>
						<label>주소</label><br>
						<select name="addressnum">
							<option value="0">선택</option>
							<option value="1" <c:if test="${member.addressnum == 1}">selected</c:if>>중구</option>
							<option value="2" <c:if test="${member.addressnum == 2}">selected</c:if>>동구</option>
							<option value="3" <c:if test="${member.addressnum == 3}">selected</c:if>>미추홀구</option>
							<option value="4" <c:if test="${member.addressnum == 4}">selected</c:if>>연수구</option>
							<option value="5" <c:if test="${member.addressnum == 5}">selected</c:if>>남동구</option>
							<option value="6" <c:if test="${member.addressnum == 6}">selected</c:if>>부평구</option>
							<option value="7" <c:if test="${member.addressnum == 7}">selected</c:if>>계양구</option>
							<option value="8" <c:if test="${member.addressnum == 8}">selected</c:if>>서구</option>
							<option value="9" <c:if test="${member.addressnum == 9}">selected</c:if>>강화군</option>
							<option value="10" <c:if test="${member.addressnum == 10}">selected</c:if>>옹진군</option>
						</select>
					</td>
				</tr>
				<tr><td id="error">${msg2}</td></tr>
				<tr>
					<td>
						<input type="submit" value="수정">
						<input type="reset" value="초기화">
					</td>
				</tr>
			</table>
		</form:form>
	</div>
	<%@ include file="../../../includes/footer.jsp"%>
</body>
</html>