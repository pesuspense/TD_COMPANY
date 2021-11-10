<!-- #include virtual="/lib/include/adminProcessBundle.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

Dim setTarget,setType,setDivision

Dim filePath,fileName
Dim arrList,arrBody,arrItem

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer				= "ok"
message				= "완료"

sql						= getReadFile(server.mappath(CFG_FOLDER_CONTENTS) &"\"& CFG_SES_NUM  &".txt")
setTarget			=	getClearstr(request("target"))
setType				=	getClearstr(request("type"))
setDivision		=	getClearstr(request("division"))

Call file_delete(server.mappath(CFG_FOLDER_CONTENTS) &"\"& CFG_SES_NUM  &".txt")
'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then

	If Trim(sql) <> "\x" Then
		sql = Replace(sql,"set_target"				,setTarget)
		sql = Replace(sql,"set_type"					,setType)
		sql = Replace(sql,"set_division"			,setDivision)
		sql = Replace(sql,"set_step"					,"(Select count(*) + 1  From contents_file Where contentsNum = '"& setTarget &"' And type = '"& setType &"')")
		Call execQuery(sql)
	End If
	
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
