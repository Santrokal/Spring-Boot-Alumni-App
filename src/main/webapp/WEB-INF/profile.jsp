<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Alumni Profile</title>
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/logo.png">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
           <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
       
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Custom Styles */
        body {
            background-color: #f1f9fb;
            font-family: Arial, sans-serif;
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
        .btn-custom {
            background-color: #fca311;
            color: #14213d;
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
            color: red;
        }
        .alumni-photo {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 50%;
        }
                .profile-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
        }
        .h4{
        align-items:center;
        }
    </style>
</head>
<body>
<!-- Header Section -->
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
						class="nav-link dropdown-toggle" href="/about" id="aboutDropdown"
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
							<li><a class="dropdown-item" href="/stories">Alumni Story</a></li>
							<li><a class="dropdown-item" href="#">Latest Members</a></li>
							<li><a class="dropdown-item" href="/profile">Alumni Profile</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="/stories"
						id="storiesDropdown" role="button" data-bs-toggle="dropdown">Alumni
							Stories</a>
						<ul class="dropdown-menu">
							<!-- <li><a class="dropdown-item" href="#">Required Materials</a></li> -->
							<!-- <li><a class="dropdown-item" href="#">World Level
									Mentors</a></li> -->
							<li><a class="dropdown-item" href="#">Our Recurits</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="careerDropdown"
						role="button" data-bs-toggle="dropdown">Career Opportunity</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="/applyjob">Apply To Job</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link" href="/profile">Profile</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
<!-- Header Section Ends -->

</head>
<body>
<form action="/editprofile" method="GET"> 
    <div class="container">
        <h2 class="text-center">Alumni Profile</h2>
        
        <!-- Profile Picture -->
<div class="text-center">
    <img src="${image}" alt="Profile Image" style="width: 150px; height: 150px; border-radius: 50%;" onerror="this.onerror=null; this.src='/default-profile.png';" />
</div>
        <!-- Personal Information -->
        <h4><b>Personal Information</b></h4>
        <table class="table">
            <tr><th>Full Name</th><td>${fullname}</td></tr>
            <tr><th>Member Id</th><td>${fullname}</td></tr>
            <tr><th>Father's Name</th><td>${fathersname}</td></tr>
            <tr><th>Nationality</th><td>${nationality}</td></tr>
            <tr><th>Date of Birth</th><td>${dob}</td></tr>
            <tr><th>Gender</th><td>${gender}</td></tr>
            <tr><th>Shift</th><td>${shift}</td></tr>
            <tr><th>Degree Obtained</th><td>${degree_obtained}</td></tr>
            <tr><th>Department</th><td>${department}</td></tr>
            <tr><th>SHC Stay From</th><td>${shc_stay_from}</td></tr>
            <tr><th>SHC Stay To</th><td>${shc_stay_to}</td></tr>
            <tr><th>Marital Status</th><td>${marital_status}</td></tr>
            <tr><th>Anniversary Year</th><td>${anniversary_year}</td></tr>
            <tr><th>Whatsapp Number</th><td>${whatsappno}</td></tr>
            <tr><th>Phone Number</th><td>${phoneno}</td></tr>
            <tr><th>Email Address</th><td>${emailaddress}</td></tr>
            <tr><th>House Flat Number</th><td>${house_flat_number}</td></tr>
            <tr><th>Street Name</th><td>${street_name}</td></tr>
            <tr><th>City Name</th><td>${city}</td></tr>
            <tr><th>State Name</th><td>${state}</td></tr>
            <tr><th>Postal Code</th><td>${postal_code}</td></tr>
            <tr><th>Landmark</th><td>${landmark}</td></tr>
            <tr><th>Area Name</th><td>${area}</td></tr>
            <tr><th>Address Type</th><td>${address_type}</td></tr>
        </table>
        
        <!-- Work Information -->
        <h4><b>Work Information</b></h4>
        <table class="table">
            <tr><th>Employment Status</th><td>${empstatus}</td></tr>
            <tr><th>Job Designation</th><td>${jobdesig}</td></tr>
            <tr><th>Office Phone Number</th><td>${officephoneno}</td></tr>
            <tr><th>Office Email</th><td>${officeemail}</td></tr>
            <tr><th>Field of Expertise</th><td>${fieldofexpert}</td></tr>
        </table>
        
        <!-- Edit Profile Button -->
<div class="text-center">
    <a href="/editprofile" class="btn btn-primary">Edit Profile</a>
</div>

    </div>
</form>

                    
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

<!-- Add Font Awesome for Social Icons -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
                    
</body>
</html>
