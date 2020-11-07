<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</head>
<body>
	<!-- 첨부 영역 -->
	<h2>Upload with Ajax</h2>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<button id="uploadBtn">Upload</button>
	
	<!-- 첨부 파일 이름 출력 -->
	<div class="uploadResult">
		<ul>
		<!-- 여기에 출력 -->
		</ul>
	</div>
	
	<!-- 원본 이미지 영역 -->
	<div class="bigPictureWrapper">
		<div class="bigPicture">
		<!-- 여기에 출력 -->
		</div>
	</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"
		integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
		crossorigin="anonymous"></script>

<script>

// 원본 이미지 보여주기
function showImage(fileCallPath) {
	
	$(".bigPictureWrapper").css("display", "flex").show(); // 화면 가운데에 위치하도록
	
	$(".bigPicture")
	.html("<img src='/display?fileName="+encodeURI(fileCallPath)+"'>")
	.animate({width: '100%', height: '100%'}, 1000); // .animate : 지정된 시간동안 화면에서 열리는 효과
	
}

// 원본 이미지 클릭하면 사라지게 하기
$(".bigPictureWrapper").on("click", function(e){
	
	$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
	setTimeout(() => {
		$(this).hide();
	}, 1000);
	
});

// x 표시에 대한 이벤트 처리
$(".uploadResult").on("click", "span", function(e){ // 이벤트 위임

	var targetFile = $(this).data("file"); // 첨부파일 경로 + 이름
	var type = $(this).data("type"); // 파일 타입: 일반, 이미지
	console.log(targetFile);
	
	$.ajax({
		url: '/deleteFile',
		data: {fileName: targetFile, type: type},
		dataType: 'text',
		type: 'POST',
		success: function(result) {
			alert(result);
		}
	});
});


$(document).ready(function(){
	
	// 파일 이름 출력
	var uploadResult = $(".uploadResult ul"); // 이 영역에 결과를 뿌릴 것임. 영역을 변수로 저장
	
	function showUploadedFile(uploadResultArr) {
		
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){ // .each(인덱스, 값): 배열에서 하나씩 들고와라
			
			if(!obj.image) { // 첨부파일이 이미지가 아니면 파일 아이콘을 보여줘라
				
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				
				var fileLink = fileCallPath;
				
				str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>" +
						"<img src='/resources/img/attach.png'>" + obj.fileName + "</a>" +
						"<span data-file=\'" + fileCallPath + "\' data-type='file'> x </span>" +
						"</div></li>";
				
			} else { // 이미지면
				//str += "<li>" + obj.fileName + "</li>";
				
				// URI 호출에 적합한 문자열로 인코딩 처리 - 한글 처리
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName); // 이건 섬네일
				
				// 원본 이미지 보여주기 (s_가 빠짐)
				// 업로드된 경로 + uuid + 파일명
				var originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
				
				str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\">" + 
					   "<img src='/display?fileName=" + fileCallPath + "'></a>" +
					   "<span data-file=\'" + fileCallPath + "\' data-type='image'> x </span>" +
					   "</li>";
			}
		
		});
		
		uploadResult.append(str); // 이 영역에 결과를 뿌려라
	}
	
	
	// 업로드 제한 및 크기 검증
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); // 업로드 제한을 위한 정규표현식
	var maxSize = 5242880; // 최대 크기: 5MB
	
	function checkExtension(fileName, fileSize) { // (파일이름, 파일사이즈)를 받아서 비교
		
		if(fileSize >= maxSize) {
			alert('파일 사이즈 초과');
			return false;
		}
	
		if(regex.test(fileName)) { // fileName 정규화 체크해라
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;
	}
	
	
	// 전송 영역
	var cloneObj = $(".uploadDiv").clone(); // 첨부 양식이 담긴 <div> 영역을 복사 -> 새로고침하려고
	
	$("#uploadBtn").on("click", function(e){
	
		var formData = new FormData(); // FormData를 이용해서 필요한 파라미터를 담아서 전송 = 가상의 <form> 태그
		
		var inputFile = $("input[name='uploadFile']"); // 들어온 파일을 inputFile 배열에? 저장
		
		var files = inputFile[0].files; // 배열에 담긴 파일을 가져와라 -> 다 가져오네...?
		
		console.log(files);
		
		for(var i = 0; i < files.length; i++) {
			
			if(!checkExtension(files[i].name, files[i].size)) { // checkExtension 함수 호출해서 비교한 다음 false가 반환되면 얘도 false!
				return false;
			}
			
			formData.append("uploadFile", files[i]); // files를 돌면서 formData에 하나씩 추가해라
													 // 컨트롤러에서 uploadFile이라는 이름으로 사용할 것임
		}
		
		$.ajax({
			url: '/uploadAjaxAction', // 해당 요청이 들어오면
			processData: false,
			contentType: false, // 두 가지는 반드시 false로 해야 전송 가능!
			data: formData, // formData를 보내겠다
			type: 'POST', // post 방식으로
			dataType: 'json',
			success: function(result){ // json 형태의 결과
				console.log(result);
				showUploadedFile(result); // 함수를 호출 -> 결과를 넘김
				$(".uploadDiv").html(cloneObj.html()); // 깨끗한 폼을 다시 붙여넣음
			}
		});
		
	});

});
</script>

</body>
</html>