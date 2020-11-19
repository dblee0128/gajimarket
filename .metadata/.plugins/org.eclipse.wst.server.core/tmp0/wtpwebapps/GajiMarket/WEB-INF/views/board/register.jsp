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
</head>
<body>
<div id="wrap">
<%@ include file="../includes/header.jsp"%>
	
	<div class="mainArea">
	
		<!-- 코멘트 영역 -->
		<div class="writeCmt">
			<h4>중고물품 등록하기</h4>
		</div>
		
		<!-- 글쓰기 영역 -->
		<div class="writeArea">
			<p>* 물품을 등록하기 전에 공지사항을 참고해주세요.<br>
			   * 이미지는 5MB 이하의 jpg / jpeg / png 파일만 업로드 가능합니다.</p>
			
			<!-- 첨부 영역 -->
			<div class="uploadArea">
				<div class="uploadForm">
					<label class="cmt">이미지</label>
					<input type="file" name="uploadFile" class="uploadBtn" multiple>
				</div>
				<div class="uploadResult">
					<ul>
					</ul>
				</div>
			</div>
			
			<form:form action="register" method="post" modelAttribute="board">
				<input type="hidden" name="membernum" value="${member.membernum}">
				
				<table class="writetb">
					<tr>
						<td class="cmt">제목</td>	
						<td><form:input path="title" placeholder="제목을 입력하세요." class="writeInput"/></td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="title"/></td></tr>
					
					<tr>
						<td class="cmt">가격</td>
						<td><form:input path="price" placeholder="가격을 입력하세요." class="writeInput"/></td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="price"/></td></tr>
					
					
					<tr>
						<td class="cmt">내용</td>
						<td>
							<form:textarea path="content" cols="80" rows="20" placeholder="내용을 입력하세요." class="writeTextArea"/>
						</td>
					</tr>
					<tr><td colspan="2" class="errors"><form:errors path="content"/></td></tr>
					
					<tr>
						<td class="cmt">카테고리</td>
						<td>	
							<form:select path="categorynum" class="writeSelectBox">
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
					<tr><td colspan="2" class="errors">${msg}</td></tr>
					
				</table>
				
				<!-- 버튼 영역 -->
				<div class="writeBtnArea">
					<button type="submit">등록</button>
					<button type="button" onclick="location.href='/board'">목록</button>
				</div>
				
			</form:form>
		</div>
		
		
		
		
	
	<%@ include file="../includes/footer.jsp"%>
	</div>
</div>

<script type="text/javascript" src="<c:url value="../resources/js/jquery-3.5.1.min.js"/>"></script>
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
				str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class='colseBtn'>X</button><br>";
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
		console.log("targetFile: " + targetFile);
		
		var type = $(this).data("type");
		console.log("type: " + type);
		
		var targetLi = $(this).closest("li");
		console.log("targetLi: " + targetLi);
		
		if(confirm("해당 이미지를 삭제하시겠습니까?") == true) {
			$.ajax({
				url: '/deleteFile',
				data: {fileName: targetFile, type: type},
				dataType: 'text',
				type: 'POST',
				success: function(result) {
					targetLi.remove();
				}
			});
		} else {
			return false;
		}
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

</body>
</html>