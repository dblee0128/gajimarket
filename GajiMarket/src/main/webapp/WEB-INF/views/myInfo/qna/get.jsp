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
			1:1 문의
			<p>가지마켓 이용 시 궁금한 사항에 대해 글을 남겨주세요</p>
		</div><br>
		
		<!-- 게시글 리스트 영역 -->
		<div class="listArea">
			<table class="boardtb">
				<tr>
					<th>문의유형</th><th>제목</th><th>작성일자</th>
				</tr>
				<c:forEach var="qna" items="${qna}">
				<tr>
					<td class="medium">${qna.type.typename}</td>
					<td>
						<a href="qna/${qna.qnanum}" class="link">${qna.title}<b> [<c:out value="${qna.replycnt}"/>]</b></a>
					</td>
					<td class="medium"><fmt:formatDate pattern="yyyy-MM-dd" value="${qna.regdate}"/></td>
				</tr>
				</c:forEach>
			</table>
			
			<div class="buttonArea">
				<a href="qna/register"><button class="buttonMedium">1:1 문의하기</button></a>
			</div>
		</div>
	
	</div>

<%@ include file="../../includes/footer.jsp"%>
</div>
</body>
</html>