<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.util.JdbcLoader"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
session = request.getSession(false);

if (session == null || session.getAttribute("uname") == null) {
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Session Expired</title>

<style>
body{
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    background:linear-gradient(135deg,#1e2a38,#00c6ff);
    color:white;
    font-family:Arial;
}
.box{
    padding:40px;
    background:rgba(0,0,0,0.6);
    border-radius:10px;
    text-align:center;
    animation:fadeIn 1s;
}
@keyframes fadeIn{
    from{opacity:0} to{opacity:1}
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

Connection con = JdbcLoader.getconnection();
String sql = "select * from userregister where uname=?";
PreparedStatement st = con.prepareStatement(sql);
st.setString(1, uname);
ResultSet rs = st.executeQuery();
%>

<html lang="en">
<head>
<meta charset="UTF-8">
<title>Profile Dashboard</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',sans-serif;
}

/* BODY */
body{
    display:flex;
    background:#0f2027;
}

/* SIDEBAR */
.sidebar{
    width:230px;
    height:100vh;
    background:#1e2a38;
    padding:20px;
    position:fixed;
}

.logo{
    color:#00c6ff;
    font-size:22px;
    text-align:center;
    margin-bottom:30px;
}

.sidebar a{
    display:block;
    color:white;
    padding:12px;
    margin:10px 0;
    text-decoration:none;
    border-radius:6px;
    transition:0.3s;
}

.sidebar a:hover{
    background:#00c6ff;
    color:black;
    transform:translateX(5px);
}

/* MAIN */
.main{
    margin-left:230px;
    padding:40px;
    width:100%;
}

/* CARD */
.card{
    max-width:450px;
    margin:auto;
    padding:30px;
    border-radius:20px;
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(20px);
    color:white;
    box-shadow:0 10px 30px rgba(0,0,0,0.3);
    animation:slideUp 0.8s ease;
}

@keyframes slideUp{
    from{opacity:0; transform:translateY(40px);}
    to{opacity:1; transform:translateY(0);}
}

.card h2{
    text-align:center;
    margin-bottom:20px;
}

/* INFO */
.info{
    padding:10px;
    margin:10px 0;
    border-bottom:1px solid rgba(255,255,255,0.2);
}

/* BUTTONS */
.actions{
    text-align:center;
    margin-top:20px;
}

.btn{
    padding:10px 15px;
    margin:5px;
    border:none;
    border-radius:5px;
    text-decoration:none;
    transition:0.3s;
}

.edit{
    background:#00c6ff;
    color:black;
}

.delete{
    background:#ff4d4d;
    color:white;
}

.btn:hover{
    transform:scale(1.1);
}
</style>

</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <div class="logo">LaptopShop</div>

    <a href="home.jsp"><i class="fas fa-home"></i> Home</a>
    <a href="products.jsp"><i class="fas fa-laptop"></i> Products</a>
    <a href="about.jsp"><i class="fas fa-info-circle"></i> About</a>
    <a href="myorders.jsp"><i class="fas fa-envelope"></i> Myorders</a>
    <a href="profile.jsp"><i class="fas fa-user"></i> Profile</a>
    <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN -->
<div class="main">

<%
while(rs.next()){
%>

<div class="card">
    <h2>👤 User Profile</h2>

    <div class="info"><b>ID:</b> <%=rs.getInt("uid")%></div>
    <div class="info"><b>Name:</b> <%=rs.getString("name")%></div>
    <div class="info"><b>Email:</b> <%=rs.getString("email")%></div>
    <div class="info"><b>Contact:</b> <%=rs.getString("contact")%></div>
    <div class="info"><b>Username:</b> <%=rs.getString("uname")%></div>
    <div class="info"><b>Password:</b> ******</div>

    <div class="actions">
        <a href="editProfile.jsp" class="btn edit">Edit</a>
        <a href="delete.jsp?uid=<%=rs.getInt("uid")%>" 
           class="btn delete"
           onclick="return confirm('Are you sure to delete?')">
           Delete
        </a>
    </div>
</div>

<% } %>

</div>

</body>
</html>