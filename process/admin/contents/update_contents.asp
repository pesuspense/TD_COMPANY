<!-- #include virtual="/lib/include/adminProcessBundle.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

Dim i
Dim arr
Dim sql
Dim target,field,value

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer				= "ok"
message				= "완료"

sql						= ""
target				= getClearstr(request("target"))
field					= getClearstr(request("field"))
value					= getClearstr(request("value"))

'-----------------------------------------------------------------------------------------------------
'Checking
'-----------------------------------------------------------------------------------------------------
If target & "" = "" Or field	& "" = "" Then 
	answer			= "error"
	message			= "요청 데이터가 부족합니다!"
End If 

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then

	If field = "contents"														Then sql = sql & "Update contents_detail		Set contents	= '"& value &"' Where type	= 'default'			And contentsNum = (Select top 1 contentsNum From contents_default Where idx ='"& target &"')"			&vbCrlf

	If	sql = "" Then
		If			field = "step"												Then
			arr = Split(value,",")
			For i = 1 To UBound(arr) +1
				If Trim(arr(i-1)) <> "" Then
					sql = sql & "update contents_default	 Set step = "& i &" Where idx ="& arr(i-1)											&vbCrlf
				End If 
			Next
		ElseIf	field = "division"											Then 
			arr		= Split(target,",")
			'value = iif(value = "off", "", "top")
			For i = 1 To UBound(arr) +1
				If Trim(arr(i-1)) <> "" Then
					sql = sql & "update contents_default	 Set division = '"& value &"' Where idx ="& arr(i-1)						&vbCrlf
				End If 
			Next
		Else
			sql = sql & "Update contents_default	 Set ["& field &"] = '"& value &"' Where idx = "& target						&vbCrlf
		End If
	End If 

 
	'response.write Replace(sql,vbCrlf,"<br/>") : response.end
	Call execQuery(sql)

	If Err.Number <> 0 Then	
		answer	= "error"
		message	= "데이터베이스 처리 에러!"
		Call errorWrite(sql)
	End If 
Else
		Call errorWrite(message)
End If

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
