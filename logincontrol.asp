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

Dim customerEmail, customerPassword

customerEmail = Trim(Request.Form("email"))
customerPassword = Trim(Request.Form("password"))

' Validate form data
If customerEmail = "" Or InStr(customerEmail, "@") = 0 Then
    errMsg = "Please enter a valid email address."
ElseIf customerPassword = "" Then
    errMsg = "Please enter your password."
End If

If errMsg <> "" Then
    ' Display the error message and stop further processing
    Response.Write "An error occurred: " & errMsg
    Response.End
End If

' Hash the password using SHA-256
hashedPassword = ComputeSHA256Hash(customerPassword & "somesalt")

strSQLSelect = "SELECT UName, UEmail, UPassword FROM [User] WHERE [UEmail] = '" & Replace(customerEmail, "'", "''") & "' AND [UPassword] = '" & Replace(hashedPassword, "'", "''") & "'"
Dim UserRecords, errMsg
UserRecords = objData.RetrieveData(strSQLSelect, errMsg)

If errMsg <> "" Then
    Response.Write "An error occurred while executing the query at login: " & errMsg
    Response.End
ElseIf UserRecords(0,0) = "Nothing" Then
    ' No matching record found, invalid login
    errMsg = "Invalid email or password."
    Response.Write errMsg
    Response.End
Else
    ' Valid login, create a session and store user details
    Session("UserID") = UserRecords(0, 0)
    Session("UName") = UserRecords(0, 0)
    Session("UPassword") = UserRecords(2, 0) 
    ' Set a cookie for remembering the login
    Response.Cookies("RememberMe")("UEmail") = customerEmail
    Response.Cookies("RememberMe").Expires = Date + 30 

    ' Redirect to the employee page after successful login
    Response.Redirect "index.asp"
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

