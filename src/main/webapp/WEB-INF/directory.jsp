<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shc.alumni.springboot.entity.AlumniRegisterEntity" %> <!-- Replace with the actual package name -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumni Home Page & Directory</title>
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/logo.png">
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons (Optional) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
	
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


<!-- Alumni Directory Section -->
<div class="container">
    <h2 class="text-center my-4">Alumni Directory</h2>
    <h4>Total Alumni: <%= ((List<?>) request.getAttribute("alumniList")).size() %></h4>

    <!-- Search Box -->
    <input type="text" id="searchInput" class="form-control my-3" placeholder="Search by Name or Department..." onkeyup="filterAlumni()">

    <table id="alumniTable">
        <thead>
            <tr>
                <th>Image</th>
                <th>Alumni Name</th>
                <th>Alumni Department</th>
                <th>Alumni Degree</th>
            </tr>
        </thead>
        <tbody id="tableBody">
            <% 
                List<AlumniRegisterEntity> alumniList = (List<AlumniRegisterEntity>) request.getAttribute("alumniList");
                for (AlumniRegisterEntity alumni : alumniList) {
            %>
            <tr>
                <td>
<img src="/directory/image/<%= alumni.getEmailaddress() %>" 
     alt="Profile Image" 
     style="width: 70px; height: 70px; border-radius: 50%; object-fit: cover;" 
     onerror="this.onerror=null; this.src='/images/defaultimag.png';" />


                </td>

                <td class="alumni-name"><%= alumni.getFullname() %></td>
                <td class="alumni-department"><%= alumni.getDepartment() %></td>
                <td class="alumni-degree"><%= alumni.getDegree_obtained() %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

    <!-- Pagination Controls -->
    <div class="pagination-container text-center mt-3">
        <button id="prevPage" class="btn btn-primary" onclick="prevPage()">Previous</button>
        
        <button id="nextPage" class="btn btn-primary" onclick="nextPage()">Next</button>
    </div>

<!-- JavaScript for Filtering & Pagination -->
<script>
    let currentPage = 1;
    let rowsPerPage = 10;

    function showPage(page) {
        let rows = document.querySelectorAll("#tableBody tr");
        let totalRows = rows.length;
        let totalPages = Math.ceil(totalRows / rowsPerPage);

        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        
        currentPage = page;

        let start = (currentPage - 1) * rowsPerPage;
        let end = start + rowsPerPage;

        rows.forEach((row, index) => {
            row.style.display = (index >= start && index < end) ? "" : "none";
        });

        document.getElementById("pageInfo").innerText = `Page ${currentPage} of ${totalPages}`;
        
        document.getElementById("prevPage").disabled = currentPage === 1;
        document.getElementById("nextPage").disabled = currentPage === totalPages;
    }

    function nextPage() {
        showPage(currentPage + 1);
    }

    function prevPage() {
        showPage(currentPage - 1);
    }
    document.addEventListener("DOMContentLoaded", function () {
        showPage(1); // Apply pagination on page load
    });


    function filterAlumni() {
        let input = document.getElementById("searchInput").value.toLowerCase().trim();
        let rows = document.querySelectorAll("#tableBody tr");
        let filteredRows = [];

        rows.forEach(row => {
            let name = row.querySelector(".alumni-name").textContent.toLowerCase().trim();
            let department = row.querySelector(".alumni-department").textContent.toLowerCase().trim();
            let degree = row.querySelector(".alumni-degree").textContent.toLowerCase().trim();

            if (name.includes(input) || department.includes(input)) {
                row.style.display = "";
                filteredRows.push(row);
            } else {
                row.style.display = "none";
            }
        });

        // Adjust pagination after filtering
        if (filteredRows.length > 0) {
            currentPage = 1; // Reset to first page
            showFilteredPage(filteredRows, 1);
        } else {
            document.getElementById("pageInfo").innerText = "No results found";
        }
    }

    function showFilteredPage(filteredRows, page) {
        let totalRows = filteredRows.length;
        let totalPages = Math.ceil(totalRows / rowsPerPage);

        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;

        currentPage = page;

        let start = (currentPage - 1) * rowsPerPage;
        let end = start + rowsPerPage;

        filteredRows.forEach((row, index) => {
            row.style.display = (index >= start && index < end) ? "" : "none";
        });

        document.getElementById("pageInfo").innerText = `Page ${currentPage} of ${totalPages}`;
        document.getElementById("prevPage").disabled = currentPage === 1;
        document.getElementById("nextPage").disabled = currentPage === totalPages;
    }

</script>


<br>
<br>
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


<!-- Add Font Awesome for Social Icons -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
