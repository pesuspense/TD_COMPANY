<!-- #include virtual="/lib/include/adminLoginBundle.asp"	-->
<%
'On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

Dim rs
Dim sql
Dim id,pw

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer				= "ok"
message				= "완료"

sql						= ""
id						= getClearstr(request("id"))
pw						= getClearstr(request("pw"))

'-----------------------------------------------------------------------------------------------------
'Checking
'-----------------------------------------------------------------------------------------------------
If			id	& "" = ""																				Then 
	answer			= "errorCheck"
	message			= "아이디를 입력하세요!"
ElseIf	pw	& "" = ""																				Then 
	answer			= "errorCheck"
	message			= "비밀번호를 입력하세요!"
ElseIf	InStr(LCase(CFG_REQ_HTTPREF), "/admin/login/") = 0	Then
	answer			= "errorCheck"
	message			= "[Err:0]<br/>관리자에게 문의하세요!"
ElseIf	getCookie("mem_num") <> ""													Then
	Call setCookie("mem_num", "")
End If 

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then
	sql = ""
	sql = sql & "Select 																														" &vbCrlf
	sql = sql & " AA.memberNum																											" &vbCrlf
	sql = sql & ",AA.name 																													" &vbCrlf
	sql = sql & ",BB.id																															" &vbCrlf
	sql = sql & ",BB.pw																															" &vbCrlf
	sql = sql & "From				member_default As AA																		" &vbCrlf
	sql = sql & "Inner Join	member_account As BB On AA.memberNum = BB.memberNum			" &vbCrlf
	sql = sql & "Where isNull(BB.id,'')		<> ''																			" &vbCrlf
	sql = sql & "And		isNull(BB.pw,'')		<> ''																		" &vbCrlf
	sql = sql & "And		isNull(AA.state,'')	<> 'd'																	" &vbCrlf
	sql = sql & "And		BB.id								= '"& id &"'														" &vbCrlf
	Set rs = getExecQueryReRs(sql)
	'response.write Replace(sql,vbCrlf,"<br/>") : response.end

	If Err.Number <> 0 Then	
		answer	= "errorSql"
		message	= "[Err:2]<br/>관리자에게 문의하세요!"
		'message = sql
	Else

		If rs.eof Then
			answer	= "error" :	message	= "아이디 또는 비밀번호가 일치하지 않습니다."
		Else

			If rs("pw") = pw Then
				Call setCookie("mem_num",				rs("memberNum"))
				Call setCookie("mem_id",				rs("id"))
				Call setCookie("mem_name",			rs("name"))
			Else
				answer	= "error" : message	= "아이디 또는 비밀번호가 일치하지 않습니다."			
			End If 
		End If 

		rs.close()	: Set rs = nothing

	End If 
End If

If answer <> "ok" Then
	If			answer = "errorCheck" Then
		answer	= "error"
		Call errorWrite(message)
	ElseIf	 answer = "errorSql" Then
		answer	= "error"
		Call errorWrite(sql)
	End If 
End If 

Call execQuery("Insert Into member_login(type, memberNum, id, pw, state, message) values('login', '"& getCookie("mem_num") &"', '"& Left(id,4000) &"', '"& Left(pw,4000) &"', '"& iif(answer = "ok", "o", "x") &"', '"& Replace(message,"'","") &"')")

'-----------------------------------------------------------------------------------------------------
'Returns
'-----------------------------------------------------------------------------------------------------
response.Charset			=		"euc-kr"
response.ContentType	=		"text/xml"
response.Write						"<?xml version=""1.0"" encoding=""utf-8"" ?>"						&vbCrlf
response.Write						"<result>"
response.Write						"		<answer>"		& escape(answer)		&" </answer>"				&vbCrlf
response.Write						"		<message>"	& escape(message)		&" </message>"			&vbCrlf
response.Write						"</result>"

'-----------------------------------------------------------------------------------------------------
%>
