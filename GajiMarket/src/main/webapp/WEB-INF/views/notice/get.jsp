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
<%@ include file="../includes/header.jsp"%>
	
	<div class="mainArea">
		<!-- 메인 코멘트 영역 -->
		<div class="maincmt">
			공지사항
			<p>가지마켓을 이용하기 전에 꼭 읽어주세요</p>
		</div>
		
		<!-- 검색 영역 -->
		<div class="searchArea">
			<form action="/notice" method="get" class="searchForm">
				<select name="type" class="selectBox">
					<option value="" <c:out value="${pageMaker.cri.type == null? 'selected':''}"/>>선택</option>
					<option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected':''}"/>>제목</option>
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected':''}"/>>내용</option>
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
					<th>제목</th><th>작성일자</th>
				</tr>
				<c:forEach var="notice" items="${notice}">
				<tr>
					<td>
						<a href="notice/${notice.noticenum}
								?pageNum=<c:out value="${pageMaker.cri.pageNum}"/>
								&amount=<c:out value="${pageMaker.cri.amount}"/>
								&type=<c:out value="${pageMaker.cri.type}"/>
								&keyword=<c:out value="${pageMaker.cri.keyword}"/>" class="link">
								<c:out value="${notice.title}"/>
						</a>
					</td>
					<td class="medium"><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}"/></td>
				</tr>
				</c:forEach>
			</table>
			
			<!-- 공지 등록 버튼은 관리자에게만 -->
			<c:if test="${member.isadmin == 1}">
			<div class="buttonArea">
				<a href="/notice/register"><button class="buttonMedium">공지 등록</button></a>
			</div>
			</c:if>
		</div>
		
		<!-- 페이징 영역 -->
		<div class="pagingArea">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a href="/notice?pageNum=${pageMaker.startPage - 1}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" class="link">이전</a></li>
				</c:if>
				
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li><a href="/notice?pageNum=${num}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" class="link">${num}</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next}">
					<li><a href="/notice?pageNum=${pageMaker.endPage + 1}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" class="link">다음</a></li>
				</c:if>
			</ul>	
		</div>
	
	</div>
	
	<!-- /notice라는 요청이 들어올 때, 각각의 값을 보내준다 -->
	<form action="/notice" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		<input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type}"/>">
		<input type="hidden" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>">
	</form>
	
<%@ include file="../includes/footer.jsp"%>
</div>
</body>
</html>