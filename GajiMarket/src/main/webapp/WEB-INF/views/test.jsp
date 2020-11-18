<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<link href="<c:url value="/resources/css/mypage.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrap">
<%@ include file="includes/header.jsp"%>
	
	<div class="mainArea">

		<div class="mainCmt">
			마이페이지
			<p>내 활동 정보를 확인하고 관리하세요</p>
		</div>
		
		<div class="mainMenu">
		
			<div class="menu">
				<div class="title">
					<p class="large">판매 내역</p>	
					<p class="small">나의 판매 내역을 확인해보세요</p>
				</div>
				
				<div class="count">
					<div class="one">
						<p class="cmt">판매중<p>
						<p class="num">8</p>
					</div>
					<div class="two">
						<p class="cmt">판매완료<p>
						<p class="num">2</p>
					</div>
				</div>
			</div>
			
			<div class="menu">
				<div class="title">
					<p class="large">관심 목록</p>	
					<p class="small">나의 관심 목록을 확인해보세요</p>
				</div>
				
				<div class="count">
					<div class="two">
						<p class="cmt">관심목록<p>
						<p class="num">2</p>
					</div>
				</div>
			</div>
			
			<div class="menu">
				<div class="title">
					<p class="large">문의 내역</p>	
					<p class="small">나의 문의 내역을 확인해보세요</p>
				</div>
				
				<div class="count">
					<div class="two">
						<p class="cmt">문의내역<p>
						<p class="num">1</p>
					</div>
				</div>
			</div>
			
			<div class="menu">
				<div class="title">
					<p class="large">나의 정보</p>	
					<p class="small">나의 정보를 확인하고 자유롭게 수정하세요</p>
				</div>
				
				<div class="count">
					<div class="two">
						<p class="normal">나의정보</p>
					</div>
				</div>
			</div>
			
			<div class="menu">
				<div class="title">
					<p class="large">비밀번호 변경</p>	
					<p class="small">주기적으로 비밀번호를 변경해주세요</p>
				</div>
				
				<div class="count">
					<div class="two">
						<p class="normal">비밀번호변경</p>
					</div>
				</div>
			</div>
			
			<div class="menu">
				<div class="title">
					<p class="large">회원 탈퇴</p>	
					<p class="small">가지마켓을 이용하고 싶지 않아요</p>
				</div>
				
				<div class="count">
					<div class="two">
						<p class="normal">회원탈퇴</p>
					</div>
				</div>
			</div>
		
		</div>
		
	
	</div>
	
	
<%@ include file="includes/footer.jsp"%>
</div>
</body>