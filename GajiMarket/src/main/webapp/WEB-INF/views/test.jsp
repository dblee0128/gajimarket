<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<%@ include file="includes/header.jsp"%>
	
	<div class="mainArea">
	
		<!-- 코멘트 영역 -->
		<div class="writeCmt">
			<h4>중고물품 등록하기</h4>
		</div>
		
		<!-- 글쓰기 영역 -->
		<div class="writeArea">
			<p>* 물품을 등록하기 전에 공지사항을 참고해주세요.</p>
			<form:form action="register" method="post" modelAttribute="board">
				<input type="hidden" name="membernum" value="${member.membernum}">
				
				<table class="writetb">
					<tr>
						<td class="cmt">제목</td>	
						<td><form:input path="title" placeholder="제목을 입력하세요." class="writeInput"/></td>
					</tr>
					<tr><td><form:errors path="title" class="errors"/></td></tr>
					
					<tr>
						<td class="cmt">가격</td>
						<td><form:input path="price" placeholder="가격을 입력하세요." class="writeInput"/></td>
					</tr>
					<tr><td><form:errors path="price" class="errors"/></td></tr>
					
					
					<tr>
						<td class="cmt">내용</td>
						<td>
							<form:textarea path="content" cols="80" rows="20" placeholder="내용을 입력하세요." class="writeTextArea"/>
						</td>
					</tr>
					<tr><td><form:errors path="content" class="errors"/></td></tr>
					
					<tr>
						<td class="cmt">카테고리</td>
						<td>	
							<form:select path="categorynum">
								<form:option value="0">선택</form:option>
								<form:option value="1">디지털</form:option>
								<form:option value="2">가구</form:option>
								<form:option value="3">생활용품</form:option>
								<form:option value="4">스포츠</form:option>
								<form:option value="5">의류/잡화</form:option>
								<form:option value="6">미용</form:option>
								<form:option value="7">애완동물</form:option>
								<form:option value="8">도서</form:option>
								<form:option value="9">기타</form:option>
							</form:select>
						</td>
					</tr>
					<tr><td class="errors">${msg}</td></tr>
					
				</table>
				
				<!-- 버튼 영역 -->
				<div class="writeBtnArea">
					<button type="submit">등록</button>
					<button type="button" onclick="location.href='/board'">목록</button>
				</div>
				
			</form:form>
		</div>
		
		<!-- 첨부 영역 -->
		<div class="uploadArea">
			<div class="uploadForm">
				<label class="cmt">파일첨부</label>
				<input type="file" name="uploadFile" class="uploadBtn" multiple>
			</div>
			<div class="uploadResult">
				<ul>
				 	<li>
				 	<div>
				 		<span>파일명</span>
				 		<button class="closeBtn">X</button><br>
				 		<img src="">
				 	</div>
				 	</li>
				</ul>
			</div>
		</div>
		
		
	
	<%@ include file="includes/footer.jsp"%>
	</div>
</div>
</body>