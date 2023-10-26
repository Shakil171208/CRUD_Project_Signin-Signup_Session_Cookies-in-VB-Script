<!DOCTYPE html>
<html>
<head>
    <title>Search Customers</title>
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div style="background-color: gray; height: 50px; vertical-align: middle; padding-top: 10px; padding-left: 30px;">
        <ul class="Navbar">
            <li><a href="index.asp">Home</a></li>
            <li><a href="registration.asp">Insert Customer</a></li>
            <li><a href="showlist.asp">Show List</a></li>
            <li><a href="search.asp">Search</a></li>
        </ul>
    </div>

    <div style="margin: 50px;">
        <h1 style="color: gray;">Search Customers</h1>
        <form method="post" action="showlist.asp">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="Enter name...">
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" class="form-control" placeholder="Enter email...">
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" class="form-control" placeholder="Enter phone...">
            </div>
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
