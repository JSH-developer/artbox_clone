 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DB Connection Test</title>
</head>
<body>
<h1>DB연결확인</h1>
<%
String DB_URL = "jdbc:mysql://localhost/itwillbs9?serverTimezone=UTC";
String DB_USER = "itwillbs9";
String DB_PASSWORD= "itwillbs8030909";

Connection conn;
Statement stmt;

try {
 Class.forName("com.mysql.jdbc.Driver");
 conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
 stmt = conn.createStatement();
 conn.close();
 out.println("MySql jdbc test: connect ok!!");
} catch(Exception e) {
 out.println(e.getMessage());
}
%>
</body>
</html>


</body>
