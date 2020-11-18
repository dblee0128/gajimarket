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
<link href="<c:url value="/resources/css/includes.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrap">
<%@ include file="../../includes/header.jsp"%>
	
	<div class="mainArea">
		<!-- 메인 코멘트 영역 -->
		<div class="maincmt">
			인천광역시 중고물품
			<p>가까운 지역구/군민들과 마음 따뜻한 거래를 경험해보세요</p>
		</div>
		<!-- 검색 영역 -->
		<div class="searchArea">
			<form action="/admin/qna" method="get" class="searchForm">
				<select name="type" class="selectBox">
					<option value="" <c:out value="${pageMaker.cri.type == null? 'selected':''}"/>>선택</option>
					<option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected':''}"/>>제목</option>
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected':''}"/>>내용</option>
					<option value="N" <c:out value="${pageMaker.cri.type eq 'N'? 'selected':''}"/>>작성자</option>
					<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'? 'selected':''}"/>>제목/내용</option>
				</select>
				<input type="text" name="keyword" class="inputSearch" value="${pageMaker.cri.keyword}">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<button type="submit" class="buttonMedium">검색</button>
			</form>
		</div>
		
		<!-- 게시글 리스트 영역 -->
		<div class="listArea">
			<table class="boardtb">
				<tr>
					<th>판매여부</th><th>제목</th><th>가격</th><th>작성자</th><th>작성일</th><th>조회수</th>
				</tr>
				<c:forEach var="board" items="${board}">
				<tr>
					<td class="small">${board.sell}</td>
					<td class="large">
						<a href="board/${board.boardnum}
								?pageNum=<c:out value="${pageMaker.cri.pageNum}"/>
								&amount=<c:out value="${pageMaker.cri.amount}"/>
								&type=<c:out value="${pageMaker.cri.type}"/>
								&keyword=<c:out value="${pageMaker.cri.keyword}"/>" class="link">
								<c:out value="${board.title}"/>
								<b>[${board.replycnt}]</b>
						</a>
					</td>
					<td class="medium">${board.price}</td>
					<td class="small">${board.member.nickname}</td>
					<td class="small"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
					<td class="small">${board.readcnt}</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		
		<!-- 페이징 영역 -->
		<div class="pagingArea">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a href="/admin/board?pageNum=${pageMaker.startPage - 1}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" class="link">이전</a></li>
				</c:if>
				
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li><a href="/admin/board?pageNum=${num}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" class="link">${num}</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next}">
					<li><a href="/admin/board?pageNum=${pageMaker.endPage + 1}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" class="link">다음</a></li>
				</c:if>
			</ul>	
		</div>
	
	</div>
	
	<!-- /admin/board라는 요청이 들어올 때, 각각의 값을 보내준다 -->
	<form action="/admin/board" method="get">
		<input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum}"/>">
		<input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount}"/>">
		<input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type}"/>">
		<input type="hidden" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>">
	</form>
	
<%@ include file="../../includes/footer.jsp"%>
</div>
</body>