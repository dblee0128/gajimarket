<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<c:url value="/resources/css/includes.css"/>" rel="stylesheet">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="menuArea">
	<ul id="menu">
		<li class="menu"><a href="/" id="top">가지마켓</a></li> <!-- 회원: /board(게시판 메인 페이지로 이동), 비회원: /(로그인 페이지로 이동) -->
		<li class="menu"><a href="/notice" id="top">공지사항</a></li>
		<li class="menu"><a href="/myInfo" id="top">${nickname}</a></li> <!-- 내 정보 메인 페이지로 이동 -->
		<c:if test="${isadmin == 1}">
		<li class="menu"><a href="/admin" id="top">관리자페이지</a></li> <!-- 관리자 페이지로 이동 -->
		</c:if>
		<li class="menu"><a href="/logout" id="top">로그아웃</a></li> <!-- 로그아웃 실행 -->
	</ul>
</div>
<br>