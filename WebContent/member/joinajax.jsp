<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	String id = request.getParameter("id");
// 	String pw = request.getParameter("pw");
	String birth = request.getParameter("birth");
	
	
	String dbid = "1";
	String idRegex = "[a-zA-Z0-9]{4,16}";
	String pwRegex = "[a-zA-Z0-9]{4,16}";
	String lenBirth = "[0-9]{8}";
	boolean idcheck = Pattern.compile(idRegex).matcher(id).find();
// 	boolean pwcheck = Pattern.compile(pwRegex).matcher(pw).find();
	boolean birthcheck = Pattern.compile(lenBirth).matcher(birth).find();
	
	if (Pattern.matches(idRegex, id)) {
		if (idcheck == true) {
			if (id.equals(dbid)) {
				out.println("<h5 style='color: red; margin:-1px 0;'>아이디 중복</h5>");
			} else {
				out.println("<h5 style='color: blue; margin:-1px 0;'>아이디 사용가능</h5>");
			}
		}else{
			out.println("<h5 style='color: red; margin:-1px 0;'> 4~16글자 영문 숫자 조합하여 형식에 맞춰주세요.</h5>");
		}
	} else if(Pattern.matches(lenBirth, birth)){
		if (!birthcheck) {
			out.println("<h5 style='color: red; margin:-1px 0;'>숫자만 넣어주세요.</h5>");
		}else{
			out.println("<h5 style='color: red; margin:-1px 0;'>숫자 8자리 맞춰주세요.</h5>");
		}
	}
	
// 		-----------------------패스워드 아직 작동불가능-------------------------
// 	if (Pattern.matches(lenRegex, pw)) {
// 		out.println("<h5 style='color: blue; margin:-1px 0;'>사용가능한 비밀번호 입니다.</h5>");
// 	}else{ 
// 		out.println("<h5 style='color: red; margin:-1px 0;'> 4~16글자 영문 숫자 조합하여 형식에 맞춰주세요.</h5>");
// 	}

	
// 	if (Pattern.matches(lenBirth, birth)) {
// 		if (!birthcheck) {
// 			out.println("<h5 style='color: red; margin:-1px 0;'>숫자만 넣어주세요.</h5>");
// 		}
// 	}else{
// 		out.println("<h5 style='color: red; margin:-1px 0;'>숫자 8자리 맞춰주세요.</h5>");
// 	}
%>