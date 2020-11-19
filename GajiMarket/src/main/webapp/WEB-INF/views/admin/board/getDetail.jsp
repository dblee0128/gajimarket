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
		
		<!-- 클릭 시 커지는 이미지 영역 -->
		<div class="bigPictureWrapper">
			<div class="bigPicture">
			<!-- 여기에 출력 -->
			</div>
		</div>
		
		<!-- 이미지 출력 영역 -->
		<div class="uploadResult">
			<ul class="bxslider">
			<!-- 여기에 출력 -->
			</ul>
		</div>
		
		<!-- 좋아요 누르는 부분 -->
		<div class="likeArea">
			<c:choose>
				<c:when test="${likeCheck eq '0'}">
					<img src="/resources/img/like_off.png" class="likeBtn" align="left" style="cursor: pointer; width: 20px;">
				</c:when>
				<c:otherwise>
					<img src="/resources/img/like_on.png" class="likeBtn" align="left" style="cursor: pointer; width: 20px;">
				</c:otherwise>
			</c:choose>
		</div>
		
		<!-- 게시글 영역 -->
		<div class="contentArea">
		 	<div class="title">
		 		[${board.sell}] ${board.title}
		 	</div>
		 	
			<p class="detail">
				${board.category.categoryname} | 
				<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/>
			</p>
			
			<p class="price">${board.price}원</p>
			
			<div class="content">
				<pre><c:out value="${board.content}"/></pre>
			</div>
			
			<p class="detail">
				작성자 ${board.member.nickname} | 
				관심 ${board.likecnt} | 조회 ${board.readcnt}</p>
		</div><br>
		
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
			<a href="/admin/board?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">
			<button class="buttonMedium">목록</button></a>
			
			<c:if test="${nickname eq board.member.nickname || isadmin == 1}">
				<a href="delete/${board.boardnum}">
				<button class="buttonMedium" id="deleteBtn">삭제</button></a>
				<br>${msg}
			</c:if>
			<p>* 게시물은 신중하게 삭제해주세요. 삭제 시, 복구가 불가능합니다.</p>
		</div>	
		<br>
		
	<%@ include file="../../includes/footer.jsp"%>
	</div>
</div>


<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/reply.js"/>"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script>
// 게시물 삭제 확인
$(document).ready(function(){
	$("#deleteBtn").on("click", function(){
	
		if(confirm("부적절한 게시물입니까? 정말 삭제하시겠습니까?") == true){
			alert('게시물이 삭제되었습니다.');
		} else {
			return false;
		}
	})
})
</script>

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
// 이미지 슬라이더 불러오기
var jQ182 = $.noConflict(true);

jQ182(document).ready(function(){
	
	jQ182('.bxslider').bxSlider( {
		mode: 'horizontal',// 가로 방향 수평 슬라이드
        pager: false,      // 현재 위치 페이징 표시 여부 설정
        moveSlides: 1,     // 슬라이드 이동시 개수
        slideWidth: 5,   // 슬라이드 너비
        minSlides: 2,      // 최소 노출 개수
        maxSlides: 10,      // 최대 노출 개수
        slideMargin: 5,    // 슬라이드간의 간격
        auto: false,        // 자동 실행 여부        
        autoHover: false,   // 마우스 호버시 정지 여부
        controls: false    // 이전 다음 버튼 노출 여부
    });
});

// 이미지 가져오기
$(document).ready(function(){
	(function(){
		var boardnum = '<c:out value="${board.boardnum}"/>';
		$.getJSON("/board/getImgList", {boardnum: boardnum}, function(arr){
			console.log(arr);
			
			var str = "";
			
			$(arr).each(function(i, attach){
				
					var fileCallPath = encodeURIComponent(attach.uploadpath + "/s_" + attach.uuid + "_" + attach.filename);
					var fileCall = encodeURIComponent(attach.uploadpath + "/" + attach.uuid + "_" + attach.filename);
					
					str += "<li data-path='" + attach.uploadpath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.filename + "' data-type='" + attach.filetype + "'><div>";
					str += "<img src='/display?fileName=" + fileCall + "'>";
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
	
	var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename") + liObj.data("filetype"));
	
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
			str += "<span>" + list[i].member.nickname;
			if(writer == nickname){ // 수정과 삭제 버튼은 댓글 작성자와 이름이 같은 경우에만 출력되도록 함
			str += "<a href=\"javascript:void(0)\" onClick=\"updateFun1("+list[i].replynum+",'"+list[i].reply+"','"+list[i].member.nickname+"')\" class='replylink'>&nbsp;&nbsp;수정</a>";
			str += "&nbsp;&nbsp;<a href=\"javascript:void(0)\" onClick=\"deleteFun1("+list[i].replynum+")\" class='replylink'>삭제</a></span>";
			}
			str += "&nbsp;&nbsp;<span class='time'>"+ replyService.displayTime(list[i].regdate) + "</span>";
			str += "<p>" + list[i].reply + "</p>";
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
	editform += '<span class="name">' + name + '</span><br>';
	editform += '<textarea rows="5" cols="50" id="editreply' + no + '" name="reply" class="textArea">' + content + '</textarea>';
	editform += '<br><input type="submit" value="수정" id="btneditReplySave" onClick=\"updateFun2('+no+')\">';
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
</body>
</html>