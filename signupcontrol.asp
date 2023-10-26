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

Dim customerName, customerEmail, customerPassword

customerName = Trim(Request.Form("name"))
customerEmail = Trim(Request.Form("email"))
customerPassword = Trim(Request.Form("password"))

' Validate form data
If customerName = "" Then
    errMsg = "Please enter your name."
ElseIf customerEmail = "" Or InStr(customerEmail, "@") = 0 Then
    errMsg = "Please enter a valid email address."
ElseIf customerPassword = "" Then
    errMsg = "Please enter a password."
End If

If errMsg <> "" Then
    ' Display the error message and stop further processing
    Response.Write "An error occurred: " & errMsg
    Response.End
End If

' Hash the password using SHA-256
hashedPassword = ComputeSHA256Hash(customerPassword & "somesalt")

strSQLInsert = "INSERT INTO [User] ([UName], [UEmail], [UPassword]) VALUES ('" & Replace(customerName, "'", "''") & "', '" & Replace(customerEmail, "'", "''") & "', '" & Replace(hashedPassword, "'", "''") & "')"

objData.ExecuteQuery strSQLInsert, errMsg

If errMsg <> "" Then
    Response.Write "An error occurred while executing the query at insert: " & errMsg
    Response.End
Else
    ' Redirect to the login page after successful signup
    Response.Redirect "login.asp"
End If

objData.CloseConnection()  
Set objData = Nothing

Function ComputeSHA256Hash(data)
    Dim sha, utf8, bytes, result
    Set sha = CreateObject("System.Security.Cryptography.SHA256Managed")
    Set utf8 = CreateObject("System.Text.UTF8Encoding")
    bytes = utf8.GetBytes_4(data)
    result = sha.ComputeHash_2((bytes))
    Set sha = Nothing
    Set utf8 = Nothing
    ComputeSHA256Hash = ByteArrayToHexString(result)
End Function

Function ByteArrayToHexString(arr)
    Dim hexStr, i
    hexStr = ""
    For i = 1 To LenB(arr)
        hexStr = hexStr & Right("0" & Hex(Ascb(MidB(arr, i, 1))), 2)
    Next
    ByteArrayToHexString = hexStr
End Function
%>
