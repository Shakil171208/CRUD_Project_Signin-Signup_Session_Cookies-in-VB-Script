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


Dim customerName, customerAddress, customerPhoneNo, customerEmail, id


id = Request.Form("id")
customerName = Request.Form("name")
customerAddress = Request.Form("address")
customerPhoneNo= Request.Form("phone")
customerEmail = Request.Form("email")


Response.write("name: " & customerName & "<br>" )
Response.write("email: " & customerEmail & "<br>")
Response.write("phone: " & customerPhoneNo & "<br>")
Response.write("address: " & customerAddress & "<br>")

'Set conn = Server.CreateObject("ADODB.Connection")
'conn.Provider = "Microsoft.ACE.OLEDB.12.0"
'conn.Open(Server.MapPath("db/Ecommerce.accdb"))

'Set rs = Server.CreateObject("ADODB.customerRecordset")
 
 
Dim strSQLSelect

strSQLSelect = "Select CustomerName, CustomerEmail, CustomerPhone, CustomerAddress from Customer where ID = " & [id]

' Execute the SQL insert statement
Dim errMsg , customerRecords

customerRecords = objData.RetrieveData(strSQLSelect, errMsg)


If  IsNull(customerName) Then 
   customerName= customerRecords(1,0)
End if

If  IsNull(customerEmail) Then 
    customerEmail = customerRecords(2,0)
End if

If   IsNull(customerPhoneNo) Then 
    customerPhoneNo = customerRecords(3,0)
End if

If  IsNull(customerAddress) Then 
    customerAddress = customerRecords(4,0)
End if


Response.write("After Update Data <br>")
Response.write("name: " & customerName & "<br>")
Response.write("email: " & customerEmail & "<br>")
Response.write("phone: " & customerPhoneNo & "<br>")
Response.write("address: " & customerAddress & "<br>")



Dim strSQLInsert

strSQLInsert = "UPDATE [Customer] SET "
strSQLInsert = strSQLInsert & "CustomerName = '" & Replace(customerName, "'", "''") & "', "
strSQLInsert = strSQLInsert & "CustomerEmail = '" & Replace(customerEmail, "'", "''") & "', "
strSQLInsert = strSQLInsert & "CustomerPhone = '" & Replace(customerPhoneNo, "'", "''") & "', "
strSQLInsert = strSQLInsert & "CustomerAddress = '" & Replace(customerAddress, "'", "''") & "' "
strSQLInsert = strSQLInsert & "WHERE ID = " & id

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