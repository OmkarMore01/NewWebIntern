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
body {
    margin: 0;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(135deg, #141e30, #243b55);
    font-family: 'Segoe UI', sans-serif;
    color: white;
}

.card {
    backdrop-filter: blur(15px);
    background: rgba(255,255,255,0.1);
    padding: 40px;
    border-radius: 15px;
    text-align: center;
    animation: fadeIn 1s ease;
}

.loader {
    margin-top: 20px;
    border: 5px solid rgba(255,255,255,0.3);
    border-top: 5px solid #00c6ff;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    100% { transform: rotate(360deg); }
}

@keyframes fadeIn {
    from { opacity: 0; transform: scale(0.8);}
    to { opacity: 1; transform: scale(1);}
}
</style>

<script>
setTimeout(() => {
    window.location.href = "Login.html";
}, 3000);
</script>

</head>
<body>

<div class="card">
    <h2>⚠ Session Expired</h2>
    <p>Redirecting to login...</p>
    <div class="loader"></div>
</div>

</body>
</html>

<%
return;
}

String uname = (String) session.getAttribute("uname");
int uid = Integer.parseInt(request.getParameter("uid"));

Connection con = JdbcLoader.getconnection();
String sql = "delete from userregister where uid=?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, uid);
int res = ps.executeUpdate();
%>

<html>
<head>
<meta charset="UTF-8">
<title>Delete Status</title>

<style>
body {
    margin: 0;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
    font-family: 'Segoe UI', sans-serif;
}

/* GLASS CARD */
.card {
    width: 350px;
    padding: 40px;
    border-radius: 20px;
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(20px);
    text-align: center;
    color: white;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    animation: pop 0.6s ease;
}

.icon {
    font-size: 60px;
    margin-bottom: 20px;
    animation: bounce 1s;
}

.success {
    color: #00ffcc;
}

.error {
    color: #ff4d4d;
}

@keyframes pop {
    from { transform: scale(0.7); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
}

@keyframes bounce {
    0%,100% { transform: translateY(0);}
    50% { transform: translateY(-10px);}
}

.msg {
    font-size: 20px;
    margin-bottom: 10px;
}

.sub {
    font-size: 14px;
    opacity: 0.7;
}
</style>

<script>
setTimeout(() => {
    window.location.href = "logout.jsp";
}, 2500);
</script>

</head>
<body>

<div class="card">

<%
if (res > 0) {
%>
    <div class="icon success">✔</div>
    <div class="msg">User Deleted Successfully</div>
    <div class="sub">Redirecting to dashboard...</div>
<%
} else {
%>
    <div class="icon error">✖</div>
    <div class="msg">Delete Failed</div>
    <div class="sub">Please try again...</div>
<%
}
%>

</div>

</body>
</html>