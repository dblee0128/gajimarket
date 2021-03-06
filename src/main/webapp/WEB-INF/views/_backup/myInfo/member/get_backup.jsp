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
	<h3 align="center">나의 정보를 확인하고 수정하세요.</h3>
		<div id="registerArea">
			<table>
				<tr>
					<td>
						<label>이메일</label><br>
						${member.email}
					<td>
				</tr>
				<tr>
					<td>
						<label>별명</label><br>
						${member.nickname}
					</td>
				</tr>
				<tr>
					<td>
						<label>핸드폰 번호</label><br>
						${member.phone}
					</td>
				</tr>
				<tr>
					<td>
						<label>주소</label><br>
						${member.address.addressname}
					</td>
				</tr>
			</table>
			
		</div>
	<%@ include file="../../../includes/footer.jsp"%>
</body>
</html>