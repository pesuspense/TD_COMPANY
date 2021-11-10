<!-- #include virtual="/lib/include/adminProcessBundle.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

Dim i
Dim arr
Dim sql,qry
Dim target,field,value,beforeValue

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer				= "ok"
message				= "완료"

sql						= ""
qry						= ""
target				= getClearstr(request("target"))
field					= getClearstr(request("field"))
value					= getClearstr(request("value"))
beforeValue		= getExecQueryReValue("Select "& field &" From inquiry_default Where idx = '"& target &"'")

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

	If	sql = "" Then
		If	field = "step"												Then
			arr = Split(value,",")
			For i = 1 To UBound(arr) +1
				If Trim(arr(i-1)) <> "" Then
					sql = sql & "update inquiry_default	 Set step = "& i &" Where idx ="& arr(i-1)																																																	&vbCrlf
				End If 
			Next
		Else

			sql = sql & "Update inquiry_default	 Set ["& field &"] = '"& value &"' Where idx = "& target																																												&vbCrlf
			If trim(value&"") <> Trim(beforeValue&"") Then
				qry = ""
				qry = qry & "Declare @inquiryNum varchar(10) = (Select inquiryNum From inquiry_default Where idx = '"& target &"')	" &vbCrlf
				qry = qry & "Insert Into inquiry_history(inquiryNum,fieldName,fieldValue,step)																			" &vbCrlf
				qry = qry & "Select																																																	" &vbCrlf
				qry = qry & " @inquiryNum																																														" &vbCrlf
				qry = qry & ",'"& field				&"'																																										" &vbCrlf
				qry = qry & ",'"& beforeValue &"'																																										" &vbCrlf
				qry = qry & ",(Select isNull(max(step),0) + 1 From inquiry_history Where inquiryNum = @inquiryNum)									" &vbCrlf
				Call execQuery(qry)
			End If 

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
