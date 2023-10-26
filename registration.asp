<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<%
' Check if the user is logged in (session variable exists)
If Session("UserID") = "" Then
    Response.Redirect "login.asp"
Else
    Session.Timeout = 10 
End If
%>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css">
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

    <div id="registerForm" class="container mt-4">
        <h2>Add Customer</h2>
        <form method="post" novalidate action="registrationcontrol.asp" class="needs-validation">

            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" class="form-control" required>
                <div class="invalid-feedback">
                    Please enter your name.
                </div>
            </div>


            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" class="form-control" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required>
                <div class="invalid-feedback">
                    Please enter a valid email address.
                </div>
            </div>
            <div class="form-group">
                <label for="phonenumber">Phone:</label>
                <input type="text" id="phonenumber" name="phonenumber" class="form-control" pattern="[0-9]{10}" required>
                <div class="invalid-feedback">
                    Please enter a valid Phone.
                </div>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" class="form-control" required>
                <div class="invalid-feedback">
                    Please enter Address.
                </div>
            </div>
             
            <button type="submit" class="btn btn-primary">Add Customer</button>
        </form>
    </div>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   
</body>
</html>
