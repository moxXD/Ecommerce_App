<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Confirmation Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            text-align: center;
            margin-top: 100px;
        }
        h1 {
            color: #333;
        }
        .countdown-container {
            font-size: 36px;
            color: #007bff;
            border: 2px solid #007bff;
            border-radius: 10px;
            padding: 20px;
            width: 200px;
            margin: 0 auto;
        }
    </style>
    <script type="text/javascript">
        // Function to close the window after countdown
        function closeWindow() {
            var count = 10; // Initial countdown value in seconds
            var countdown = setInterval(function() {
                document.getElementById('countdown').innerHTML = count; // Display remaining time
                count--; // Decrement countdown
                if (count < 0) {
                    clearInterval(countdown); // Stop countdown when it reaches 0
                    window.close(); // Close the window
                }
            }, 1000); // Update every second
        }
        // Call the function after the page has loaded
        window.onload = closeWindow;
    </script>
</head>
<body>
    <h1>Email Confirmation Page</h1>
    <div class="countdown-container">
        Closing in <span id="countdown">10</span> seconds
    </div>
</body>
</html>
