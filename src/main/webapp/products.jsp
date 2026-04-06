<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.util.JdbcLoader"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    text-align:center;
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
<p>Redirecting to login...</p>
</div>

</body>
</html>

<%
return;
}

String uname = (String) session.getAttribute("uname");

Connection con = JdbcLoader.getconnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("select * from laptopinfo");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:#f4f6f9;
}

/* NAVBAR (same as home) */
.navbar{
    background:#1e2a38;
    color:#fff;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:15px 40px;
}

.logo{
    font-size:24px;
    font-weight:bold;
    color:#00c6ff;
}

.nav-links{
    display:flex;
    gap:25px;
    align-items:center;
}

.nav-links a{
    color:white;
    text-decoration:none;
    transition:0.3s;
}

.nav-links a:hover{
    color:#00c6ff;
}

.logout{
    color:#ff4d4d;
    font-size:18px;
}

/* PAGE TITLE */
.title{
    text-align:center;
    margin:30px 0;
    font-size:28px;
    color:#1e2a38;
}

/* GRID */
.container{
    padding:0 40px 40px;
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:25px;
}

/* CARD (same theme as home) */
.card{
    background:#fff;
    border-radius:10px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    overflow:hidden;
    transition:0.3s;
    animation:fadeIn 0.8s ease;
}

.card:hover{
    transform:translateY(-10px);
}

.card img{
    width:100%;
    height:180px;
    object-fit:cover;
}

.card-body{
    padding:15px;
}

.card-body h3{
    margin-bottom:10px;
}

.card-desc{
    font-size:14px;
    color:#555;
    margin-bottom:10px;
}

.price{
    color:#00a86b;
    font-weight:bold;
    margin-bottom:10px;
}

.btn{
    background:#1e2a38;
    color:white;
    padding:8px 15px;
    border:none;
    cursor:pointer;
    border-radius:5px;
    transition:0.3s;
}

.btn:hover{
    background:#00c6ff;
}

/* Animation */
@keyframes fadeIn{
    from{opacity:0; transform:translateY(20px);}
    to{opacity:1; transform:translateY(0);}
}

</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">LaptopShop</div>
    <div class="nav-links">
        <a href="home.jsp">Home</a>
        <a href="products.jsp">Products</a>
        <a href="about.html">About</a>
        <a href="contact.html">Contact</a>
        <a href="profile.jsp">Profile</a>
        <a href="logout.jsp" class="logout"><i class="fas fa-sign-out-alt"></i></a>
    </div>
</div>

<!-- TITLE -->
<div class="title">
    Welcome, <%=uname %> 👋 | Our Products
</div>

<!-- PRODUCTS -->
<div class="container">

<%
while(rs.next()) {
%>
<div class="card">
    <img src="<%=rs.getString("laptopimgpath") %>" alt="Laptop">
    
    <div class="card-body">
        <h3><%=rs.getString("laptopName") %></h3>
        <p class="card-desc"><%=rs.getString("laptopdesc") %></p>
        <div class="price">₹ <%=rs.getString("laptopprice") %></div>

        <!-- FORM START -->
        <form action="confirmOrder.jsp" method="post">
            
            <input type="hidden" name="name" value="<%=rs.getString("laptopName") %>">
            <input type="hidden" name="desc" value="<%=rs.getString("laptopdesc") %>">
            <input type="hidden" name="price" value="<%=rs.getString("laptopprice") %>">
            <input type="hidden" name="img" value="<%=rs.getString("laptopimgpath") %>">

            <button type="submit" class="btn">Buy Now</button>
        </form>
        <!-- FORM END -->

    </div>
</div>

<%
}
%>

</div>

</body>
</html>