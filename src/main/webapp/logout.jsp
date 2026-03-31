<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
session = request.getSession(false);

if (session == null || session.getAttribute("uname") == null) {
	response.sendRedirect("Login.html");
	return;
}
else{
	session.invalidate();
	response.sendRedirect("Login.html");
}
%>
</body>
</html>