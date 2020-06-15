<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="uploadtest.itme" method="post" enctype="multipart/form-data">
<input type="file">
	<table>
		<tr>
        	<td>제목 : </td>
			<td><input type="text" name="title"/></td>
		</tr>
		<tr>
			<td>내용 : </td>
			<td><input type="text" name="content"/></td>
		</tr>
		<tr>
			<td>이미지 : </td>
			<td><input type="file" value="파일 선택" name="file"/></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="업로드"/></td>
		</tr>
</form>
</body>
</html>