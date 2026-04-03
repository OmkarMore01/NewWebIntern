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
    background: linear-gradient(135deg, #1e2a38, #00c6ff);
    font-family: Arial, sans-serif;
    color: white;
}

.box {
    text-align: center;
    padding: 40px;
    background: rgba(0,0,0,0.6);
    border-radius: 10px;
    animation: fadeIn 1s ease-in-out;
}

h2 {
    margin-bottom: 10px;
}

p {
    opacity: 0.8;
}

.loader {
    margin: 20px auto;
    border: 5px solid #fff;
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
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}
</style>

<script>
setTimeout(function(){
    window.location.href = "Login.html";
}, 3000); // redirect after 3 seconds
</script>

</head>
<body>

<div class="box">
    <h2>⚠ Session Expired</h2>
    <p>You are not logged in. Redirecting to login page...</p>
    <div class="loader"></div>
</div>

</body>
</html>

<%
    return;
}

String uname = (String) session.getAttribute("uname");
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LaptopShop - Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: #f4f6f9;
        }

        /* NAVBAR */
        .navbar {
            background: #1e2a38;
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 40px;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #00c6ff;
        }

        .nav-links {
            display: flex;
            gap: 25px;
            align-items: center;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            transition: 0.3s;
        }

        .nav-links a:hover {
            color: #00c6ff;
        }

        .logout {
            color: #ff4d4d;
            font-size: 18px;
        }

        /* SLIDER */
        .slider {
            width: 100%;
            height: 400px;
            overflow: hidden;
            position: relative;
        }

        .slides {
            display: flex;
            width: 300%;
            animation: slide 12s infinite;
        }

        .slides img {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }

        @keyframes slide {
            0% {margin-left: 0;}
            33% {margin-left: -100%;}
            66% {margin-left: -200%;}
            100% {margin-left: 0;}
        }

        /* CARD SECTION */
        .container {
            padding: 40px;
        }

        .title {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            color: #1e2a38;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
        }

        .card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transition: 0.3s;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-10px);
        }

        .card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }

        .card-body {
            padding: 15px;
        }

        .card-body h3 {
            margin-bottom: 10px;
        }

        .price {
            color: #00a86b;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .btn {
            background: #1e2a38;
            color: white;
            padding: 8px 15px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: 0.3s;
        }

        .btn:hover {
            background: #00c6ff;
        }

        /* FOOTER */
        .footer {
            background: #1e2a38;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
        }

    </style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">LaptopShop</div>
    <div class="nav-links">
        <a href="#">Home</a>
        <a href="products.jsp">Products</a>
        <a href="about.html">About</a>
        <a href="contact.html">Contact</a>
         <a href="profile.jsp">Profile</a>
        <a href="logout.jsp" class="logout"><i class="fas fa-sign-out-alt"></i></a>
    </div>
</div>

<!-- SLIDER -->
<div class="slider">
    <div class="slides">
        <img src="https://images.unsplash.com/photo-1517336714731-489689fd1ca8">
        <img src="https://images.unsplash.com/photo-1496181133206-80ce9b88a853">
        <img src="https://images.unsplash.com/photo-1519389950473-47ba0277781c">
    </div>
</div>

<!-- CARDS -->
<div class="container">
    <div class="title">Latest Laptops</div>

    <div class="cards">

        <div class="card">
            <img src="https://images.unsplash.com/photo-1587202372775-e229f172b9d7">
            <div class="card-body">
                <h3>Dell XPS 13</h3>
                <div class="price">₹95,000</div>
                <button class="btn">Buy Now</button>
            </div>
        </div>

        <div class="card">
            <img src="https://images.unsplash.com/photo-1517336714731-489689fd1ca8">
            <div class="card-body">
                <h3>HP Pavilion</h3>
                <div class="price">₹70,000</div>
                <button class="btn">Buy Now</button>
            </div>
        </div>

        <div class="card">
            <img src="https://images.unsplash.com/photo-1496181133206-80ce9b88a853">
            <div class="card-body">
                <h3>Lenovo ThinkPad</h3>
                <div class="price">₹85,000</div>
                <button class="btn">Buy Now</button>
            </div>
        </div>

        <div class="card">
            <img src="https://images.unsplash.com/photo-1519389950473-47ba0277781c">
            <div class="card-body">
                <h3>MacBook Air</h3>
                <div class="price">₹1,10,000</div>
                <button class="btn">Buy Now</button>
            </div>
        </div>

    </div>
</div>

<!-- FOOTER -->
<div class="footer">
    <p>© 2026 LaptopShop | All Rights Reserved</p>
</div>

</body>
</html>