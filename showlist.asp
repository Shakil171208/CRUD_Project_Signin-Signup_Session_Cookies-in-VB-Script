<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include virtual="\class\c_data_batch.asp"-->

<%
' Check if the user is logged in (session variable exists)
If Session("UserID") = "" Then
    Response.Redirect "login.asp"
Else
    Session.Timeout = 10 
End If

' Helper function to retrieve the current page number from the query string
Function GetCurrentPage()
    Dim page
    page = Request.Form("page")
    If page = "" Then
        GetCurrentPage = 1
    Else
        GetCurrentPage = CInt(page)
    End If
End Function

set objData = New c_Data 

' Connection string for Access database
objData.OpenConnection "prjTeamAndromeda", strErr

Dim strSQLSelect, errMsg, customerRecords
strSQLSelect = "Select ID, CustomerName, CustomerEmail, CustomerPhone, CustomerAddress from Customer"

' Execute the SQL select statement
customerRecords = objData.RetrieveData(strSQLSelect, errMsg)

' Check for query execution errors
If errMsg <> "" Then
    Response.Write "An error occurred while executing the query: " & errMsg
    Response.End
End If

' Number of records to display per page
recordsPerPage = 3
currentPage = GetCurrentPage()

' Check if the form is submitted from the search panel (search.asp)
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    ' Get the search parameters from the form
    Dim searchName, searchEmail, searchPhone
    
	searchName = TRIM(Request.Form("name"))	
    searchEmail = TRIM(Request.Form("email"))
    searchPhone = TRIM(Request.Form("phone"))
	
	
    
    ' Build the SQL query to filter the customer records based on the search criteria
    If  searchName <> "" Then
        strSQLSelect = strSQLSelect & " WHERE CustomerName LIKE '%" & Replace(searchName, "'", "''") & "%' "
    End If
    
    If searchEmail <> "" Then
        If InStr(strSQLSelect, "WHERE") > 0 Then
            strSQLSelect = strSQLSelect & " AND CustomerEmail LIKE '%" & Replace(searchEmail, "'", "''") & "%' "
        Else
            strSQLSelect = strSQLSelect & " WHERE CustomerEmail LIKE '%" & Replace(searchEmail, "'", "''") & "%' "
        End If
    End If
    
    If searchPhone <> "" Then
        If InStr(strSQLSelect, "WHERE") > 0 Then
            strSQLSelect = strSQLSelect & " AND CustomerPhone LIKE '%" & Replace(searchPhone, "'", "''") & "%' "
        Else
            strSQLSelect = strSQLSelect & " WHERE CustomerPhone LIKE '%" & Replace(searchPhone, "'", "''") & "%' "
        End If
    End If
End If

' Execute the SQL select statement with the filtered query
customerRecords = objData.RetrieveData(strSQLSelect, errMsg)

' Check for query execution errors
If errMsg <> "" Then
    Response.Write "An error occurred while executing the query: " & errMsg
    Response.End
End If

' Calculate the total number of pages
totalRecords = UBound(customerRecords, 2) + 1
totalPages = totalRecords / recordsPerPage

' Check if there are remaining records after dividing by recordsPerPage
If totalRecords Mod recordsPerPage > 0 Then
    totalPages = Int(totalPages) + 1
Else
    totalPages = Int(totalPages)
End If

' Current page is within valid limits checker
If currentPage < 1 Then currentPage = 1
If currentPage > totalPages Then currentPage = totalPages

' Calculate the starting and ending record indexes for the current page
startRecord = (currentPage - 1) * recordsPerPage
endRecord = Min(currentPage * recordsPerPage - 1, totalRecords - 1)

' Function to get the minimum value between two numbers
Function Min(a, b)
    If a < b Then
        Min = a
    Else
        Min = b
    End If
End Function

objData.CloseConnection()
Set objData = Nothing
%>

<!DOCTYPE html>
<html>
<head>
    <title>Customer List</title>
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
       
    </style>
</head>
<body>
    <div>
        <ul class="Navbar">
            <li style="float: left;">
                <a href="index.asp">Home</a>
                <a href="registration.asp">Insert Customer</a>
                <a href="showlist.asp">ShowList</a>
                <a href="search.asp">Search</a>
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

    <div style="margin: 50px;">
    <h1 style="color:gray;">Customer List</h1>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
            For i = startRecord To endRecord
                customerId = customerRecords(0, i)
                strName = customerRecords(1, i)
                strEmail = customerRecords(2, i)
                strPhone = customerRecords(3, i)
                strAddress = customerRecords(4, i)
            %>
            <tr>
                <td><%= strName %></td>
                <td><%= strEmail %></td>
                <td><%= strPhone %></td>
                <td><%= strAddress %></td>
                <td>
                    <form class="d-inline" method="post" action="update.asp">
                        <input type="hidden" name="id" value="<%= customerId %>">
                        <button class="btn-edit" type="submit"><i class="fas fa-edit"></i></button>
                    </form>
                    <form class="d-inline" method="post" action="delete.asp">
                        <input type="hidden" name="id" value="<%= customerId %>">
                        <button class="btn-delete" type="submit"><i class="fas fa-trash-alt"></i></button>
                    </form>
                </td>
            </tr>
            <%
            Next
            %>
        </tbody>
    </table>

<!-- Pagination part -->
<!-- Pagination part -->
<div class="pagination">
    <ul class="pagination">
        <% If currentPage > 1 Then %>
            <li class="page-item">
                <form class="d-inline" method="post" action="showlist.asp">
                    <input type="hidden" name="page" value="<%=currentPage - 1%>">
                    <input type="hidden" name="name" value="<%=Request.Form("name")%>">
                    <input type="hidden" name="email" value="<%=Request.Form("email")%>">
                    <input type="hidden" name="phone" value="<%=Request.Form("phone")%>">
                    <button class="page-link" type="submit"><i class="fas fa-chevron-left"></i> Previous</button>
                </form>
            </li>
        <% End If %>
        <%
        ' Calculate the range of page links to display
        Dim startPage, endPage
        Dim maxPageLinksToShow
        maxPageLinksToShow = 5 

        If totalPages <= maxPageLinksToShow Then
            startPage = 1
            endPage = totalPages
        Else
            Dim halfMaxLinks
            halfMaxLinks = Int(maxPageLinksToShow / 2)

            If currentPage <= halfMaxLinks Then
                startPage = 1
                endPage = maxPageLinksToShow
            ElseIf currentPage >= totalPages - halfMaxLinks Then
                startPage = totalPages - maxPageLinksToShow + 1
                endPage = totalPages
            Else
                startPage = currentPage - halfMaxLinks
                endPage = currentPage + halfMaxLinks
            End If
        End If

        ' Always display the "First" page link
        If startPage > 1 Then
            %>
            <li class="page-item">
                <form class="d-inline" method="post" action="showlist.asp">
                    <input type="hidden" name="page" value="1">
                    <input type="hidden" name="name" value="<%=Request.Form("name")%>">
                    <input type="hidden" name="email" value="<%=Request.Form("email")%>">
                    <input type="hidden" name="phone" value="<%=Request.Form("phone")%>">
                    <button class="page-link" type="submit">1</button>
                </form>
            </li>
            <li class="page-item disabled"><a class="page-link">...</a></li>
            <%
        End If

        For page = startPage To endPage
            If page = currentPage Then
                %>
                <li class="page-item active">
                    <a class="page-link"><%=page%></a>
                </li>
                <%
            Else
                %>
                <li class="page-item">
                    <form class="d-inline" method="post" action="showlist.asp">
                        <input type="hidden" name="page" value="<%=page%>">
                        <input type="hidden" name="name" value="<%=Request.Form("name")%>">
                        <input type="hidden" name="email" value="<%=Request.Form("email")%>">
                        <input type="hidden" name="phone" value="<%=Request.Form("phone")%>">
                        <button class="page-link" type="submit"><%=page%></button>
                    </form>
                </li>
                <%
            End If
        Next

        ' Always display the "Last" page link
        If endPage < totalPages Then
            %>
            <li class="page-item disabled"><a class="page-link">...</a></li>
            <li class="page-item">
                <form class="d-inline" method="post" action="showlist.asp">
                    <input type="hidden" name="page" value="<%=totalPages%>">
                    <input type="hidden" name="name" value="<%=Request.Form("name")%>">
                    <input type="hidden" name="email" value="<%=Request.Form("email")%>">
                    <input type="hidden" name="phone" value="<%=Request.Form("phone")%>">
                    <button class="page-link" type="submit"><%=totalPages%></button>
                </form>
            </li>
            <%
        End If
        %>

        <% If currentPage < totalPages Then %>
            <li class="page-item">
                <form class="d-inline" method="post" action="showlist.asp">
                    <input type="hidden" name="page" value="<%=currentPage + 1%>">
                    <input type="hidden" name="name" value="<%=Request.Form("name")%>">
                    <input type="hidden" name="email" value="<%=Request.Form("email")%>">
                    <input type="hidden" name="phone" value="<%=Request.Form("phone")%>">
                    <button class="page-link" type="submit">Next <i class="fas fa-chevron-right"></i></button>
                </form>
            </li>
        <% End If %>
    </ul>
</div>

</div>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
