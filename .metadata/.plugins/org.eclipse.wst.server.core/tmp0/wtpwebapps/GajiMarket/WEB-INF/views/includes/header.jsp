<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="<c:url value="/resources/css/includes.css"/>" rel="stylesheet">

<nav class="headerArea">

	<div class="mainLogo">
		<a href="/"><img src="/resources/img/logo_main.jpeg"></a>
	</div>

	<div class="mainMenu">
		<ul class="mainUl">
			<li><a href="/board">중고물품</a></li>
			<li><a href="/notice">공지사항</a></li>
			<li><a href="#"><img src="/resources/img/settings.png"
					id="settingIcon"></a>
				<ul class="subUl">
					<li><a href="/myInfo">내정보</a></li>
					<li><a href="/admin">관리자</a></li>
					<li><a href="/logout">로그아웃</a></li>
				</ul></li>
		</ul>
	</div>

</nav>