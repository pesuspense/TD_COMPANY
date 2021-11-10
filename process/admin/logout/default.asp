<!-- #include virtual="/lib/include/adminLoginBundle.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim sql

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
sql = "Insert Into member_login(type, memberNum, id, state) values('logout', '"& getCookie("mem_num") &"', '"& getCookie("mem_id") &"', 'o')"
Call execQuery(sql)

If getCookie("save_check") <> "o" Then
	Call setCookie("save_id",				"")
End If 

Call setCookie("mem_num",				"")
Call setCookie("mem_id",				"")
Call setCookie("mem_name",			"")

If Err.Number <> 0 Then	
	Call errorWrite(sql)
End If 

'-----------------------------------------------------------------------------------------------------
'Returns
'-----------------------------------------------------------------------------------------------------
response.redirect "/admin/login/"
'-----------------------------------------------------------------------------------------------------
%>
