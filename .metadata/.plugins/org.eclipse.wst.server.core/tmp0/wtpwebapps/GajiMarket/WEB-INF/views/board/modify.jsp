<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>
<link href="<c:url value="/resources/css/board.css"/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
</head>
<body>
<%@ include file="../includes/header.jsp"%>
<div id="container">
	<div id="wrap">
		<form:form action="${board.boardnum}" method="post" modelAttribute="board">
		<input type="hidden" name="membernum" value="${board.member.membernum}">
		<input type="hidden" name="boardnum" value="${board.boardnum}">	
			<table id="board_tb" style="text-align: left;">
				<tr>
					<td>
						<label>판매여부</label>
						<select name="sell">
							<option value="판매중" <c:if test="${board.sell eq '판매중'}">selected</c:if>>판매중</option>
							<option value="판매완료" <c:if test="${board.sell eq '판매완료'}">selected</c:if>>판매완료</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<label>제목</label>
						<form:input path="title" placeholder="제목" value="${board.title}"/>
					</td>
				</tr>
				<tr><td><form:errors path="title" id="error"/></td></tr>
				<tr>
					<td>
						<label>가격</label>
						<form:input path="price" placeholder="가격" value="${board.price}"/>
					</td>
				</tr>
				<tr>
					<td><form:errors path="price" id="error"/></td>
				</tr>
				<tr>
					<td>
						<label>내용</label>
						<form:textarea path="content" cols="100" rows="20" value="${board.content}" placeholder="내용"/>
					</td>
				</tr>
				<tr>
					<td><form:errors path="content" id="error"/></td>
				</tr>
				<tr>
					<td>
						<label>카테고리</label>
						<select name="categorynum">
							<option value="0">선택</option>
							<option value="1" <c:if test="${board.category.categorynum == 1}">selected</c:if>>디지털</option>
							<option value="2" <c:if test="${board.category.categorynum == 2}">selected</c:if>>가구</option>
							<option value="3" <c:if test="${board.category.categorynum == 3}">selected</c:if>>생활용품</option>
							<option value="4" <c:if test="${board.category.categorynum == 4}">selected</c:if>>스포츠</option>
							<option value="5" <c:if test="${board.category.categorynum == 5}">selected</c:if>>의류/잡화</option>
							<option value="6" <c:if test="${board.category.categorynum == 6}">selected</c:if>>미용</option>
							<option value="7" <c:if test="${board.category.categorynum == 7}">selected</c:if>>애완동물</option>
							<option value="8" <c:if test="${board.category.categorynum == 8}">selected</c:if>>도서</option>
							<option value="9" <c:if test="${board.category.categorynum == 9}">selected</c:if>>기타</option>
						</select>
					</td>
				</tr>
				<tr><td id="error">${msg}</td></tr>
			</table>
			
			<a href="/board/modify/${board.boardnum}?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
			<button type="submit" data-oper='modify'>수정</button></a>
			
			<a href="/board?pageNum=${cri.pageNum}&type=${cri.type}&keyword=${cri.keyword}">
			<button>취소</button></a>
			
			<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
			<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
			<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
			<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
		</form:form>
		<div id="buttonArea">
			<a href="/board?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
			<button type="submit" data-oper='list'>목록</button></a>
		</div>
	</div>	
	
	
	
	<!-- 이미지 출력 부분 -->
	<div class="bigPictureWrapper">
		<div class="bigPicture">
		<!-- 여기에 출력 -->
		</div>
	</div>
	
	<!-- 이미지 첨부 부분 -->
	<label>파일첨부</label>
	<div class="uploadForm">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<!-- 첨부 파일 이름 출력 -->
	<div class="uploadResult">
		<ul>
		<!-- 여기에 출력 -->
		</ul>
	</div>
</div>	

<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
<script>
$(document).ready(function(){
	(function(){
		var boardnum = '<c:out value="${board.boardnum}"/>';
		
		$.getJSON("/board/getImgList", {boardnum: boardnum}, function(arr){
			console.log(arr);
			
			var str = "";
			
			$(arr).each(function(i, img){
					var fileCallPath = encodeURIComponent(img.uploadpath + "/s_" + img.uuid + "_" + img.filename);
					
					str += "<li data-path='" + img.uploadpath + "' data-uuid='" + img.uuid + "' data-filename = '" + img.filename + "' data-type='" + img.filetype + "'><div>";
					str += "<span> " + img.filename + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image'>X</button><br>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str += "</li>";
				
			});
			
			$(".uploadResult ul").html(str);
		});
	})();
});

$(".uploadResult").on("click", "button", function(e){
	console.log("delete file");
	
	if(confirm("해당 이미지를 지우시겠습니까?")){
		var targetLi = $(this).closest("li");
		targetLi.remove();
	}
	
});
</script>
<script>
$(document).ready(function(){
	
	// 실제 전송 넘기기
	var formObj = $("form");
	
	$('button').on("click", function(e){
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log("operation" + operation);
		
		if(operation === 'list') {
			formObj.attr("action", "/board").attr("method","get");
		      
		      var pageNumTag = $("input[name='pageNum']").clone();
		      var amountTag = $("input[name='amount']").clone();
		      var keywordTag = $("input[name='keyword']").clone();
		      var typeTag = $("input[name='type']").clone();      
		      
		      formObj.empty();
		      
		      formObj.append(pageNumTag);
		      formObj.append(amountTag);
		      formObj.append(keywordTag);
		      formObj.append(typeTag);	  
		} else if(operation === 'modify') {
			console.log("submit clicked");
			
			var str = "";
			
			$(".uploadResult ul li").each(function(i, obj){
				
				var jobj = $(obj);
				
				console.dir(jobj);
				
				str += "<input type='hidden' name='imgList["+i+"].filename' value='" + jobj.data("filename") + "'>";
				str += "<input type='hidden' name='imgList["+i+"].uuid' value='" + jobj.data("uuid") + "'>";
				str += "<input type='hidden' name='imgList["+i+"].uploadpath' value='" + jobj.data("path") + "'>"; 
				
			});
			formObj.append(str).submit();
		}
		formObj.submit();
	});
		
	
	// 업로드된 결과 처리
	function showUploadResult(uploadResultArr) {
		if(!uploadResultArr || uploadResultArr.length == 0) {
			return;
		}
		
		var uploadUL = $(".uploadResult ul");
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			
			if(obj.image){
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				str += "<li data-path='" + obj.uploadPath + "'";
				str += "data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "'data-type='" + obj.image + "'";
				str += "><div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image'>X</button><br>";
				str += "<img src='/display?fileName=" + fileCallPath + "'>";
				str += "</div>";
				str += "</li>";
			} 
			
		});
		
		uploadUL.append(str);
	}
	
	// 파일 업로드 관련
	var regex = new RegExp("(.*?)\.(jpg|jpeg|png)$"); // 이미지 확장자만 가능
	var maxSize = 5242880; // 5MB
	
	function checkFile(fileName, fileSize) {
		if(fileSize >= maxSize) {
			alert('5MB 이하 사이즈만 가능합니다.');
			return false;
		}
		
		if(!(regex.test(fileName))) {
			alert('jpg, jpeg, png 파일만 업로드 가능합니다.');
			return false;
		}
		return true;
	}
	
	$("input[type='file']").change(function(e){
		
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files; // files에 올린 이미지들의 정보가 담김
		
		for(var i = 0; i < files.length; i++) {
			if(!checkFile(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false, data:
			formData, type: 'POST',
			dataType: 'json',
			success: function(result){
				console.log(result);
				showUploadResult(result); // 업로드 결과 처리 함수
			}
		});
		
		
	});



})





</script>




<%@ include file="../includes/footer.jsp"%>
</body>
</html>