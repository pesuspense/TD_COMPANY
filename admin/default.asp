<!-- #include virtual="/lib/include/adminLoginBundle.asp"	-->
<%
If getCookie("mem_num") = "" Then
	Response.redirect "/admin/login" 
Else
	Response.redirect "/admin/home" 
End If 
%>