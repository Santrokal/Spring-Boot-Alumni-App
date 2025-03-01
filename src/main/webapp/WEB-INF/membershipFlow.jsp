<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Membership Portal</title>
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/logo.png">
    
    <style>
        /* General styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        h1, h2, h3 {
            text-align: center;
            color: #333;
        }

        p {
            text-align: center;
            font-size: 16px;
        }

        /* Message styling */
        .message {
            color: green;
            font-weight: bold;
            animation: fadeIn 1s ease-in;
        }

        .error-message {
            color: red;
            font-weight: bold;
            animation: fadeIn 1s ease-in;
        }

        /* Centered card design */
        .card {
            background: white;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            padding: 30px;
            max-width: 500px;
            width: 90%;
            animation: popIn 1s ease-out forwards;
            transform: scale(0.8);
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 20px;
        }

        label {
            font-size: 14px;
            color: #555;
        }

        input {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        button {
            padding: 10px;
            border: none;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #45a049;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes popIn {
            0% {
                transform: scale(0.8);
                opacity: 0;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }

        /* Membership Fee Text Styling */
        .fee {
            text-align: center;
            font-size: 18px;
            color: #333;
            font-weight: bold;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>Welcome to the SHC Alumni Membership Portal</h1>

        <!-- Display messages or errors -->
        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <p class="error-message">${errorMessage}</p>
        </c:if>

        <!-- Step 1: Ask if the user has a membership -->
        <h2>Do you already have a membership?</h2>
        <form action="/verifyMembership" method="post">
            <label for="emailAddress">Enter your email address:</label>
            <input type="email" id="emailAddress" name="emailAddress" required />
            <button type="submit">Verify Membership</button>
        </form>

        <!-- Step 2: Offer to purchase a new membership -->
        <h3>If you don’t have a membership, you can purchase one:</h3>
        <form action="/createMembership" method="post">
            <label for="fullName">Full Name:</label>
            <input type="text" id="fullName" name="fullName" required />

            <label for="emailAddress">Email Address:</label>
            <input type="email" id="emailAddress" name="emailAddress" required />

            <p class="fee">Membership Fee: ₹1500</p>
            <button type="submit">Proceed to Payment</button>
        </form>
    </div>
</body>
</html>
