<!-- #include virtual="/lib/include/adminProcessBundle.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

Dim sql,qry
Dim target

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer				= "ok"
message				= "완료"

sql						= ""
target				= getClearstr(request("target"))

'-----------------------------------------------------------------------------------------------------
'Checking
'-----------------------------------------------------------------------------------------------------
If target	& "" = "" Then 
	answer			= "error"
	message			= "요청 데이터가 부족합니다!"
End If 

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then

	sql = ""
	sql = sql & "Update inquiry_default Set state ='d' Where charindex(','+ convert(varchar(10),idx) +',','"& target &"') > 0 " &vbCrlf
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
