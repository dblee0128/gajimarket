<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="uploadFormAction" method="post" enctype="multipart/form-data">
		<input type="file" name="uploadFile" multiple="multiple"> <!-- 컨트롤러 post단에서 uploadFile 이라는 이름으로 사용할 것임 -->
		<button>submit</button>	
	</form>
</body>
</html>