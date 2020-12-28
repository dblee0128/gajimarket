<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="<c:url value="/resources/css/board.css"/>" rel="stylesheet">

<nav class="headerArea">

	<div class="mainLogo">
		<a href="/"><img src="/resources/img/logo_main.jpeg"></a>
	</div>
	
	<c:if test="${isadmin == 1}">
	<div class="mainMenu">
		<ul class="mainUl">
			<li><a href="/board">중고물품</a></li>
			<li><a href="/notice">공지사항</a></li>
			<li><a href="/myInfo">내정보</a></li>
			<li><a href="/admin">관리자</a></li>
			<li><a href="/logout"><img src="/resources/img/logout.png" id="settingIcon"></a></li>
		</ul>
	</div>
	</c:if>
	
	<c:if test="${isadmin == 0}">
	<div class="mainMenu">
		<ul class="mainUl">
			<li><a href="/board">중고물품</a></li>
			<li><a href="/notice">공지사항</a></li>
			<li><a href="/myInfo">내정보</a></li>
			<li><a href="/logout"><img src="/resources/img/logout.png" id="settingIcon"></a></li>
		</ul>
	</div>
	</c:if>

</nav>