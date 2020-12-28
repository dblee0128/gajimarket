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
				<th>회원번호</th><th>이메일</th><th>닉네임</th><th>주소</th><th>관리자여부</th>
			</tr>
			<tr>
			<c:forEach var="member" items="${member}">
			<tr>
				<td class="small">${member.membernum}</td>
				<td class="large">
					<a href="member/${member.membernum}
							?pageNum=<c:out value="${pageMaker.cri.pageNum}"/>
							&amount=<c:out value="${pageMaker.cri.amount}"/>
							&type=<c:out value="${pageMaker.cri.type}"/>
							&keyword=<c:out value="${pageMaker.cri.keyword}"/>" id="link">
							<c:out value="${member.email}"/></a>
				</td>
				<td class="medium">${member.nickname}</td>
				<td class="small">${member.address.addressname}</td>
				<td class="small">${member.isadmin}</td>
			</tr>
			</c:forEach>	
		</table>
		
		<!-- 검색 -->
		<div id="searchArea">
			<form action="member" method="get">
				<select name="type">
					<option value="" <c:out value="${pageMaker.cri.type == null? 'selected':''}"/>>선택</option>
					<option value="E" <c:out value="${pageMaker.cri.type eq 'E'? 'selected':''}"/>>이메일</option>
					<option value="N" <c:out value="${pageMaker.cri.type eq 'N'? 'selected':''}"/>>닉네임</option>
					<option value="A" <c:out value="${pageMaker.cri.type eq 'A'? 'selected':''}"/>>주소</option>
					<option value="ENA" <c:out value="${pageMaker.cri.type eq 'ENA'? 'selected':''}"/>>이메일/닉네임/주소</option>
					<option value="I" <c:out value="${pageMaker.cri.type eq 'I'? 'selected':''}"/>>관리자</option>
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
					<li><a href="/admin/member?pageNum=${pageMaker.startPage - 1}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" id="link">이전</a></li>
				</c:if>
				
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li><a href="/admin/member?pageNum=${num}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" id="link">${num}</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next}">
					<li><a href="/admin/member?pageNum=${pageMaker.endPage + 1}
								&type=${pageMaker.cri.type}
								&keyword=${pageMaker.cri.keyword}" id="link">다음</a></li>
				</c:if>
			</ul>	
		</div>
		<!-- /admin/member라는 요청이 들어올 때, 각각의 값을 보내준다 -->
		<form action="/admin/member" method="get">
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