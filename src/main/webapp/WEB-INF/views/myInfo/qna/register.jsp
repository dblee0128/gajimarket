<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<link href="<c:url value="/resources/css/board.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrap">
<%@ include file="../../includes/header.jsp"%>

	<div class="mainArea">
	
		<!-- 코멘트 영역 -->
		<div class="writeCmt">
			<h4>1:1 문의하기</h4>
		</div>
		
		<!-- 글 출력 영역 -->
		<div class="writeArea">
		
			<p>* 1:1 문의를 등록하기 전에 공지사항을 참고해주세요.<br>
			   * 상담 시간 | 평일 10:00 - 17:00</p>
			   
			<form:form action="register" method="post" modelAttribute="qna">
				<input type="hidden" name="membernum" value="${member.membernum}">
			
				<table class="writetb">
					<tr>
						<td class="cmt">문의유형</td>
						<td>
							<form:select path="typenum" class="writeSelectBox">
								<form:option value="0">선택</form:option>
								<form:option value="1">거래 환불 / 분쟁 및 사기 신고</form:option>
								<form:option value="2">비매너 회원 신고</form:option>
								<form:option value="3">계정 문의</form:option>
								<form:option value="4">게시글 문의</form:option>
								<form:option value="5">기타 문의</form:option>
								<form:option value="6">오류 / 개선 / 제안</form:option>
							</form:select>
						</td>
					</tr>
					<tr><td colspan="2" class="errors">${msg}</td></tr>
					
					<tr>
						<td class="cmt">제목</td>
						<td><form:input path="title" placeholder="제목을 입력하세요." class="writeInput"/></td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="title"/></td></tr>
					
					<tr>
						<td class="cmt">내용</td>
						<td><form:textarea path="content" cols="80" rows="20" placeholder="내용을 입력하세요." class="writeTextArea"/></td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="content"/></td></tr>
				</table>
					
			<!-- 버튼 영역 -->
			<div class="writeBtnArea">
				<button type="submit">등록</button>
				<button type="button" onclick="location.href='/myInfo/qna'">목록</button>
			</div>
			</form:form>
		</div>	
	</div>
	<%@ include file="../../includes/footer.jsp"%>	
</div>
</body>
</html>