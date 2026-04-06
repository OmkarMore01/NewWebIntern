<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
</div>
</body>
</html>

<%
return;
}

Connection con = JdbcLoader.getconnection();
String sql = "select * from myorder order by oid desc";
PreparedStatement ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery();

/* CALCULATE TOTAL */
int total = 0;
while(rs.next()){
    total += Integer.parseInt(rs.getString("lprice"));
}

/* RE-RUN QUERY */
rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders</title>

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
    background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
}

/* SIDEBAR */
.sidebar{
    width:230px;
    height:100vh;
    background:#111827;
    padding:20px;
    position:fixed;
}

.logo{
    color:#00e5ff;
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
    background:#00e5ff;
    color:black;
    transform:translateX(5px);
}

/* MAIN */
.main{
    margin-left:230px;
    padding:30px;
    width:100%;
}

/* TOTAL BOX */
.total-box{
    background:linear-gradient(135deg,#00c6ff,#0072ff);
    padding:25px;
    border-radius:15px;
    color:white;
    margin-bottom:30px;
    box-shadow:0 10px 30px rgba(0,0,0,0.3);
    animation:slideDown 0.8s ease;
}

.total-box h2{
    font-size:22px;
}

.amount{
    font-size:32px;
    font-weight:bold;
    margin-top:10px;
}

/* GRID */
.orders{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:20px;
}

/* CARD */
.card{
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(15px);
    border-radius:15px;
    overflow:hidden;
    color:white;
    box-shadow:0 8px 25px rgba(0,0,0,0.3);
    transition:0.3s;
    animation:fadeIn 0.6s ease;
}

.card:hover{
    transform:translateY(-10px) scale(1.02);
}

/* IMAGE */
.card img{
    width:100%;
    height:180px;
    object-fit:cover;
}

/* BODY */
.card-body{
    padding:15px;
}

.card-body h3{
    margin-bottom:8px;
}

.desc{
    font-size:14px;
    opacity:0.8;
    margin-bottom:8px;
}

.price{
    color:#00ffcc;
    font-weight:bold;
}

.date{
    font-size:12px;
    opacity:0.7;
}

/* ANIMATION */
@keyframes fadeIn{
    from{opacity:0; transform:translateY(20px);}
    to{opacity:1; transform:translateY(0);}
}

@keyframes slideDown{
    from{opacity:0; transform:translateY(-30px);}
    to{opacity:1; transform:translateY(0);}
}

</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <div class="logo">LaptopShop</div>

    <a href="home.jsp"><i class="fas fa-home"></i> Home</a>
    <a href="products.jsp"><i class="fas fa-laptop"></i> Products</a>
    <a href="myorders.jsp"><i class="fas fa-box"></i> My Orders</a>
    <a href="profile.jsp"><i class="fas fa-user"></i> Profile</a>
    <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN -->
<div class="main">

<!-- TOTAL -->
<div class="total-box">
    <h2>Total Payable Amount</h2>
    <div class="amount" id="amount">₹ 0</div>
</div>

<!-- ORDERS -->
<div class="orders">

<%
while(rs.next()){
%>

<div class="card">
    <img src="<%=rs.getString("imgpath") %>">

    <div class="card-body">
        <h3><%=rs.getString("lname") %></h3>
        <div class="desc"><%=rs.getString("ldesc") %></div>
        <div class="price">₹ <%=rs.getString("lprice") %></div>
        <div class="date"><%=rs.getString("orderdate") %></div>
    </div>
</div>

<%
}
%>

</div>

</div>

<!-- ANIMATION SCRIPT -->
<script>
let finalAmount = <%=total%>;
let current = 0;
let speed = Math.ceil(finalAmount / 50);

let counter = setInterval(() => {
    current += speed;
    if(current >= finalAmount){
        current = finalAmount;
        clearInterval(counter);
    }
    document.getElementById("amount").innerText = "₹ " + current;
}, 30);
</script>

</body>
</html>