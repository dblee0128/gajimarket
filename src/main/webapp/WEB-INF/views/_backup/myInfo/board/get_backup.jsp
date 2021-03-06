<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<link href="<c:url value="/resources/css/board.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
</head>
<body>
<%@ include file="../../../includes/header.jsp"%>
<div id="container">
	<div id="wrap">
		<table id="board_tb">
			<tr>
				<td colspan="3" align="left">
					인천광역시 ${member.address.addressname}
				</td>
				<td colspan="3" align="right">
					<a href="/board/register"><button style="text-align: right;">중고 물품 등록</button></a>
				</td>
			</tr>
			<tr>
				<th>판매여부</th><th>상품명</th><th>가격</th><th>작성자</th><th>작성일</th><th>조회수</th>
			</tr>
			<tr>
			<c:forEach var="board" items="${board}">
			<tr>
				<td class="small">${board.sell}</td>
				<td class="large"><a href="../../board/${board.boardnum}
										  ?pageNum=<c:out value="${pageMaker.cri.pageNum}"/>
										  &amount=<c:out value="${pageMaker.cri.amount}"/>" id="link">
										  <c:out value="${board.title}"/></a>
				<td class="medium">${board.price}</td>
				<td class="small">${board.member.nickname}</td>
				<td class="small">${board.regdate}</td>
				<td class="small">${board.readcnt}</td>
				<td>${board.boardnum}</td>
			</tr>
			</c:forEach>	
		</table>
		
		<!-- 페이징 -->
		<div id="pagingArea">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a href="/myInfo/board/get?pageNum=${pageMaker.startPage - 1}" id="link">이전</a></li>
				</c:if>
				
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li><a href="/myInfo/board/get?pageNum=${num}" id="link">${num}</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next}">
					<li><a href="/myInfo/board/get?pageNum=${pageMaker.endPage + 1}" id="link">다음</a></li>
				</c:if>
			</ul>	
		</div>
		<!-- /board라는 요청이 들어올 때, pageNum, amount 값을 보내준다 -->
		<form action="/board" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		</form>
		
	</div>	
</div>	
<%@ include file="../../../includes/footer.jsp"%>
</body>
</html>