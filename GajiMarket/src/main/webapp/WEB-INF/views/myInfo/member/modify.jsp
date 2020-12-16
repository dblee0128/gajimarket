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
<link href="<c:url value="/resources/css/member.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrap">
<%@ include file="../../includes/header.jsp"%>

	<div class="mainArea" style="margin-top: -17%;">
	
		<!-- 코멘트 영역 -->
		<div class="writeCmt" style="width: 40%;">
			<h4>나의 정보</h4>
		</div>
		
		<!-- 글 출력 영역 -->
		<div class="writeArea" style="width: 40%;">
			<p>* 이메일, 닉네임은 수정할 수 없습니다.</p>
			
			<form:form action="modify" method="post" modelAttribute="member">
				<input type="hidden" name="membernum" value="${membernum}">
				<table class="membertb">
					<tr>
						<td class="title">이메일</td>
						<td class="content">${member.email}</td>
					</tr>
					
					<tr>
						<td class="title">닉네임</td>
						<td class="content">${member.nickname}</td>
					</tr>
					
					<tr>
						<td class="title">핸드폰 번호</td>
						<td>
						<form:input path="phone" placeholder="- (하이픈) 제외하고 입력" class="memberInput"/>
						<form:errors path="phone" class="errors"/>
						</td>
					</tr>
					<tr><td colspan="2" class="errors">${msg1}</td></tr>
					
					<tr>
						<td class="title">주소</td>
						<td>
							<select name="addressnum" class="memberSelectBox">
								<option value="0">선택</option>
								<option value="1" <c:if test="${member.addressnum == 1}">selected</c:if>>중구</option>
								<option value="2" <c:if test="${member.addressnum == 2}">selected</c:if>>동구</option>
								<option value="3" <c:if test="${member.addressnum == 3}">selected</c:if>>미추홀구</option>
								<option value="4" <c:if test="${member.addressnum == 4}">selected</c:if>>연수구</option>
								<option value="5" <c:if test="${member.addressnum == 5}">selected</c:if>>남동구</option>
								<option value="6" <c:if test="${member.addressnum == 6}">selected</c:if>>부평구</option>
								<option value="7" <c:if test="${member.addressnum == 7}">selected</c:if>>계양구</option>
								<option value="8" <c:if test="${member.addressnum == 8}">selected</c:if>>서구</option>
								<option value="9" <c:if test="${member.addressnum == 9}">selected</c:if>>강화군</option>
								<option value="10" <c:if test="${member.addressnum == 10}">selected</c:if>>옹진군</option>
							</select>
						</td>
					</tr>
					<tr><td colspan="2" class="errors" style="border-style: none;">${msg2}</td></tr>
				</table>
				<br>
				
				<div class="writeBtnArea">
					<button type="submit" id="updateBtn">수정</button>
					<button type="reset">취소</button>
				</div>
				
			</form:form>
			
		</div>
		
	</div>
	<%@ include file="../../includes/footer.jsp"%>		
</div>

<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
<script>
$(document).ready(function(){
	$("#deleteBtn").on("click", function(){
	
		if(confirm("회원을 정말 삭제하시겠습니까?") == true){
			alert('회원이 삭제되었습니다.');
		} else {
			return false;
		}
	})
})
</script>
</body>
</html>