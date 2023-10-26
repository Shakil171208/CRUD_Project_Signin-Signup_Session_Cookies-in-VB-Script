<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<!-- #include virtual="\class\c_data_batch.asp"--> 

<%
set objData = New c_Data 

' Connection string for Access database
objData.OpenConnection "prjTeamAndromeda", strErr


On Error Goto 0

' Check for connection err

Dim id
 
id = Request.form("id")

strSQLSelect = "select * from  [Customer]  where [ID] =  " & [id]


objData.ExecuteQuery strSQLInsert, errMsg

Dim errMsg , customerRecords
customerRecords = objData.RetrieveData(strSQLSelect, errMsg)

Response.Write(strSQLInsert)
If errMsg <> "" Then
Response.Write "An error occurred while executing the query at insert: " & errMsg
Response.End
End If

' Redirect to another page after successful registration

objData.CloseConnection()  
Set objData = Nothing

%>


<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div style="background-color:gray; height:50px; vertical-align:middle;padding-top:10px; padding-left:30px ;">
      
           <ul class="Navbar">
              <li><a href="index.asp">Home</a></li>
              <li><a href="registration.asp">Insert Customer</a></li>
              <li><a href="showlist.asp">ShowList</a></li>
             
           </ul>
    
    </div>

    <div id="registerForm" class="container mt-4">
        <h2>Update Customer</h2>
        <form method="post" novalidate action="updatecontrol.asp">
            <input type="hidden" name="id" value="<%= customerRecords(0,0) %>">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" class="form-control" value ="<%= customerRecords(1,0) %>" >
                <div class="invalid-feedback">
                    Please enter your name.
                </div>
            </div>


            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" class="form-control" pattern="[0-9]{10}" value = "<% =customerRecords(2,0) %>"  >
                <div class="invalid-feedback">
                    Please enter a username.
                </div>
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" class="form-control" value = "<% =customerRecords(3,0) %>"  >
                <div class="invalid-feedback">
                    Please enter a valid Phone.
                </div>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" class="form-control" value = "<% =customerRecords(4,0) %>"  >
                <div class="invalid-feedback">
                    Please enter Address.
                </div>
            </div>
             
            <button type="submit" class="btn btn-primary">Update Cusomter</button>
        </form>
    </div>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   
</body>
</html>

