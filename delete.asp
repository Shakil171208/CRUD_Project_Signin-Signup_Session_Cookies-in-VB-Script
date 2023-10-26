<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<!-- #include virtual="\class\c_data_batch.asp"--> 

<%
set objData = New c_Data 

' Connection string for Access database
objData.OpenConnection "prjTeamAndromeda", strErr
If strErr <> "" Then
    Response.Write "Error! : " & strErr
Else
    Response.Write("" & "<br/>")
End if


On Error Goto 0

' Check for connection err


Dim id
 
id = Request.form("id")

 
 Response.write(id)

strSQLInsert = "Delete from [Customer]  where [ID] =  " & [id]


objData.ExecuteQuery strSQLInsert, errMsg

Response.Write(strSQLInsert)
If errMsg <> "" Then
Response.Write "An error occurred while executing the query at insert: " & errMsg
Response.End
End If

' Redirect to another page after successful registration

Response.Redirect "showlist.asp"

objData.CloseConnection()  
Set objData = Nothing

%>