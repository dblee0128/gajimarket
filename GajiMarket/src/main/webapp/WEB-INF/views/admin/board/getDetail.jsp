<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지마켓</title>
<style>
.uploadResult {
	width: 100%;
	background-color: #fafafa;
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
<%@ include file="../../includes/header.jsp"%>
<div id="container">
	<div id="wrap">
		<input type="hidden" name="membernum" value="${membernum}">
		
		<!-- 이미지 출력 부분 -->
		<div class="bigPictureWrapper">
			<div class="bigPicture">
			<!-- 여기에 출력 -->
			</div>
		</div>
		
		<!-- 첨부 파일 이름 출력 -->
		<div class="uploadResult">
			<ul>
			<!-- 여기에 출력 -->
			</ul>
		</div>
		
		<!-- 좋아요 누르는 부분 -->
		<c:choose>
			<c:when test="${likeCheck eq '0'}">
				<img src="/resources/img/like_off.png" class="likeBtn" align="left" style="cursor: pointer; width: 20px;">
			</c:when>
			<c:otherwise>
				<img src="/resources/img/like_on.png" class="likeBtn" align="left" style="cursor: pointer; width: 20px;">
			</c:otherwise>
		</c:choose>

		
		<table id="board_tb" style="text-align: left;">
			<tr>
				<td>제목</td>
				<td>${board.title}</td>
			</tr>
			<tr>
				<td>가격</td>
				<td>${board.price}</td>
			</tr>
			<tr>
				<td style="height: 100px; width: 100px;">내용</td>
				<td><pre><c:out value="${board.content}"/></pre></td>
			</tr>
			<tr>
				<td>판매여부</td>
				<td>${board.sell}</td>
			</tr>
			<tr>
				<td>조회수</td>
				<td>${board.readcnt}</td>
			</tr>
			<tr>
				<td>관심수</td>
				<td>${board.likecnt}</td>
			</tr>
			<tr>
				<td>작성일자</td>
				<td>${board.regdate}</td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td>${board.category.categoryname}</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${board.member.nickname}</td>
			</tr>
		</table>
		<br>
		
		<!-- 댓글 쓰기 -->
		<div class="replyRegister">
			<span>${nickname}</span>
			<textarea rows="5" cols="100" id="reply" name="reply" style="resize:none;"></textarea>
			<input type="submit" value="확인" id="registerBtn">
		</div>
		
		<!-- 댓글 출력 영역-->
		<div class="replyArea">	
		</div> 
		
		<!-- 버튼 영역 -->		
		<div id="buttonArea" style="position: absolute;">
			<a href="admin/board?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
			<button>목록</button></a>
			<c:if test="${nickname eq board.member.nickname || isadmin == 1}">
				<a href="delete/${board.boardnum}"><button>삭제</button></a><br>${msg}
			</c:if>
		</div>		
	</div>
</div>


<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
// 좋아요 부분
$(document).ready(function(){
	
	var membernum = '<c:out value="${membernum}"/>';
	var boardnum = '<c:out value="${board.boardnum}"/>';
	
	$(".likeBtn").on("click", function(){
		
		var data = {
			boardnum: boardnum,
			membernum: membernum
		};
		
		$.ajax({
			type: 'POST',
			url: '/board/like',
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			success: function(response) {
				if(response == 1) {
					console.log('좋아요');
					$(".likeBtn").attr("src", "/resources/img/like_on.png");
				} else {
					console.log('안좋아요');
					$(".likeBtn").attr("src", "/resources/img/like_off.png");
				}
				
			}
				
		});
	})
});
</script>

<script>
// 이미지 가져오기
$(document).ready(function(){
	(function(){
		var boardnum = '<c:out value="${board.boardnum}"/>';
		$.getJSON("/board/getImgList", {boardnum: boardnum}, function(arr){
			console.log(arr);
			
			var str = "";
			
			$(arr).each(function(i, attach){
				
					var fileCallPath = encodeURIComponent(attach.uploadpath + "/s_" + attach.uuid + "_" + attach.filename);
					
					str += "<li data-path='" + attach.uploadpath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.filename + "' data-type='" + attach.filetype + "'><div>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str += "</li>";
	
			});
			$(".uploadResult ul").html(str);
		});
	})();
});

// 이미지 크게 보기
$(".uploadResult").on("click", "li", function(e){
	
	console.log("view image");
	
	var liObj = $(this);
	
	var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
	
	if(liObj.data("type")) {
		showImage(path.replace(new RegExp("/")));
	}
});
		
// 해당 이미지의 경로를 보여줌
function showImage(fileCallPath) {
	//alert(fileCallPath);
	
	$(".bigPictureWrapper").css("display", "flex").show();
	
	$(".bigPicture")
	.html("<img src='/display?fileName=" + fileCallPath + "'>")
	.animate({width: '100%', height: '100%'}, 1000);
}

// 이미지 닫기
$(".bigPictureWrapper").on("click", function(e){

	$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
	setTimeout(function(){
		$('.bigPictureWrapper').hide(); 
	}, 1000);
});


</script>


<script>

// 전체 댓글 목록
function showList(boardnum, replyList) {
	
	var nickname = '<c:out value="${nickname}"/>'; // 세션에서 별명 가져오기

	replyService.getList({boardnum: boardnum}, function(list){
		var str = "";
		if(list == null || list.length == 0) {
			replyList.html("");
			return;
		}
		for(var i = 0, len = list.length || 0; i < len; i++) {
			var writer = list[i].member.nickname; // writer에 별명 저장
			
			str += "<div class='replyList' id='reply" + list[i].replynum + "' data-rno='" + list[i].replynum + "'>";
			str += "<span>" + list[i].member.nickname ;
			
			if(writer == nickname){ // 수정과 삭제 버튼은 댓글 작성자와 이름이 같은 경우에만 출력되도록 함
			str += "<a href=\"javascript:void(0)\" onClick=\"updateFun1("+list[i].replynum+",'"+list[i].reply+"','"+list[i].member.nickname+"')\">수정</a>";
			str += "&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:void(0)\" onClick=\"deleteFun1("+list[i].replynum+")\">삭제</a></span>";
			}
			str += "&nbsp;&nbsp;<span>"+ replyService.displayTime(list[i].regdate) + "</span>";
			str += "<p>" + list[i].reply + "</p>";
			str += "<br>";
			str += "";
			str += "</div>";

		}
		replyList.html(str);
	});
}

// 댓글 삭제
function deleteFun1(no){
	console.log(no);
	var boardnum = '<c:out value="${board.boardnum}"/>';
	var replyList = $(".replyArea");
	
	
	if(confirm("정말 삭제하시겠습니까?") == true) {
		$.ajax({
			type: 'delete',
			url: '/reply/' + no,
			success: function(deleteResult) {
				showList(boardnum, replyList);
			},
			error: function(xhr, status, er) {
				console.log("error "+er);
			}
			
		});
	} else {
		return false;
	}
	
}

// 댓글 수정
function updateFun1(no,content,name){
	console.log("Edit = "+no);
	var boardnum = '<c:out value="${board.boardnum}"/>';
	var replyList = $(".replyArea");
	
	var editform = "";
	editform += '<div class="replyRegister">';
	editform += '<span>'+name+'</span>';
	editform += '<textarea rows="5" cols="100" id="editreply'+no+'" name="reply">'+content+'</textarea>';
	editform += '<input type="submit" value="Confirm" id="btneditReplySave" onClick=\"updateFun2('+no+')\">';
	editform += '</div>';
	
	$('#reply' + no).replaceWith(editform);
	$('#reply' + no + '#editreply').focus();
}

function updateFun2(no){
	console.log("delete = ");
	var boardnum = '<c:out value="${board.boardnum}"/>';
	var replyList = $(".replyArea");
	
	var editContent = $('#editreply'+no).val();
	var paramData = JSON.stringify({"reply":editContent});
	//console.log(editContent);
	$.ajax({
		type: 'put',
		url: '/reply/' + no,
		data: paramData,
		contentType: "application/json; charset=utf-8",
		success: function(result) {
			showList(boardnum, replyList);
		},
		error: function(xhr, status, er) {
			console.log("error = "+er+" / "+status+" / "+xhr);
		}
		
	});
	
	
}
</script>

<script>
$(document).ready(function(){ // 화면이 로드되는 순간 나와야할 것들

	// 전체 댓글 조회
	var boardnum = '<c:out value="${board.boardnum}"/>'; // 게시글 번호
	var replyList = $(".replyArea"); // 댓글 리스트가 담길 영역
	
	showList(boardnum, replyList); // 리스트를 뿌려주는 함수 호출
	
	
	// 댓글 추가
	var membernum = '<c:out value="${membernum}"/>'; // 회원 번호
	
	$("#registerBtn").on("click", function(){ // 게시글 등록 버튼을 누르면
	
		var reply = {
				reply: $("#reply").val(), // <textarea>의 값 가져오기
				boardnum: boardnum,
				membernum: membernum
		};
		
		$.ajax({
			type: 'post',
			url: '/reply/new',
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				showList(boardnum, replyList); // 성공하면 리스트를 보여줘
				$('#reply').val(''); // 그리고 쓴 내용을 지워줘
			},
			error: function(xhr, status, er) {
				if(error) {
					error(er); // 에러나면 에러를 출력해줘
				}
			}
		});
		
	}) 
	
});
</script>
<%@ include file="../../includes/footer.jsp"%>
</body>
</html>