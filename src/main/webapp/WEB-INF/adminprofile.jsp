<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile - Sacred Heart College</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Page Styling */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(45deg, #ff9a9e, #fad0c4, #fbc2eb, #a1c4fd);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .navbar {
            background-color: #004d66;
            color: white;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
        }

        .navbar a {
            color: white;
            margin-right: 15px;
            text-decoration: none;
            font-size: 14px;
        }

        .navbar a:hover {
            text-decoration: underline;
        }

        .container {
            margin-top: 100px;
            padding: 50px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.2), -5px -5px 15px rgba(255, 255, 255, 0.8);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .profile-header h1 {
            font-size: 24px;
            font-weight: bold;
            color: #004d66;
        }

        .profile-info {
            margin-bottom: 20px;
        }

        .profile-info p {
            font-size: 16px;
            color: #333;
        }

        .profile-info img {
            max-width: 150px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .btn-custom {
            display: inline-block;
            background: linear-gradient(145deg, #ffffff, #d1d9e6);
            border: none;
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: bold;
            color: #193566;
            text-align: center;
            text-transform: uppercase;
            transition: all 0.3s ease-in-out;
            box-shadow: 6px 6px 10px rgba(0, 0, 0, 0.2), -6px -6px 10px rgba(255, 255, 255, 0.8);
            cursor: pointer;
        }

        .btn-custom:hover {
            transform: translateY(-3px);
            box-shadow: 8px 8px 15px rgba(0, 0, 0, 0.3), -8px -8px 15px rgba(255, 255, 255, 0.9);
        }

        footer {
            background-color: #004d66;
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <!-- Top Navbar -->
    <div class="navbar">
        <div>
            <h1 class="text-white">SACRED HEART COLLEGE (Autonomous)</h1>
        </div>
        <div>
            <a href="/admin/adminhome">Home</a>
            <a href="/admin/adminprofile">Profile</a>
            <a href="/admin/manageusers">Manage Users</a>
            <a href="#">News</a>
            <a href="#">Events</a>
            <a href="/admin/adminlogin">Logout</a>
        </div>
    </div>
    
    <!-- Content -->
    <div class="container">
        <div class="profile-header">
            <h1>Admin Profile</h1>
        </div>

<!-- Display Profile Image -->
    <div style="text-align: center; margin-bottom: 20px;">
        <img src="data:image/jpeg;base64,${base64Image}" alt="Profile Image" class="img-fluid" 
             style="width: 150px; height: 150px; border-radius: 50%; object-fit: cover;">
    </div>


        <!-- Display Admin Details -->
        <div class="details">
            <p><strong>Full Name:</strong> ${admin.fullName}</p>
            <p><strong>Email Address:</strong> ${admin.emailAddress}</p>
            <p><strong>Date of Birth:</strong> ${admin.dob}</p>
            <p><strong>Phone Number:</strong> ${admin.phoneNo}</p>
        </div>

        <!-- Edit Profile Button -->
        <div class="text-center">
            <a href="/admin/adminmoredetails" class="btn-custom">Edit Profile</a>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>Copyright © 2015 Sacred Heart College. All rights reserved | Developed by Data Centre</p>
    </footer>
</body>
</html>
