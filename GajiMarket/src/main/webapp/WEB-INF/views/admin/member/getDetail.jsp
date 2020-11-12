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
	<%@ include file="../../includes/header.jsp"%>
		<div id="registerArea">
			<table>
				<tr>
					<td>
						<label>회원번호</label><br>
						${member.membernum}
					<td>
				</tr>
				<tr>
					<td>
						<label>이메일</label><br>
						${member.email}
					</td>
				</tr>
				<tr>
					<td>
						<label>비밀번호</label><br>
						${member.password}
					</td>
				</tr>
				<tr>
					<td>
						<label>닉네임</label><br>
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
						<label>가입일자</label><br>
						${member.regdate}
					</td>
				</tr>
				<tr>
					<td>
						<label>주소</label><br>
						${member.address.addressname}
					</td>
				</tr>
			</table>
			
			
			<form action="update/${member.membernum}" method="post">
				<input type="hidden" name="membernum" value="${member.membernum}">
				<label>관리자여부</label><br>
				<select name="isadmin">
					<option value="0" <c:if test="${member.isadmin == 0}">selected</c:if>>일반회원</option>
					<option value="1" <c:if test="${member.isadmin == 1}">selected</c:if>>관리자</option>
				</select>
				<span id="error">${msg}</span>
				<a href="/admin/member/${member.membernum}?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
				<button>수정</button></a>
				<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
				<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
				<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
				<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
			</form>
			
			<div id="buttonArea" style="position: absolute;">

			
			<a href="/admin/member?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
			<button>목록</button></a>
			
			<a href="/admin/member/delete/${member.membernum}"><button>삭제</button></a>
		</div>	
		</div>
	<%@ include file="../../includes/footer.jsp"%>
</body>
</html>