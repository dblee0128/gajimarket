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
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
</head>
<body>
<%@ include file="../../../includes/header.jsp"%>
<div id="container">
	<div id="wrap">
		<table id="board_tb">
			<tr>
				<th>판매여부</th><th>상품명</th><th>가격</th><th>작성자</th><th>작성일</th><th>조회수</th>
			</tr>
			<tr>
			<c:forEach var="board" items="${board}">
			<tr>
				<td class="small">${board.sell}</td>
				<td class="large">
					<a href="board/${board.boardnum}
							?pageNum=<c:out value="${pageMaker.cri.pageNum}"/>
							&amount=<c:out value="${pageMaker.cri.amount}"/>
							&type=<c:out value="${pageMaker.cri.type}"/>
							&keyword=<c:out value="${pageMaker.cri.keyword}"/>" id="link">
							<c:out value="${board.title}"/>
							<b>[${board.replycnt}]</b></a>
				</td>
				<td class="medium">${board.price}</td>
				<td class="small">${board.member.nickname}</td>
				<td class="small">${board.regdate}</td>
				<td class="small">${board.readcnt}</td>
				<td>${board.likecnt}</td>
				<td>${board.boardnum}</td>
			</tr>
			</c:forEach>	
		</table>
		
		<!-- 검색 -->
		<div id="searchArea">
			<form action="/admin/board" method="get">
				<select name="type">
					<option value="" <c:out value="${pageMaker.cri.type == null? 'selected':''}"/>>선택</option>
					<option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected':''}"/>>제목</option>
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected':''}"/>>내용</option>
					<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'? 'selected':''}"/>>제목/내용</option>
					<option value="N" <c:out value="${pageMaker.cri.type eq 'N'? 'selected':''}"/>>작성자</option>
				</select>			
				<input type="text" name="keyword" value="${pageMaker.cri.keyword}">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<button type="submit">검색</button>
			</form>
		</div>
		
		
		<!-- 페이징 -->
		
		<div id="pagingArea">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a href="board?pageNum=${pageMaker.startPage - 1}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" id="link">이전</a></li>
				</c:if>
				
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li><a href="board?pageNum=${num}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" id="link">${num}</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next}">
					<li><a href="board?pageNum=${pageMaker.endPage + 1}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" id="link">다음</a></li>
				</c:if>
			</ul>	
		</div>
		
		<!-- /board라는 요청이 들어올 때, 각각의 값을 보내준다 -->
		<form action="admin/board" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type}"/>">
			<input type="hidden" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>">
		</form>

	</div>	
</div>	
<%@ include file="../../../includes/footer.jsp"%>
</body>
</html>