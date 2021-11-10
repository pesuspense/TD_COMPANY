<%
'-----------------------------------------------------------------------------------------------------
'Check
'-----------------------------------------------------------------------------------------------------
If getCookie("mem_id") = "" Or getCookie("mem_num") = "" Then
	If InStr(LCase(request.serverVariables("PATH_INFO")), "/admin/login/") = 0 Then
		'response.redirect "/login/"
	End if
Else
	If InStr(LCase(request.serverVariables("PATH_INFO")), "/admin/login/") > 0 Then
		'response.redirect "/main/"
	End If
End If
'-----------------------------------------------------------------------------------------------------
%>