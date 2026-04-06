<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="com.util.JdbcLoader"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
session = request.getSession(false);

if (session == null || session.getAttribute("uname") == null) {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session Expired</title>

<style>
body {
    margin:0;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#1e2a38,#00c6ff);
    color:white;
    font-family:Arial;
}
.box {
    padding:40px;
    background:rgba(0,0,0,0.6);
    border-radius:10px;
    text-align:center;
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

/* DB INSERT */
String name=request.getParameter("name");
String desc=request.getParameter("desc");
String price=request.getParameter("price");
String img=request.getParameter("img");

Connection con=JdbcLoader.getconnection();
String sql="insert into myorder(imgpath,lname,ldesc,lprice,orderdate) values(?,?,?,?,?)";

LocalDateTime now=LocalDateTime.now();

PreparedStatement ps=con.prepareStatement(sql);
ps.setString(1, img);
ps.setString(2, name);
ps.setString(3, desc);
ps.setString(4, price);
ps.setTimestamp(5, Timestamp.valueOf(now));

int res=ps.executeUpdate();
boolean success = res > 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Status</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">

<style>

body{
    margin:0;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#1e2a38,#00c6ff);
    font-family:'Poppins',sans-serif;
}

/* CARD */
.box{
    background:rgba(255,255,255,0.1);
    backdrop-filter:blur(15px);
    padding:40px;
    border-radius:15px;
    text-align:center;
    color:white;
    width:360px;
    box-shadow:0 10px 30px rgba(0,0,0,0.3);
    animation:fadeIn 0.8s ease;
}

/* ICON */
.icon{
    font-size:60px;
    margin-bottom:15px;
    animation:pop 0.5s ease;
}

.success{ color:#00ffcc; }
.error{ color:#ff4d4d; }

/* BUTTONS */
.btn{
    margin-top:15px;
    padding:10px 20px;
    border:none;
    border-radius:25px;
    background:white;
    color:#1e2a38;
    font-weight:bold;
    cursor:pointer;
    transition:0.3s;
}

.btn:hover{
    background:#00c6ff;
    color:white;
}

/* SECOND BUTTON */
.btn-orders{
    display:block;
    margin-top:10px;
    background:transparent;
    border:2px solid white;
    color:white;
}

.btn-orders:hover{
    background:white;
    color:#1e2a38;
}

/* ANIMATION */
@keyframes fadeIn{
    from{opacity:0; transform:translateY(20px);}
    to{opacity:1; transform:translateY(0);}
}

@keyframes pop{
    from{transform:scale(0);}
    to{transform:scale(1);}
}

</style>

<!-- AUTO REDIRECT -->
<script>
setTimeout(()=>{
    window.location.href="products.jsp";
},4000);
</script>

</head>

<body>

<div class="box">

<% if(success){ %>

    <div class="icon success">✔</div>
    <h2>Order Placed Successfully!</h2>
    <p>Your product has been ordered 🎉</p>

<% } else { %>

    <div class="icon error">✖</div>
    <h2>Order Failed!</h2>
    <p>Please try again.</p>

<% } %>

<!-- BUTTONS -->
<button class="btn" onclick="window.location.href='products.jsp'">
    Continue Shopping
</button>

<button class="btn btn-orders" onclick="window.location.href='myorders.jsp'">
    View My Orders
</button>

</div>

</body>
</html>