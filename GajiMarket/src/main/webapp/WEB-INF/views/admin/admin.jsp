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
<%@ include file="../includes/header.jsp"%>
	
	<div class="mainArea">

		<div class="mainCmt">
			관리자 페이지
			<p>가지마켓 회원 및 운영 현황을 확인하세요</p>
		</div>
		
		<div class="mainMenu">
		
			<div class="menu">
				<div class="title">
					<p class="large">회원 관리</p>
					<p class="small">가지마켓 관리자와 회원을 관리하세요</p>
				</div>
				
				<div class="count">
					<div class="one">
						<p class="cmt"><a href="/admin/member">관리자</a><p>
						<p class="num"><a href="/admin/member">${adminCnt}</a></p>
					</div>
					<div class="two">
						<p class="cmt"><a href="/admin/member">회원</a><p>
						<p class="num"><a href="/admin/member">${memberCnt}</a></p>
					</div>
				</div>
			</div>
			
			<div class="menu">
				<div class="title">
					<p class="large">게시물 관리</p>	
					<p class="small">인천시 전체 중고 물품을 관리하세요</p>
				</div>
				
				<div class="count">
					<div class="two">
						<p class="cmt"><a href="/admin/board">게시물</a><p>
						<p class="num"><a href="/admin/board">${boardCnt}</a></p>
					</div>
				</div>
			</div>
			<br>
			
			<div class="menu">
				<div class="title">
					<p class="large">공지사항 관리</p>	
					<p class="small">공지, 자주 묻는 질문을 등록하세요</p>
				</div>
				
				<div class="count">
					<div class="two">
						<p class="cmt"><a href="/notice">공지사항</a><p>
						<p class="num"><a href="/notice">${noticeCnt}</a></p>
					</div>
				</div>
			</div>
			
			<div class="menu">
				<div class="title">
					<p class="large">문의 내역</p>	
					<p class="small">회원들의 문의에 빠른 답을 해주세요</p>
				</div>
				
			<div class="count">
					<div class="two">
						<p class="cmt"><a href="/admin/qna">1:1문의</a><p>
						<p class="num"><a href="/admin/qna">${qnaCnt}</a></p>
					</div>
				</div>
			</div>
		
		</div>
		
	
	</div>
	
	
<%@ include file="../includes/footer.jsp"%>
</div>
</body>