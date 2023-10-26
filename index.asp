<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Management</title>
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .content {
            flex: 1;
        }
        .short-image {
            max-height: 280px; 
        }
    </style>
</head>
<body>
    <div>
        <ul class="Navbar">
            <li style="float: left;">
                <a href="index.asp">Home</a>
                <a href="registration.asp">Insert Customer</a>
                <a href="showlist.asp">ShowList</a>
            </li>
            <li style="float: right;">
                <% If Session("UserID") = "" Then %>
                    <a href="signup.asp">Sign Up</a>
                    <a href="login.asp">Login</a>
                <% Else %>
                    Welcome, <%= Session("UName") %>
                    <a href="logout.asp" style="margin-left: 10px;">Sign Out</a>
                <% End If %>
            </li>
        </ul>
    </div>
    <div class="content container mt-4">
        <h1>Welcome to Employee Management System</h1>
        <p>This is a CRUD project for managing employee information.</p>
        <img src="1.jfif" alt="Employee Image" class="img-fluid mt-3">
    </div>
    <footer class="mt-auto py-3 bg-dark text-light text-center">
        <div class="container">
            <p>&copy; 2023 Employee Management System. All rights reserved.</p>
        </div>
    </footer>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
