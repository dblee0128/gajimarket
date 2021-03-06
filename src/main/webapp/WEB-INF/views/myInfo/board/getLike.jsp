<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<link href="<c:url value="/resources/css/board.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrap">
<%@ include file="../../includes/header.jsp"%>
	
	<div class="mainArea">
		<!-- 메인 코멘트 영역 -->
		<div class="maincmt">
			나의 관심 목록
			<p>총 ${likeCount}건의 관심 중고물품</p>
		</div>
		<br>
		
		<!-- 게시글 리스트 영역 -->
		<div class="listArea">
			<table class="boardtb">
				<tr>
					<th>판매여부</th><th>제목</th><th>가격</th>
				</tr>
				<c:forEach var="like" items="${like}">
				<tr>
					<td class="small">${like.board.sell}</td>
					<td class="large">
						<a href="../../board/${like.board.boardnum}
								?pageNum=<c:out value="${pageMaker.cri.pageNum}"/>
								&amount=<c:out value="${pageMaker.cri.amount}"/>
								&type=<c:out value="${pageMaker.cri.type}"/>
								&keyword=<c:out value="${pageMaker.cri.keyword}"/>" class="link">
								<c:out value="${like.board.title}"/>
						</a>
					</td>
					<td class="medium">${like.board.price}</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		
		<!-- 페이징 영역 -->
		<div class="pagingArea">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a href="/myInfo/board/getLike?pageNum=${pageMaker.startPage - 1}" class="link">이전</a></li>
				</c:if>
				
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li><a href="/myInfo/board/getLike?pageNum=${num}" class="link">${num}</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next}">
					<li><a href="/myInfo/board/getLike?pageNum=${pageMaker.endPage + 1}" class="link">다음</a></li>
				</c:if>
			</ul>	
		</div>
	
	</div>
	
	<!-- /board라는 요청이 들어올 때, pageNum, amount 값을 보내준다 -->
	<form action="/board" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	</form>
	
<%@ include file="../../includes/footer.jsp"%>
</div>
</body>