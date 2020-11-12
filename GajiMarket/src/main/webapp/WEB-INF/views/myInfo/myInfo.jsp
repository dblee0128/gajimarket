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
	<h3 align="center">가지마켓에서의<br>활동 내역 및 회원 정보를 관리하세요.</h3>
	<table>
		<tr>
			<td><a href="/myInfo/qna" style="color: black;"><button>문의 내역</button></a></td>
		</tr>
		<tr>
			<td><a href="/myInfo/board/get" style="color: black;"><button>판매 내역</button></a></td>
		</tr>
		<tr>
			<td><a href="/myInfo/board/getLike" style="color: black;"><button>관심 목록</button></a></td>
		</tr>
		<tr>
			<td><a href="/myInfo/member/get" style="color: black;"><button>나의 정보</button></a></td>
		</tr>
		<tr>
			<td><a href="/myInfo/member/modify" style="color: black;"><button>정보 수정</button></a></td>
		</tr>
		<tr>
			<td><a href="/myInfo/member/modifyPw" style="color: black;"><button>비밀번호 변경</button></a></td>
		</tr>
		<tr>
			<td><a href="/myInfo/member/delete" style="color: black;"><button>회원 탈퇴</button></a></td>
		</tr>
	</table>
	<%@ include file="../includes/footer.jsp"%>
</body>
</html>