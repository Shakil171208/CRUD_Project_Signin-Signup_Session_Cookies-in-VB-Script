<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
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
    <div id="signupForm" class="container mt-4">
        <h2>Sign Up</h2>
        <form method="post" action="signupcontrol.asp">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary">Sign Up</button>
        </form>
    </div>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
