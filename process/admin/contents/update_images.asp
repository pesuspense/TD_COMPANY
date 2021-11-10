<!-- #include virtual="/lib/include/adminProcessBundle.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

Dim sql
Dim arr
Dim target,field,value

Dim objFso,objFiles
Dim fileName,filePath1,filePath2


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
If target = "" Or field	= "" Then 
	answer			= "error"
	message			= "요청 데이터가 부족합니다!"
End If 

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then

	If			field = "state"								Then

		If value = "d" Then
			fileName	= getExecQueryReValue("Select fileNameNew From contents_file Where idx = '"& target &"'")
			filePath1 = server.mapPath(CFG_FOLDER_CONTENTS&"") &"\"&				fileName
			filePath2	= server.mapPath(CFG_FOLDER_CONTENTS&"") &"\delete\"& fileName
			If fileName <> "" Then
				Set objFso = CreateObject("Scripting.FileSystemObject")
				If objFso.fileExists(filePath1) = true Then
					objFso.CopyFile filePath1, filePath2

					Set objFiles = objFso.GetFile(filePath1)			
					objFiles.Delete	
				End If			
				Set objFso = Nothing 
			End If 
		End If 

		sql = ""
		sql = sql & "Update contents_file Set "& field &" = '"& value &"' Where idx = '"& target &"'																														"							&vbCrlf	

	ElseIf 	field = "step"								Then
		sql = ""
		arr = Split(value,",")
		For i = 1 To UBound(arr) +1
			If Trim(arr(i-1)) <> "" Then
				sql = sql & "update contents_file Set step = "& i &" Where idx ="& arr(i-1)																																												&vbCrlf
			End If 
		Next

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
