<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">	
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sacred Heart College</title>
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/logo.png">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Page Styling with Multicolor Background and 3D Effect */
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

        /* Top Navbar */
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

        /* Sidebar Styling */
        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            top: 75px; /* Adjusted to align below the navbar */
            left: 0;
            background: #333;
            color: #fff;
            padding-top: 20px;
            box-shadow: 5px 0px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }

        .sidebar a {
            color: #fff;
            text-decoration: none;
            display: block;
            padding: 12px 20px;
            font-size: 18px;
            margin: 6px 0;
            border-radius: 8px;
            transition: background 0.3s ease, transform 0.3s ease;
            box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2), -4px -4px 10px rgba(255, 255, 255, 0.3);
        }

        .sidebar a:hover {
            background: #555;
            transform: translateY(-4px);
            box-shadow: 6px 6px 15px rgba(0, 0, 0, 0.3), -6px -6px 15px rgba(255, 255, 255, 0.4);
        }

        /* Content Styling */
        .container {
            margin-left: 260px;
            margin-top: 80px; /* Adjusted for navbar */
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.2), -5px -5px 15px rgba(255, 255, 255, 0.8);
        }

        .section-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        /* 3D Button Styling */
        .btn-custom {
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

        .btn-custom:active {
            background: linear-gradient(145deg, #d1d9e6, #ffffff);
            box-shadow: inset 4px 4px 8px rgba(0, 0, 0, 0.2), inset -4px -4px 8px rgba(255, 255, 255, 0.8);
            transform: translateY(2px);
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

    <!-- Sidebar  -->
    <div class="sidebar">
        <a href="/admin/alumnidetails">View All Alumni Details</a>
        <a href="/admin/alumnifilter">View Alumni Details Filter</a>
        <a href="/admin/addusers">Add Users</a>
        <a href="/admin/getalluser">Get All Users</a>
        <a href="/admin/messages">Check Messages</a>
        <a href="/admin/uploaddata">Upload Files</a>
    </div>
   
    <!-- Content 
    <div class="container">
        <h2 class="section-title">Welcome to Sacred Heart College</h2>
        <button class="btn-custom">Click Me</button>
    </div>-->

    <!-- Footer -->
    <footer>
        <p>Copyright © 2015 Sacred Heart College. All rights reserved | Developed by Data Centre</p>
    </footer>
</body>
</html>
