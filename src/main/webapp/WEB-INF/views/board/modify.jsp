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
			<h4>중고물품 수정하기</h4>
		</div>
		
		<div class="writeArea">
			<p>* 물품을 수정하기 전에 공지사항을 참고해주세요.<br>
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
			
			<form:form action="${board.boardnum}" method="post" modelAttribute="board">
				<input type="hidden" name="membernum" value="${membernum}">
				<input type="hidden" name="boardnum" value="${board.boardnum}">	
				
				<table class="writetb">
					<tr>
						<td class="cmt">판매여부</td>
						<td>
							<select name="sell" class="writeSelectBox">
								<option value="판매중" <c:if test="${board.sell eq '판매중'}">selected</c:if>>판매중</option>
								<option value="판매완료" <c:if test="${board.sell eq '판매완료'}">selected</c:if>>판매완료</option>
							</select>
						</td>
					</tr>
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
					<a href="/board/modify/${board.boardnum}?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
					<button type="submit" data-oper='modify'>수정</button></a>
					
					<a href="/board?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
					<button type="button" data-oper='list'>목록</button></a>
										
					<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
					<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
					<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
					<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
				</div>
			</form:form>
			
		</div>
		
	<%@ include file="../includes/footer.jsp"%>	
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
	var regex = new RegExp("(.*?)\.(jpg|jpeg|png|JPG|JPEG|PNG)$"); // 이미지 확장자만 가능
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

</body>
</html>