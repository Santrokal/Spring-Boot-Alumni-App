<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Alumni Apply to Job Application Page</title>
<link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/logo.png">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons (Optional) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
	
<!-- Font Awesome CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	rel="stylesheet">
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Font Awesome CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	rel="stylesheet">
<!-- Animate.css for Animations -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<style>
    /* Global Styles */
    body {
        background: linear-gradient(145deg, #f3f4f6, #dfe3e8);
        font-family: Arial, sans-serif;
        overflow-x: hidden;
    }

    .container-1 {
        max-width: 600px;
        margin: auto;
        background: linear-gradient(145deg, #ffffff, #e6e9ef);
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.2), inset 0px -4px 8px rgba(255, 255, 255, 0.5);
        transform: perspective(1000px) rotateX(5deg);
        animation: fadeInUp 1s ease-in-out;
    }

    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .account-title h4 {
        font-weight: bold;
        color: #333;
        text-align: center;
        margin-bottom: 20px;
        animation: bounceIn 1s ease-in-out;
    }

    @keyframes bounceIn {
        0% {
            transform: scale(0.9);
            opacity: 0;
        }
        50% {
            transform: scale(1.1);
            opacity: 0.7;
        }
        100% {
            transform: scale(1);
            opacity: 1;
        }
    }

    label {
        font-weight: bold;
        color: #555;
        display: block;
        margin-bottom: 5px;
        animation: fadeInLeft 1s;
    }

    .form-control {
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 10px;
        box-shadow: inset 2px 2px 4px rgba(0, 0, 0, 0.1);
        transition: all 0.3s;
    }

    .form-control:focus {
        outline: none;
        border-color: #007bff;
        box-shadow: 0 0 10px rgba(0, 123, 255, 0.8);
    }

    .form-control:hover {
        transform: translateZ(5px);
    }

    .btn-custom {
        background: linear-gradient(145deg, #007bff, #0056b3);
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 12px;
        font-size: 1.2rem;
        font-weight: bold;
        text-transform: uppercase;
        cursor: pointer;
        transition: all 0.3s ease-in-out;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
    }

    .btn-custom:hover {
        transform: translateY(-3px) scale(1.05);
        background: linear-gradient(145deg, #0056b3, #003a80);
        box-shadow: 0 6px 10px rgba(0, 0, 0, 0.3);
    }

    .btn-custom:active {
        transform: translateY(2px) scale(0.95);
        box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
    }

    .form-control-file {
        border: 2px dashed #007bff;
        padding: 15px;
        border-radius: 10px;
        cursor: pointer;
        transition: all 0.3s ease;
        text-align: center;
    }

    .form-control-file:hover {
        background-color: #f8f9fa;
        border-color: #0056b3;
        box-shadow: 0 0 8px rgba(0, 123, 255, 0.6);
    }

       /* Custom Styles */
        body {
            background-color: #f1f9fb;
            font-family: Arial, sans-serif;
        }
        
              /* Fade-in Animation */
        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }
        
    .container-1 {
            max-width: 500px;
            margin: auto;
            background: #ffffff;
            padding: 20px;
            align:center;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1s forwards; 
            opacity: 0; /* Initially hidden */
        }

        
        input[type="text"],
        textarea,
        input[type="file"] {
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input[type="text"]:focus,
        textarea:focus,
        input[type="file"]:focus {
            border-color: #fca311;
            box-shadow: 0 0 5px rgba(252, 163, 17, 0.7);
        }

        label {
            font-size: 1.1em;
            font-weight: bold;
            color: #333;
            transition: color 0.3s ease;
        }

        input[type="text"]:hover,
        textarea:hover {
            color: #fca311;
        }

        .btn-custom {
            background-color: #fca311;
            color: #14213d;
            align:center;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .btn-custom:hover {
            transform: scale(1.05);
            
            background-color: #e89d08;
        }

        .navbar {
            background-color: #343a40;
        }

        .navbar-brand, .nav-link {
            color: white !important;
        }

        .navbar-brand:hover, .nav-link:hover {
            color: #ffc107 !important;
        }

        .carousel-item {
            height: 500px;
            background-size: cover;
            background-position: center;
        }

        .carousel-caption {
            background-color: rgba(0, 0, 0, 0.5);
            padding: 10px;
            border-radius: 5px;
        }



        .login-button {
            transition: all 0.3s ease-in-out;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }

        .login-button:hover {
            transform: translateY(-3px);
            box-shadow: 0px 6px 8px rgba(0, 0, 0, 0.2);
            background-color: #e89d08;
        }

        .hover-effect {
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .hover-effect:hover {
            transform: scale(1.05);
            color: #007bff;
        }

        table {
            width: 100%;
            margin-top: 20px;
            background-color: white;
            color: black;
            border-collapse: collapse;
            border: 1px solid #ddd;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #6a11cb;
            color: white;
        }

        .alumni-photo {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 50%;
        }
    
    
</style>
</head>
<body>

	<!-- Header Section Starts -->
	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark">
		<div class="container">
			<a class="navbar-brand" href="/home">Sacred Heart College
				Autonomous</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="aboutDropdown"
						role="button" data-bs-toggle="dropdown">About Us</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="/contactus">Contact</a></li>
							<li><a class="dropdown-item" href="/directory">Directory</a></li>
							<li><a class="dropdown-item" href="#">Gallery</a></li>
							<li><a class="dropdown-item" href="/news">News</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="programDropdown"
						role="button" data-bs-toggle="dropdown">Program & Events</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">Sponsorship</a></li>
							<li><a class="dropdown-item" href="#">Latest Members</a></li>
							<li><a class="dropdown-item" href="#">Alumni Profile</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="/stories"
						id="storiesDropdown" role="button" data-bs-toggle="dropdown">Alumni
							Stories</a>
						<ul class="dropdown-menu">
							<!-- <li><a class="dropdown-item" href="#">Required Materials</a></li> -->
							<li><a class="dropdown-item" href="#">World Level
									Mentors</a></li>
							<li><a class="dropdown-item" href="#">Our Recruits</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="careerDropdown"
						role="button" data-bs-toggle="dropdown">Career Opportunity</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">Apply To Job</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link" href="/profile">Profile</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Header Section Ends -->

<div class="container-1 mt-5">
    <div class="account-title">
        <h4>Apply for the Job</h4>
    </div>

    <form action="/submitJobApplication" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="companyId" value="${companyId}">
        <input type="hidden" name="companyemailid" value="company@example.com">

        <div class="form-group mb-4">
            <label for="fullname"><span style="color: red;">*</span>Full Name</label>
            <input type="text" class="form-control" id="fullname" name="fullname" required>
        </div>

        <div class="form-group mb-4">
            <label for="phonenumber"><span style="color: red;">*</span>Phone Number</label>
            <input type="text" class="form-control" id="phonenumber" name="phonenumber" required>
        </div>

        <div class="form-group mb-4">
            <label for="emailaddress"><span style="color: red;">*</span>Email Address</label>
            <input type="email" class="form-control" id="emailaddress" name="emailaddress" required>
        </div>

        <div class="form-group mb-4">
            <label for="resume"><span style="color: red;">*</span>Upload Resume</label>
            <input type="file" class="form-control-file" id="resume" name="resume" required>
        </div>

        <button type="submit" class="btn btn-custom w-100">Submit Application</button>
    </form>
</div>

	<!-- Footer Section -->
	<!-- Footer Section -->
	<footer class="bg-light py-5">
		<div class="container">
			<div class="row text-center text-md-start">
				<!-- Logo and Description -->
				<div class="col-md-3 mb-4 mb-md-0">
					<img src="<%= request.getContextPath() %>/images/logo.png" alt="Hello" class="mb-3 logo-animate" style="max-width: 150px;">
					<p>Alumni Association of the Sacred Heart College.</p>
				</div>
				<!-- University Links -->
				<div class="col-md-3 mb-4 mb-md-0">
					<h5 class="fw-bold">UNIVERSITY</h5>
					<ul class="list-unstyled">
						<li><a href="#"
							class="text-dark text-decoration-none animated-link">Events</a></li>
						<li><a href="/directory"
							class="text-dark text-decoration-none animated-link">Gallery</a></li>
						<li><a href="/news"
							class="text-dark text-decoration-none animated-link">News</a></li>
					</ul>
				</div>
				<!-- Alumni Links -->
				<div class="col-md-3 mb-4 mb-md-0">
					<h5 class="fw-bold">ALUMNI</h5>
					<ul class="list-unstyled">
						<li><a href="/contactus"
							class="text-dark text-decoration-none animated-link">Contacts</a></li>
						<li><a href="/applyjob"
							class="text-dark text-decoration-none animated-link">Career</a></li>
						<li><a href="/about"
							class="text-dark text-decoration-none animated-link">About Us</a></li>
					</ul>
				</div>
				<!-- Account Links -->
				<div class="col-md-3 mb-4 mb-md-0">
					<h5 class="fw-bold">ACCOUNT</h5>
					<ul class="list-unstyled">
						<li><a href="/profile"
							class="text-dark text-decoration-none animated-link">Profile</a></li>
						<li><a href="/stories"
							class="text-dark text-decoration-none animated-link">Stories</a></li>
						<li><a href="#"
							class="text-dark text-decoration-none animated-link">Downloads</a></li>
					</ul>
				</div>
			</div>
			
			
			<div class="row mt-4 align-items-center">
				<!-- Alumni Account Button -->
				<div class="col-md-3 text-center text-md-start"></div>
				<!-- Social Media Icons -->
<div class="col-md-6 text-center my-3 gap-7 my-md-0 space-x-4">
    <a href="#" class="text-[#1877F2] text-4xl hover:scale-125 gap-6 transition-transform duration-300 hover:drop-shadow-lg">
<i class="bi bi-facebook" style="font-size: 2rem; color: #1877F2;"></i>
    </a> 
    <a href="#" class="text-[#25D366] text-4xl gap-6 hover:scale-125 transition-transform duration-300 hover:drop-shadow-lg">
        <i class="bi bi-youtube" style="font-size: 2rem; color: red;"></i>

    </a>
    <a href="#" class="text-[#E4405F] text-4xl hover:scale-125 transition-transform duration-300 hover:drop-shadow-lg">
<i class="bi bi-instagram" style="font-size: 2rem; color: #C13584;"></i>
    </a> 
    <a href="#" class="text-black text-4xl hover:scale-125 transition-transform duration-300 hover:drop-shadow-lg">
        <i class="fa-brands fa-x-twitter" style="font-size: 2rem;"></i>
    </a>
    <a href="#" class="text-[#0A66C2] text-4xl hover:scale-125 transition-transform duration-300 hover:drop-shadow-lg">
        <i class="fa-brands fa-linkedin" style="font-size: 2rem;"></i>
    </a>
</div>


				<!-- Copyright -->
				<div class="col-md-3 text-center text-md-end">
					<p class="text-muted mb-0">&copy;2024 Alumni Association</p>
				</div>
			</div>
		</div>
	</footer>
	<script src="https://kit.fontawesome.com/a076d05399.js"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Bootstrap and JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
