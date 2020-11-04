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
<%@ include file="../includes/header.jsp"%>
<div id="container">
	<div id="wrap">
		<input type="hidden" name="membernum" value="${membernum}">
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
				<td style="height: 200px; width: 100px;">내용</td>
				<td>${board.content}</td>
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
		<table class="replyRegister">
			<tr><td>${nickname}</td></tr>
			<tr><td><textarea rows="5" cols="100" id="reply" name="reply"></textarea></td></tr>
			<tr><td><input type="submit" value="확인" id="btnReplySave"></td></tr>
		</table>
		
		
		<!-- 댓글 출력 -->
		<div class="replyArea">	
		</div> 
		
		

		<!-- 버튼 영역 -->		
		<div id="buttonArea" style="position: absolute;">
			<a href="/board?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
			<button>목록</button></a>
			<a href="/board/modify/${board.boardnum}?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
			<button>수정</button></a>
			<a href="/board/delete/${board.boardnum}"><button>삭제</button></a><br>${msg}
		</div>		
	</div>	
	<!-- /board/modify라는 요청이 들어왔을 때 각각의 값을 보내준다  -->
	<form action="/board/modify" method="get">
		<input type="hidden" name="boardnum" value="<c:out value="${board.boardnum}"/>">
		<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
		<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
		<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
		<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
	</form>
	
</div>


<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>




<script>

function showList(boardnum, replyUL) {
	replyService.getList({boardnum: boardnum}, function(list){
		var str = "";
		if(list == null || list.length == 0) {
			replyUL.html("");
			return;
		}
		for(var i = 0, len = list.length || 0; i < len; i++) {
			str += "<table class='replyList' data-rno='" + list[i].replynum + "'>";
			str += "<tr><td>" + list[i].member.nickname + "</td>";
			str += "<td>" + replyService.displayTime(list[i].regdate) + "</td>";
			str += "<tr><td>" + list[i].reply + "</td></tr>";
			str += "<br>";
			str += "<tr><td>";
			str += "<button id='updateBtn' name='updateBtn' onclick='updateFun1("+list[i].replynum +")' data-rno='" + list[i].replynum + "'>수정";
			str += "<button id='deleteBtn' name='deleteBtn' onclick='deleteFun1("+list[i].replynum +")' data-rno='" + list[i].replynum + "'>삭제";
			str += "</tr></td></table>";

		}
		replyUL.html(str);
	});
}

function deleteFun1(no){
	console.log(no);
	var boardnum = '<c:out value="${board.boardnum}"/>';
	var replyUL = $(".replyArea");
	
	
	$.ajax({
		type: 'delete',
		url: '/reply/' + no,
		success: function(deleteResult) {
			//console.log(deleteResult);

			showList(boardnum, replyUL);
		},
		error: function(xhr, status, er) {
			console.log("error "+error);
		}
		
	});
	
}

function updateFun1(no){
	console.log(no);
	var boardnum = '<c:out value="${board.boardnum}"/>';
	var replyUL = $(".replyArea");
	
	var editform = "";
	editform += '<table class="replyRegister">';
	editform += '<tr><td><textarea rows="5" cols="100" id="reply" name="reply"></textarea></td></tr>';
	editform += '<tr><td><input type="submit" value="확인" id="btnReplySave"></td></tr>';
	editform += '</table>'
	$('#no'+no).replaceWith(editform);
	$('#no'+no+'#reply').focus();
}
</script>
<script>
$(document).ready(function(){

	// 전체 댓글 조회
	var boardnum = '<c:out value="${board.boardnum}"/>';
	var replyUL = $(".replyArea");
	
	showList(boardnum, replyUL);
	
	
	// 댓글 추가
	var membernum = '<c:out value="${membernum}"/>';
	
	$("#btnReplySave").on("click", function(){
	
		var reply = {
				reply: $("#reply").val(),
				boardnum: boardnum,
				membernum: membernum
		};
		
		replyService.add(reply, function(result){
			//alert(result);
			
			showList(boardnum, replyUL);
			
		});
	}) 
	

	/* // 댓글 삭제, 수정
	$(".replyArea").on("click", "button", function(e) {
		var rno = $(this).data("rno");
		console.log(rno);
		var deleteBtn = $("#deleteBtn");
		var updateBtn = $("#updateBtn");
		console.log(deleteBtn);
		deleteBtn.on("click", function(e){
			replyService.remove(rno, function(result){
				alert("sresult");
				showList();
			});
			
		});
		
		updateBtn.on("click", function(e){
			alert("수정"); // 여기
		})
	}) */
	
	
	
});

</script>








<!-- <script>
console.log("==========");
console.log("ADD TEST")

var boardnum = '<c:out value="${board.boardnum}"/>';
var membernum = '<c:out value="${membernum}"/>';

replyService.add(
	{reply: "JS TEST", boardnum: boardnum, membernum: membernum}
	, 
	function(result) {
		alert("RESULT: " + result);
	}
);
</script>  -->

<!-- <script>
console.log("==========");
console.log("GET LIST TEST");

var boardnum = '<c:out value="${board.boardnum}"/>';

replyService.getList({boardnum: boardnum}, function(list){
	
	for(var i = 0, len = list.length||0; i < len; i++) {
		console.log(list[i]);
	}
});
</script> -->

<!-- <script>
console.log("==========");
console.log("DELETE TEST");

var boardnum = '<c:out value="${board.boardnum}"/>';

replyService.remove(1, function(count) {
	
	console.log(count);
	
	if(count === "success") {
		alert("REMOVED");
	}
}, function(err) {
	alert('ERROR');
});
</script> -->

<!-- <script>
console.log("==========");
console.log("UPDATE TEST");

var boardnum = '<c:out value="${board.boardnum}"/>';

replyService.update({
	replynum: 15,
	boardnum: boardnum,
	reply: "JS TEST 수정된 댓글입니다."
}, function(result) {
	alert("수정 완료");
});
</script> -->

<!-- <script>

replyService.get(10, function(data){
	console.log(data);
});

</script>  -->
<%@ include file="../includes/footer.jsp"%>
</body>
</html>