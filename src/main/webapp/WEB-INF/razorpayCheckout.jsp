<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Gateway</title>
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/logo.png">
    
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <style>
        /* General styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f4f4f4;
            height: 100vh;
        }

        .container {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            padding: 30px;
            text-align: center;
            animation: fadeIn 1s ease-out;
        }

        h1 {
            font-size: 24px;
            color: #333;
        }

        p {
            font-size: 18px;
            margin: 10px 0;
            color: #555;
        }

        #payBtn {
            padding: 12px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #F37254;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        #payBtn:hover {
            background-color: #e36149;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Complete Your Payment</h1>
        <p>Membership Fee: ₹1500</p>
        <button id="payBtn">Pay Now</button>
    </div>

    <script>
        // Retrieve the fullName and emailAddress dynamically from the backend
       var fullName = "${fullName}";
var emailAddress = "${emailAddress}";


        var options = {
            "key": "rzp_test_OQAfc6ekWZC75g", // Your Razorpay Key ID
            "amount": "150000", // Amount in paise (1500 INR = 150000 paise)
            "currency": "INR",
            "name": "SHC Alumni Membership",
            "description": "Life Membership Fee (Test Payment)",
            
            "handler": function(response) {
                // Send payment details to the backend for storing
                fetch('/paymentSuccess', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: new URLSearchParams({
                        paymentId: response.razorpay_payment_id,  // Send paymentId
                        fullName: fullName,  // Send dynamic full name
                        emailAddress: emailAddress,  // Send dynamic email address
                    }),
                })
                .then(res => {
                    if (res.redirected) {
                        window.location.href = res.url;  // Redirect to success page
                    } else {
                        alert("Payment processing failed. Please try again.");
                    }
                })
                .catch(err => {
                    console.error("Error occurred:", err);
                    alert("An error occurred while processing the payment.");
                });
            },
            "prefill": {
                "name": fullName,
                "email": emailAddress,
            },
            "theme": {
                "color": "#F37254",
            },
        };

        var rzp = new Razorpay(options);

        document.getElementById("payBtn").onclick = function(e) {
            rzp.open();
            e.preventDefault();
        };
    </script>
</body>
</html>
