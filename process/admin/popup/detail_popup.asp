<!-- #include virtual="/lib/include/adminProcessBundle.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

Dim sql
Dim data
Dim target

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer					= "ok"
message					= "완료"

sql							= ""
target					=	getClearstr(request("target"))

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
	sql	= sql & "Select																						" &vbCrlf
	sql	= sql & "*																								" &vbCrlf
	sql	= sql & ",dbo.getPopupThumbnailImage(popup_no)	thumbnail	" &vbCrlf
	sql	= sql & ",dbo.getPopupState(popup_no)						stateStr	" &vbCrlf
	sql	= sql & "From dbo.popup																		" &vbCrlf
	sql	= sql & "Where	seq			= '"& target &"'									" &vbCrlf
	sql	= sql & "And		use_yn	= 'y'															" &vbCrlf
	'response.write Replace(sql,vbCrlf,"<br/>") : response.end
	Call getDicDetailData(sql, data)

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
If Not IsNull(data) Then
response.write						getXmlDetailData(data)
End If 
response.Write						"</result>"

'-----------------------------------------------------------------------------------------------------
%>
