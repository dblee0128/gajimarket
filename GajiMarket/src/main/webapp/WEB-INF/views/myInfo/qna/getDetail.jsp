<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
<%@ include file="../../includes/header.jsp"%>

	<div class="mainArea">
		<input type="hidden" name="membernum" value="${membernum}">
		
		<!-- 코멘트 영역 -->
		<div class="writeCmt" style="width: 65%;">
			<h4>1:1 문의</h4>
		</div>
		
		<!-- 글 출력 영역 -->
		<div class="writeArea" style="width: 65%;">
			<table class="detailtb">
				<tr>
					<td class="title">[${qna.type.typename}] ${qna.title}</td>
				</tr>
				<tr>
					<td class="content"><pre><c:out value="${qna.content}"/></pre></td>
				</tr>
			</table>
		</div>
		<br>
		
		<!-- 댓글 쓰기 -->
		<div class="replyContent">
			<div class="replyRegister">
				<h4 style="margin: 10px 0 5px 0;">댓글</h4>
				<span class="name">${nickname}</span><br>
				<textarea rows="5" cols="50" id="reply" name="reply" class="textArea" placeholder="댓글을 남겨주세요."></textarea>
				<br>
				<button type="submit" id="registerBtn">등록</button>
			</div>
			<br>
			
			<!-- 댓글 출력 영역-->
			<div class="replyArea">
				
			</div> 
		</div>
		<br>
		
		<!-- 버튼 영역 -->		
		<div class="detailBtnArea">
			<a href="/myInfo/qna">
			<button class="buttonMedium">목록</button></a>
			
			<c:if test="${nickname eq qna.member.nickname}">
			<a href="/myInfo/qna/modify/${qna.qnanum}">
			<button class="buttonMedium">수정</button></a>
			
			<a href="/myInfo/qna/delete/${qna.qnanum}">
			<button class="buttonMedium" id="deleteBtn">삭제</button></a>
			<br>${msg}
			</c:if>
		</div>	
		<br>
		
	<%@ include file="../../includes/footer.jsp"%>
	</div>
	
	<!-- /myInfo/qna/modify라는 요청이 들어왔을 때 각각의 값을 보내준다  -->
	<form action="/myInfo/qna/modify" method="get">
		<input type="hidden" name="qnanum" value="<c:out value="${qna.qnanum}"/>">
	</form>

</div>


<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/QnaReply.js"/>"></script>
<script>
// 게시물 삭제 확인
$(document).ready(function(){
	$("#deleteBtn").on("click", function(){
	
		if(confirm("정말 삭제하시겠습니까?") == true){
			alert('게시물이 삭제되었습니다.');
		} else {
			return false;
		}
	})
})
</script>

<script>
// 전체 댓글 목록
function showList(qnanum, replyList) {
	
	var nickname = '<c:out value="${nickname}"/>'; // 세션에서 별명 가져오기
	console.log(nickname);

	replyService.getList({qnanum: qnanum}, function(list){
		var str = "";
		
		if(list == null || list.length == 0) {
			replyList.html("");
			return;
		}
		
		for(var i = 0, len = list.length || 0; i < len; i++) {
			var writer = list[i].member.nickname; // writer에 별명 저장
			
			str += "<div class='replyList' id='reply" + list[i].qnareplynum + "' data-rno='" + list[i].qnareplynum + "'>";
			str += "<span>" + list[i].member.nickname;
			if(writer == nickname){ // 수정과 삭제 버튼은 댓글 작성자와 이름이 같은 경우에만 출력되도록 함
			str += "<a href=\"javascript:void(0)\" onClick=\"updateFun1("+list[i].qnareplynum+",'"+list[i].qnareply+"','"+list[i].member.nickname+"')\" class='replylink'>&nbsp;&nbsp;수정</a>";
			str += "&nbsp;&nbsp;<a href=\"javascript:void(0)\" onClick=\"deleteFun1("+list[i].qnareplynum+")\" class='replylink'>삭제</a></span>";
			}
			str += "&nbsp;&nbsp;<span class='time'>"+ replyService.displayTime(list[i].regdate) + "</span>";
			str += "<p><pre>" + list[i].qnareply + "</pre></p>";
			str += "<hr><br>";
			str += "";
			str += "</div>";

		}
		replyList.html(str);
	});

}

// 댓글 삭제
function deleteFun1(no){
	console.log(no);
	
	var qnanum = '<c:out value="${qna.qnanum}"/>';
	var replyList = $(".replyArea");
	
	
	if(confirm("정말 삭제하시겠습니까?") == true) {
		$.ajax({
			type: 'delete',
			url: '/qnaReply/' + no,
			success: function(deleteResult) {
				showList(qnanum, replyList);
			},
			error: function(xhr, status, er) {
				console.log("error " + er);
			}
			
		});
	} else {
		return false;
	}
	
}

// 댓글 수정
function updateFun1(no,content,name){
	console.log("Edit = "+no);
	var qnanum = '<c:out value="${qna.qnanum}"/>';
	var replyList = $(".replyArea");
	
	var editform = "";
	editform += '<div class="replyRegister">';
	editform += '<span class="name">' + name + '</span><br>';
	editform += '<textarea rows="5" cols="50" id="editreply' + no + '" name="reply" class="textArea">' + content + '</textarea>';
	editform += '<br><input type="submit" value="수정" id="btneditReplySave" onClick=\"updateFun2('+no+')\">';
	editform += '</div>';
	
	$('#reply' + no).replaceWith(editform);
	$('#reply' + no + '#editreply').focus();
}

function updateFun2(no){
	console.log("delete = ");
	var qnanum = '<c:out value="${qna.qnanum}"/>';
	var replyList = $(".replyArea");
	
	var editContent = $('#editreply'+no).val();
	var paramData = JSON.stringify({"qnareply": editContent});
	//console.log(editContent);
	
	$.ajax({
		type: 'put',
		url: '/qnaReply/' + no,
		data: paramData,
		contentType: "application/json; charset=utf-8",
		success: function(result) {
			showList(qnanum, replyList);
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
	var qnanum = '<c:out value="${qna.qnanum}"/>'; // 문의글 번호
	var replyList = $(".replyArea"); // 댓글 리스트가 담길 영역
	
	showList(qnanum, replyList); // 리스트를 뿌려주는 함수 호출
	
	
	// 댓글 추가
	var membernum = '<c:out value="${membernum}"/>'; // 회원 번호
	
	$("#registerBtn").on("click", function(){ // 게시글 등록 버튼을 누르면
	
		var reply = {
				qnareply: $("#reply").val(), // <textarea>의 값 가져오기
				qnanum: qnanum,
				membernum: membernum
		};
		
		$.ajax({
			type: 'post',
			url: '/qnaReply/new',
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				showList(qnanum, replyList); // 성공하면 리스트를 보여줘
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
</body>
</html>