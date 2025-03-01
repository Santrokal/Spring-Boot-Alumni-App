<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>

<%@ page import="com.shc.alumni.springboot.entity.CompanyEntity" %>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Alumni Job Details Page</title>
<link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/logo.png">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons (Optional) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
	
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


<style>
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
        
            /* Fade-in animation */
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Card animation */
    .card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        animation: fadeIn 1s ease-in-out;
        border-radius: 15px;
        box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
    }

    .card:hover {
        transform: scale(1.05);
        box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.3);
    }

    /* Button effect */
    .btn-success {
        transition: all 0.3s ease-in-out;
        box-shadow: 0px 4px 8px rgba(0, 128, 0, 0.5);
        border-radius: 8px;
    }

    .btn-success:hover {
        transform: scale(1.1);
        box-shadow: 0px 6px 15px rgba(0, 128, 0, 0.7);
    }

    /* Image animation */
    img {
        transition: transform 0.4s ease-in-out;
    }

    img:hover {
        transform: rotateY(15deg) scale(1.1);
        align-items: center;
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
<!-- Career Job Section Starts -->
<!-- Career Job Section Starts -->
<div class="container mt-4">
    <h1 class="text-center mb-4">Job Details</h1>

    <%
        CompanyEntity company = (CompanyEntity) request.getAttribute("company");
        if (company != null) {
            String filePath = company.getFilePath();
            String fileExtension = (filePath != null && filePath.contains(".")) ? 
                                   filePath.substring(filePath.lastIndexOf(".") + 1).toLowerCase() : "";
    %>
        <div class="card mb-4">
            <div class="card-header text-center">
                <h2><%= company.getPosition() %></h2>
                <h4 class="text-muted"><%= company.getLocation() %></h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <img src="data:image/jpeg;base64,<%= company.getImageBase64() %>" 
                             alt="Company Logo" style="max-height: 200px; width: auto;">
                    </div>
                    <div class="col-md-8">
                        <h5><strong>Role:</strong> <%= company.getRole() %></h5>
                        <h5><strong>About the Company:</strong></h5>
                        <p><%= company.getAbout() %></p>
                        <h5><strong>Skills Required:</strong></h5>
                        <p><%= company.getSkills() %></p>
                        <h5><strong>Job Details:</strong></h5>
                        <p><%= company.getJobDetails() %></p>

                        <!-- File Display Section -->
                        <h5><strong>Job Posture / Job Description File:</strong></h5>
                        <%
                            if (filePath != null && !filePath.isEmpty()) {
                                if (fileExtension.equals("jpg") || fileExtension.equals("jpeg") || fileExtension.equals("png")) {
                        %>
                                    <img src="<%= request.getContextPath() %>/downloadFile/<%= company.getId() %>" 
     alt="Uploaded File" style="max-width: 500px; height: 500px;">

                        <%
                                } else if (fileExtension.equals("pdf")) {
                        %>
                                    <iframe src="<%= request.getContextPath() %>/downloadFile/<%= company.getId() %>" 
                                            width="100%" height="500px"></iframe>
                        <%
                                } else {
                        %>
                                    <p>
                                        <a href="<%= request.getContextPath() %>/downloadFile/<%= company.getId() %>" 
                                           class="btn btn-primary" target="_blank">
                                            Download File
                                        </a>
                                    </p>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center">
            <a href="/alumniapplytojob?companyId=<%= company.getId() %>" class="btn btn-success btn-lg">Apply Now</a>
        </div>
    <%
        } else {
    %>
        <p class="text-center">No job details available for this position.</p>
    <%
        }
    %>
</div>


    

<!-- Career Job Section Starts -->


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
</body>
</html>
