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

<div id="container">
	<div id="wrap">
		<form:form action="register" method="post" modelAttribute="board">
		<input type="hidden" name="membernum" value="${member.membernum}">
			<table id="board_tb" style="text-align: left;">
				<tr>
					<td>
						<label>제목</label>
						<form:input path="title" placeholder="제목"/>
					</td>
				</tr>
				<tr><td><form:errors path="title" id="error"/></td></tr>
				<tr>
					<td>
						<label>가격</label>
						<form:input path="price" placeholder="가격"/>
					</td>
				</tr>
				<tr>
					<td><form:errors path="price" id="error"/></td>
				</tr>
				<tr>
					<td>
						<label>내용</label>
						<form:textarea path="content" cols="100" rows="20" placeholder="내용"/>
					</td>
				</tr>
				<tr>
					<td><form:errors path="content" id="error"/></td>
				</tr>
				<tr>
					<td>
						<label>카테고리</label>
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
				<tr><td id="error">${msg}</td></tr>
			</table>
			<button type="submit">등록</button>
			<input type="button" value="목록" onclick="location.href='/board'">
		</form:form>
	</div>
	
	<!-- 이미지 추가 영역 -->
	<div class="upload">
		<label>파일첨부</label>
		<div class="uploadForm">
			<input type="file" name="uploadFile" multiple>
		</div>
		
		<div class="uploadResult">
			<ul>
			<!-- 업로드한 이미지 출력 -->
			</ul>
		</div>
	</div>
</div>

<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
<script>
$(document).ready(function(e){
	
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
	
	// X 클릭 시, 파일 삭제
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).data("li");
		
		console.log("targetLi: " + targetLi);
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type: type},
			dataType: 'text',
			type: 'POST',
			success: function(result) {
				alert(result);
				targetLi.remove();
			}
		});
	});
	
	// 첨부파일 처리를 위해 제출 버튼 막기
	var formObj = $("form"); // 확인 필요
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		console.log("submit clicked");	
		
		var str = "";
		
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
			console.dir(jobj);
			
			str += "<input type='hidden' name='imgList["+i+"].filename' value='" + jobj.data("filename") + "'>";
			str += "<input type='hidden' name='imgList["+i+"].uuid' value='" + jobj.data("uuid") + "'>";
			str += "<input type='hidden' name='imgList["+i+"].uploadpath' value='" + jobj.data("path") + "'>";
			
		});
		formObj.append(str).submit(); // 기존 폼에 위 내용들을 붙여서 전송해라
	});
	
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
	
	
	
	
});


</script>




<%@ include file="../../includes/footer.jsp"%>
</body>
</html>