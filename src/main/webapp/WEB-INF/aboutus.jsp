<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Alumni About</title>
<link rel="icon" type="image/x-icon"
	href="<%= request.getContextPath() %>/logo.png">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Bootstrap Icons (Optional) -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
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

.programs-services {
	padding: 50px 0;
}

.services-img img {
	max-width: 100%;
	height: auto;
	border-radius: 10px;
}

/* Tab Styling */
.nav-tabs {
	margin-bottom: 20px;
}

.nav-tabs>li>a {
	color: #333;
	font-weight: bold;
}

.nav-tabs>li.active>a {
	color: #f0ad4e;
}

.tab-content {
	position: relative;
	min-height: 200px; /* Ensure tab panes don't collapse */
}

.tab-pane {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	padding: 15px;
	display: none; /* Hidden by default */
}

.tab-pane.active {
	display: block; /* Display only the active tab */
	animation: backToFront 0.8s ease-in-out;
}

/* Back-to-Front Animation */
@
keyframes backToFront { 0% {
	transform: translateZ(-50px) rotateX(-90deg);
	opacity: 0;
}

50
%
{
transform
:
translateZ(
0
)
rotateX(
-45deg
);
opacity
:
0.5;
}
100
%
{
transform
:
translateZ(
0
)
rotateX(
0deg
);
opacity
:
1;
}
}
.list-item {
	list-style: none;
	padding: 0;
}

.list-item li {
	margin-bottom: 10px;
	padding-left: 20px;
	position: relative;
}

.list-item li::before {
	content: "\2022";
	color: #f0ad4e;
	font-size: 18px;
	position: absolute;
	left: 0;
}

.container-1 {
	max-width: 500px;
	margin: auto;
	background: #ffffff;
	padding: 20px;
	align: center;
	border-radius: 8px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
	animation: fadeIn 1s forwards;
	opacity: 0; /* Initially hidden */
}

input[type="text"], textarea, input[type="file"] {
	transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

input[type="text"]:focus, textarea:focus, input[type="file"]:focus {
	border-color: #fca311;
	box-shadow: 0 0 5px rgba(252, 163, 17, 0.7);
}

label {
	font-size: 1.1em;
	font-weight: bold;
	color: #333;
	transition: color 0.3s ease;
}

input[type="text"]:hover, textarea:hover {
	color: #fca311;
}

.btn-custom {
	background-color: #fca311;
	color: #14213d;
	align: center;
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

/* 3D Text and Content Animation */
.animate-3d {
	font-family: 'Arial', sans-serif;
	text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.animate-3d:hover {
	transform: scale(1.1) rotateX(10deg) rotateY(10deg);
	box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.5);
}

/* 3D Image Animation */
.animate-3d-image {
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	border-radius: 8px;
}

.animate-3d-image:hover {
	transform: scale(1.05) rotateX(5deg) rotateY(5deg);
	box-shadow: 5px 10px 20px rgba(0, 0, 0, 0.5);
}

/* Section Container */
.container {
	perspective: 1000px;
}

/* Style for nav-tabs */
.nav-tabs {
	display: flex;
	justify-content: flex-start;
	border-bottom: 2px solid #f0f0f0;
}

.nav-tabs li {
	margin-right: 15px;
}

.nav-tabs a {
	text-decoration: none;
	font-weight: 500;
	color: #333;
	padding: 5px 0;
	border-bottom: 2px solid transparent;
	transition: all 0.3s ease-in-out;
}

.nav-tabs a:hover, .nav-tabs .active a {
	color: #ffcc00; /* Active tab text color */
	border-bottom: 2px solid #ffcc00; /* Underline for active tab */
}

/* Style for list items */
.list-item li {
	position: relative;
	padding-left: 25px;
	margin-bottom: 10px;
	font-size: 16px;
	color: #555;
}

.list-item li:before {
	content: "";
	position: absolute;
	left: 0;
	top: 8px;
	width: 12px;
	height: 12px;
	background-color: #ffcc00;
	border-radius: 50%;
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
							<li><a class="dropdown-item" href="/stories">Alumni
									Story</a></li>
							<li><a class="dropdown-item" href="#">Latest Members</a></li>
							<li><a class="dropdown-item" href="/profile">Alumni
									Profile</a></li>
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
							<li><a class="dropdown-item" href="/applyjob">Apply To
									Job</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link" href="/profile">Profile</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Header Section Ends -->

	<!-- About Us Section Starts -->
	<div class="about-us">
		<div class="about-us-title text-center"
			style="background-image: url('https://sayidan.kenzap.com/wp-content/uploads/2016/07/cover-image-3.jpg'); height: 400px; width: 1260px;">
			<h1 class="heading-bold text-uppercase animate-3d">ABOUT US</h1>
		</div>

		<div class="about-us-content">
			<div class="container">
				<div class="content-wrapper">
					<br>
					<!-- <p class="text-light animate-3d">Duihs autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat...</p> -->
				</div>
			</div>
		</div>
	</div>

	<!-- Programs & Services Section -->
	<div class="programs-services">
		<div class="container">
			<div class="row">
				<!-- Image Section -->
				<div class="services-img">
					<img decoding="async" class="img-responsive animate-on-scroll"
						src="https://images.pexels.com/photos/7942545/pexels-photo-7942545.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
						alt="Programs &amp; Services">
				</div>

				<!-- Content Section -->
				<div class="services-content">
					<h2 class="heading-regular">Programs &amp; Services</h2>
					<div id="tab_services">
						<ul class="nav nav-tabs animate-3d" role="tablist">
							<li role="presentation" class="active"><a href="#tab6841"
								data-toggle="tab">Social</a></li>
							<li role="presentation"><a href="#tab6842" data-toggle="tab">Professional</a>
							</li>
							<li role="presentation"><a href="#tab6843" data-toggle="tab">Intellectual</a>
							</li>
						</ul>
						<div class="tab-content">
							<!-- Tab 1 -->
							<div role="tabpanel"
								class="tab-pane animated back-to-front active" id="tab6841">
								<ul class="list-item text-light">
									<li>Feugiat nulla facilisis at vero eros et accumsan et
										iusto.</li>
									<li>Luptatum zzril delenit augue duis dolore.</li>
									<li>Vulputate velit esse molestie consequat.</li>
									<li>Delenit augue duis dolore vulputate velit esse
										molestie consequat</li>
								</ul>
							</div>
							<!-- Tab 2 -->
							<div role="tabpanel" class="tab-pane animated back-to-front"
								id="tab6842">
								<ul class="list-item text-light">
									<li>Social programs are designed to foster relationships.</li>
									<li>Help in professional development through networking.</li>
									<li>Encourage intellectual curiosity and growth.</li>
									<li>Explore diverse learning opportunities.</li>
								</ul>
							</div>
							<!-- Tab 3 -->
							<div role="tabpanel" class="tab-pane animated back-to-front"
								id="tab6843">
								<ul class="list-item text-light">
									<li>Intellectual engagement through programs and events.</li>
									<li>Opportunities to explore various academic fields.</li>
									<li>Participation in workshops and seminars.</li>
									<li>Encouragement for lifelong learning and curiosity.</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<style>
/* General Styling */
.programs-services {
	position: relative;
	padding: 10px 0;
	display: flex;
	align-items: center;
	height: 70vh;
}

.services-img {
	flex: 1;
	position: relative;
	transition: all 0.8s ease-in-out;
	overflow: hidden;
}

.services-img img {
	width: 200%; /* Enlarge width */
	height: 150%; /* Enlarge height */
	object-fit: cover;
	transition: transform 0.8s ease-in-out;
}

.services-content {
	flex: 1;
	padding: 20px;
	opacity: 0;
	transform: translateY(20px);
	transition: all 0.8s ease-in-out;
}

/* When scrolling, reduce the image size and move it left */
.services-img.reduced {
	flex: 0.4;
	transition: all 0.8s ease-in-out;
}

.services-img.reduced img {
	transform: scale(0.9); /* Slightly reduce the scale */
}

.services-content.visible {
	opacity: 1;
	transform: translateY(0);
}

h2.heading-regular {
	font-size: 2rem;
	font-weight: bold;
	color: #333;
}

.nav-tabs {
	margin-top: 20px;
}

.list-item li {
	margin-bottom: 10px;
}
</style>

	<script>
    // Scroll animation logic
    document.addEventListener('scroll', function () {
        const imgContainer = document.querySelector('.services-img');
        const contentContainer = document.querySelector('.services-content');

        if (window.scrollY > 100) {
            imgContainer.classList.add('reduced');
            contentContainer.classList.add('visible');
        } else {
            imgContainer.classList.remove('reduced');
            contentContainer.classList.remove('visible');
        }
    });
</script>


	<!--  
<div class="our-history">
    <div class="container">
        <div class="title-page text-center">
            <h2 class="text-regular animate-3d">Our History</h2>
            <p class="text-light animate-3d">Duis autem vel eum iriure dolor...</p>
        </div>
        <div class="history-content">
            <ul class="list-history text-center">
                <li class="animate-3d">
                    <span class="history-title text-light">University's<br>First Graduates</span>
                    <span class="history-dot"> <span></span></span>
                    <span class="history-year">1892</span>
                </li>
                <li class="animate-3d">
                    <span class="history-title text-light">Relations Program<br>Launched</span>
                    <span class="history-dot"> <span></span></span>
                    <span class="history-year">1894</span>
                </li>
            </ul>
        </div>
    </div>
</div>
 -->

	<div id="contacts" class="map">
		<div class="container">
			<div class="title-page text-center">
				<h2 class="text-regular animate-3d">We are not just Friend, We
					are Family</h2>

			</div>
			<div class="map-content">
				<img decoding="async" class="img-responsive animate-3d-image"
					src="https://sayidan.kenzap.com/wp-content/uploads/2016/07/map-img-3.jpg"
					alt="We are not just Friend, We are Family">
			</div>
		</div>
	</div>
	<!-- About Section Ends -->
	<!-- Footer Section -->
	<!-- Footer Section -->
	<footer class="bg-light py-5">
		<div class="container">
			<div class="row text-center text-md-start">
				<!-- Logo and Description -->
				<div class="col-md-3 mb-4 mb-md-0">
					<img src="<%= request.getContextPath() %>/images/logo.png"
						alt="Hello" class="mb-3 logo-animate" style="max-width: 150px;">
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
					<a href="#"
						class="text-[#1877F2] text-4xl hover:scale-125 gap-6 transition-transform duration-300 hover:drop-shadow-lg">
						<i class="bi bi-facebook" style="font-size: 2rem; color: #1877F2;"></i>
					</a> <a href="#"
						class="text-[#25D366] text-4xl gap-6 hover:scale-125 transition-transform duration-300 hover:drop-shadow-lg">
						<i class="bi bi-youtube" style="font-size: 2rem; color: red;"></i>

					</a> <a href="#"
						class="text-[#E4405F] text-4xl hover:scale-125 transition-transform duration-300 hover:drop-shadow-lg">
						<i class="bi bi-instagram"
						style="font-size: 2rem; color: #C13584;"></i>
					</a> <a href="#"
						class="text-black text-4xl hover:scale-125 transition-transform duration-300 hover:drop-shadow-lg">
						<i class="fa-brands fa-x-twitter" style="font-size: 2rem;"></i>
					</a> <a href="#"
						class="text-[#0A66C2] text-4xl hover:scale-125 transition-transform duration-300 hover:drop-shadow-lg">
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
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script>
        $(document).ready(function () {
            // Handle tab switching
            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                var target = $(e.target).attr("href"); // Get target tab ID

                // Remove active class from all tab panes and apply to the current one
                $('.tab-pane').removeClass('active');
                $(target).addClass('active');
            });
        });
    </script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
