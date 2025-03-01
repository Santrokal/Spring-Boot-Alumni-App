<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
    <style>
    body {
    background: url('${pageContext.request.contextPath}/earth.mp4') no-repeat center center fixed;
    background-size: cover;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}


        .login-box {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.3);
            text-align: center;
            width: 350px;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }

        .login-box:hover {
            transform: translateY(-10px) scale(1.03);
            box-shadow: 0px 10px 25px rgba(255, 255, 255, 0.2);
        }

        h2 {
            color: white;
            font-size: 24px;
        }

        .user-box {
            position: relative;
            margin-bottom: 20px;
        }

        .user-box input {
            width: 100%;
            padding: 12px;
            border: 2px solid transparent;
            border-radius: 5px;
            font-size: 18px;
            font-style:bold;
            outline: none;
            background: rgba(255, 255, 255, 0.2);
            color: black;
            transition: all 0.3s ease-in-out;
        }

        .user-box input:focus {
            border-color: #00c6ff;
            box-shadow: 0 0 10px rgba(0, 198, 255, 0.7);
        }

        /* Show/Hide Password Icon */
        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 18px;
            color: white;
            background: none;
            border: none;
            outline: none;
        }

        .toggle-password:hover {
            color: #00c6ff;
        }

        .button-89 {
            background: linear-gradient(to right, #00c6ff, #007bff);
            color: white;
            padding: 12px 25px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 6px rgba(0, 198, 255, 0.3);
            font-weight: bold;
        }

        .button-89:hover {
            transform: scale(1.1);
            box-shadow: 0 8px 15px rgba(0, 198, 255, 0.5);
            background: linear-gradient(to right, #007bff, #003f7f);
        }

        /* 3D Hover Effect */
        .button-89:active {
            transform: scale(0.95);
            box-shadow: 0 3px 5px rgba(0, 198, 255, 0.7);
        }

        /* Floating Glow Animation */
        @keyframes floating {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-5px); }
            100% { transform: translateY(0px); }
        }

        .login-box {
            animation: floating 3s ease-in-out infinite;
        }
        .login-container {
    background: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease-in-out;
}

.login-container:hover {
    transform: scale(1.05);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
}

        .video-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }</style>
    <script>
        function togglePassword() {
            var passwordField = document.getElementById("password");
            var eyeIcon = document.getElementById("eye-icon");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                eyeIcon.classList.remove("fa-eye");
                eyeIcon.classList.add("fa-eye-slash");
            } else {
                passwordField.type = "password";
                eyeIcon.classList.remove("fa-eye-slash");
                eyeIcon.classList.add("fa-eye");
            }
        }

        function submitForm() {
            const role = document.getElementById('role').value;
            const emailAddress = document.getElementById('emailAddress').value;
            let data = { emailAddress: emailAddress, role: role };

            if (role === 'admin') {
                data.password = document.getElementById('password').value;
            } else if (role === 'alumni') {
                data.dob = document.getElementById('dob').value;
            }

            fetch('/alumni', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    window.location.href = data.redirectUrl;
                } else {
                    document.getElementById('error-message').innerText = data.message;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('error-message').innerText = "An error occurred. Please try again.";
            });
        }

        function toggleFields() {
            const role = document.getElementById('role').value;
            document.getElementById('password-box').style.display = (role === 'admin') ? 'block' : 'none';
            document.getElementById('dob-box').style.display = (role === 'alumni') ? 'block' : 'none';
        }
    </script>
</head>
<body>
    <!-- Video Background -->
    <video class="video-background" autoplay muted loop>
        <source src="${pageContext.request.contextPath}/earth.mp4" type="video/mp4">
        Your browser does not support the video tag.
    </video>
    <div class="login-box">
        <h2>Login</h2>
        <form id="loginForm">
            <!-- Role Selection -->
            <div class="user-box">
                <label>Select Role:</label>
                <select id="role" name="role" onchange="toggleFields()" required>
                    <option value="" disabled selected>Select Role</option>
                    <option value="admin">Admin</option>
                    <option value="alumni">Alumni</option>
                </select>
            </div>

            <!-- Email Address -->
            <div class="user-box">
                <input type="email" id="emailAddress" name="emailAddress" placeholder="Email Address" required>
            </div>

            <!-- Password (For Admin Only) -->
            <div class="user-box" id="password-box" style="display: none;">
                <input type="password" id="password" name="password" placeholder="Password">
                <button type="button" class="toggle-password" onclick="togglePassword()">
                    <i id="eye-icon" class="fa fa-eye"></i>
                </button>
            </div>

            <!-- Date of Birth (For Alumni Only) -->
            <div class="user-box" id="dob-box" style="display: none;">
                <input type="date" id="dob" name="dob">
            </div>

            <!-- Error Message -->
            <div id="error-message" style="color: red; text-align: center; margin-bottom: 10px;"></div>

            <!-- Login Button -->
            <div class="d-flex justify-content-center align-items-center w-100 mb-6">
                <button type="button" class="button-89" onclick="submitForm()">Log In</button>
            </div>
        </form>

        <!-- Additional Links -->
        <div>
            <a href="/register" class="self-register">Self Register</a>
        </div>
    </div>
</body>
</html>
