<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<!-- #include virtual="\class\c_data_batch.asp"--> 

<%
set objData = New c_Data 

' Connection string for Access database
objData.OpenConnection "prjTeamAndromeda", strErr
If strErr <> "" Then
    Response.Write "Error! : " & strErr
Else
    Response.Write("")
End if


On Error Goto 0

' Check for connection err

Dim customerName, customerAddress, customerPhoneNo, customerEmail

customerName = Trim(Request.Form("name"))
customerAddress = Trim(Request.Form("address"))
customerPhoneNo = Trim(Request.Form("phonenumber"))
customerEmail = Trim(Request.Form("email"))

' Validate form data
If customerName= "" Then
    errMsg = "Please enter your name."
ElseIf customerEmail = "" Then
    errMsg = "Please enter a valid email address."
ElseIf customerPhoneNo = "" Then
    errMsg = "Please enter a valid Phone."
ElseIf customerAddress = "" Then
    errMsg = "Please enter Address."
End If

If errMsg <> "" Then
    ' Display the error message and stop further processing
    Response.Write "An error occurred: " & errMsg
    Response.End
End If

'Set conn = Server.CreateObject("ADODB.Connection")
'conn.Provider = "Microsoft.ACE.OLEDB.12.0"
'conn.Open(Server.MapPath("db/Ecommerce.accdb"))

'Set rs = Server.CreateObject("ADODB.customerRecordsset")
 
strSQLInsert = "INSERT INTO [Customer] ([CustomerName], [CustomerEmail], [CustomerPhone], [CustomerAddress]) VALUES ('" & Replace(customerName, "'", "''") & "', '" & Replace(customerEmail, "'", "''") & "', '" & Replace(customerPhoneNo, "'", "''") & "', '" & Replace(customerAddress, "'", "''") & "')" 

objData.ExecuteQuery strSQLInsert, errMsg

If errMsg <> "" Then
    Response.Write "An error occurred while executing the query at insert: " & errMsg
    Response.End
Else
    ' Redirect to another page after successful registration
    Response.Redirect "showlist.asp"
End If

objData.CloseConnection()  
Set objData = Nothing

%>
