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

	<div class="mainArea">
	
		<!-- 코멘트 영역 -->
		<div class="writeCmt" style="width: 40%;">
			<h4>회원정보</h4>
		</div>
		
		<!-- 글 출력 영역 -->
		<div class="writeArea" style="width: 40%;">
			<p>* 비매너 회원, 부적절한 게시물을 올린 회원을 삭제할 수 있습니다.<br>
			   * 관리자/일반회원 권한을 변경할 수 있습니다.</p>
			   
			<table class="membertb">
				<tr>
					<td class="title">회원번호</td>
					<td class="content">${member.membernum}</td>
				</tr>
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
					<td class="content">${member.phone}</td>
				</tr>
				<tr>
					<td class="title">주소</td>
					<td class="content">${member.address.addressname}</td>
				</tr>
				<tr>
					<td class="title">가입일자</td>
					<td class="content"><fmt:formatDate pattern="yyyy-MM-dd" value="${member.regdate}"/></td>
				</tr>
			</table>
			
			<form action="update/${member.membernum}" method="post">
				<input type="hidden" name="membernum" value="${member.membernum}">
				<table class="membertb">
					<tr>
						<td class="title" style="width: 30.2%;">관리자여부</td>
						<td>
							<select name="isadmin" class="memberSelectBox">
								<option value="0" <c:if test="${member.isadmin == 0}">selected</c:if>>일반회원</option>
								<option value="1" <c:if test="${member.isadmin == 1}">selected</c:if>>관리자</option>
							</select>
						</td>
					</tr>
					<tr><td colspan="2" class="errors">${msg}</td></tr>
				
				</table>
				<br>
				<div class="writeBtnArea">
					<a href="/admin/member/${member.membernum}?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
					<button id="updateBtn">수정</button></a>
				
					<a href="/admin/member/delete/${member.membernum}">
					<button type="button" id="deleteBtn">삭제</button></a>
					
					<a href="/admin/member?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
					<button type="button">목록</button></a>
				</div>
				
				<!-- update/${member.membernum} 라는 요청이 들어오면 보내주기 -->
				<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
				<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
				<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
				<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
			</form>
			
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
	
	$("#updateBtn").on("click", function(){
	
		if(confirm("권한을 변경하시겠습니까?") == true){
			alert('권한이 변경되었습니다.');
		} else {
			return false;
		}
	})
})
</script>
</body>
</html>