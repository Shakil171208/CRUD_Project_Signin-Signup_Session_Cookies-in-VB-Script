<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<%
' Clear session variables to log the user out
Session.Contents.RemoveAll()

' Redirect the user to the login page after signing out
Response.Redirect "index.asp"
%>
