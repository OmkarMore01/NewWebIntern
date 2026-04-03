<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.util.JdbcLoader"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
session = request.getSession(false);

if (session == null || session.getAttribute("uname") == null) {
%>

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
Connection con=JdbcLoader.getconnection();
String sql="select *from laptopinfo";
Statement st=con.createStatement();
ResultSet rs=st.executeQuery(sql);


%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1><%=uname %></h1>
<div></div>
<%while(rs.next())
	{
	%>
	<div class="card">
	<img class="card-img" alt="Image not found" src="<%=rs.getString("laptopimgpath") %>">
	<h1 class="card-head"><%=rs.getString("laptopName") %></h1>
	<p class="card-desc"><%=rs.getString("laptopdesc") %></p>
	<p class="card-price">₹ <span><%=rs.getString("laptopprice") %> </span></p>
	<button>Buy Now</button>
	</div>
	
	
	
	<%} %>
	</div>
</body>
</html>