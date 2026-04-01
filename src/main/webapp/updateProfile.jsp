<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.util.JdbcLoader"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>\
<%
session = request.getSession(false);

if (session == null || session.getAttribute("uname") == null) {
%>

<!DOCTYPE html>
<html>
<head>
<title>Session Expired</title>
<style>
body{
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    background:linear-gradient(135deg,#1e2a38,#00c6ff);
    color:white;
}
.box{
    padding:40px;
    background:rgba(0,0,0,0.6);
    border-radius:10px;
}
</style>
<script>
setTimeout(()=>{window.location.href="Login.html"},3000);
</script>
</head>
<body>
<div class="box">
<h2>⚠ Session Expired</h2>
<p>Redirecting...</p>
</div>
</body>
</html>

<%
return;
}

String uname = (String) session.getAttribute("uname");

%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

Connection con = JdbcLoader.getconnection();
int id=Integer.parseInt(request.getParameter("uid"));
String name=request.getParameter("name");
String email=request.getParameter("email");
String contact=request.getParameter("contact");
String username=request.getParameter("uname");
String password=request.getParameter("password");
String sql="update userregister set name=?,email=?,contact=?,uname=?,password=? where uid=?";
PreparedStatement ps=con.prepareStatement(sql);
ps.setString(1, name);
ps.setString(2, email);
ps.setString(3, contact);
ps.setString(4, username);
ps.setString(5, password);
ps.setInt(6, id);
int res=ps.executeUpdate();
if(res>0)
{
	

%>

<script type="text/javascript">
alert('Profile Updated successfully ');
window.location.href="profile.jsp";

</script>
<%}
else{%>

<script type="text/javascript">
alert('Profile Updation Failed ');
window.location.href="profile.jsp";

</script>
<%} %>
</body>
</html>