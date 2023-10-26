<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<!-- #include virtual="\class\c_data_batch.asp"-->

<%
set objData = New c_Data 

' Connection string for Access database
objData.OpenConnection "prjTeamAndromeda", strErr

Dim strSQLSelect, errMsg, customerRecords
strSQLSelect = "Select ID, CustomerName, CustomerEmail, CustomerPhone, CustomerAddress from Customer WHERE 1=1 "

' Retrieve the search parameters from the URL
Dim name, email, phone
name = Request.QueryString("name")
email = Request.QueryString("email")
phone = Request.QueryString("phone")

' Append the search criteria to the SQL query

If name <> "" Then
    strSQLSelect = strSQLSelect & " AND CustomerName LIKE '%" & Replace(name, "'", "''") & "%'"
End If

If email <> "" Then
    strSQLSelect = strSQLSelect & " AND CustomerEmail LIKE '%" & Replace(email, "'", "''") & "%'"
End If

If phone <> "" Then
    strSQLSelect = strSQLSelect & " AND CustomerPhone LIKE '%" & Replace(phone, "'", "''") & "%'"
End If

' Execute the SQL select statement
customerRecords = objData.RetrieveData(strSQLSelect, errMsg)

' Check for query execution errors
If errMsg <> "" Then
    Response.Write "An error occurred while executing the query: " & errMsg
    Response.End
End If

' Number of records to display per page
recordsPerPage = 3
currentPage = GetCurrentPage() ' Use the GetCurrentPage() function from showlist.asp to get the current page number

' Calculate the total number of pages
totalRecords = UBound(customerRecords, 2) '+ 1
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

' Redirect back to showlist.asp with the filtered data and current page number as URL parameters
Response.Redirect "showlist.asp?page=" & currentPage
%>
