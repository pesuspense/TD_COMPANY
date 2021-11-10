<!-- #include virtual="/lib/include/adminProcessBundle.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Description
'-----------------------------------------------------------------------------------------------------


'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message
Dim sql,rs
Dim target
Dim saveFilePath
Dim fileFieldName, fileSize, fileCapacity, fileDirectory, fileExtension, oldFileName, newFileName, viewFileName

Dim pageNum,pageStep


'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer				= "ok"
message				= "완료"

sql						= ""
target				= getClearstr(request.queryString("target"))

'-----------------------------------------------------------------------------------------------------
'Check
'-----------------------------------------------------------------------------------------------------
If target = "" Then
	answer	= "x"
	message	= "필수정보가 전달되지 않았습니다."	
End If 

'-----------------------------------------------------------------------------------------------------
'Upload
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then

	fileFieldName		= "file"
	fileDirectory		= CFG_FOLDER_META

	Set	uploadform	= Server.CreateObject("DEXT.FileUpload")
	uploadform.DefaultPath	= server.mappath(fileDirectory)
	uploadform.CodePage			= 65001
	fileExtension						= uploadform(fileFieldName).FileExtension & ""

	If fileExtension = "jpg" Then
		fileSize								= uploadform(fileFieldName).ImageWidth &"*"& uploadform(fileFieldName).ImageHeight
		fileCapacity						= uploadform(fileFieldName).FileLen										& ""
		oldFileName							= uploadform(fileFieldName).FileNameWithoutExt 				& ""
		oldFileName							= getClearstr(oldFileName)														& ""
		viewFileName						=	oldFileName
		newFileName							= Replace(Replace(date,"-","") & Replace(Right(now,8),":","") & getRnd(10000,99999), " ", "")
		oldFileName							= oldFileName		&"."& fileExtension
		viewFileName						=	viewFileName	&"."& fileExtension
		newFileName							= newFileName		&"."&	fileExtension
		saveFilePath						= uploadform(fileFieldName).SaveAs(newFileName, true)
	Else
		answer	= "x"
		message	= "*.jpg 파일 형식만 업로드 가능합니다."
	End If 

End If 

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then

	pageNum		= getExecQueryReValue("Select pageNum									From dbo.page_item Where idx			= '"& target	&"'")
	pageStep	= getExecQueryReValue("Select isNull(max(step),0) + 1 From dbo.page_file Where pageNum	= '"& pageNum &"'")

	If pageNum = "" Then
		answer	= "x"
		message	= "필수정보가 정확하지 않았습니다."	
	Else
		sql = ""
		sql = sql & "Insert Into page_file(															 " &vbCrlf
		sql = sql & " pageNum																						 " &vbCrlf
		sql = sql & ",type																							 " &vbCrlf
		sql = sql & ",division																					 " &vbCrlf
		sql = sql & ",fileDirectory																			 " &vbCrlf
		sql = sql & ",fileNameNew																				 " &vbCrlf
		sql = sql & ",fileNameOld																				 " &vbCrlf
		sql = sql & ",fileNameView																			 " &vbCrlf
		sql = sql & ",fileSize																					 " &vbCrlf
		sql = sql & ",fileCapacity																			 " &vbCrlf
		sql = sql & ",step																							 " &vbCrlf
		sql = sql & ") 																									 " &vbCrlf
		sql = sql & "Values(																						 " &vbCrlf
		sql = sql & " '"& pageNum														&"'					 " &vbCrlf
		sql = sql & ",'"& ""																&"'					 " &vbCrlf
		sql = sql & ",'"& ""																&"'					 " &vbCrlf
		sql = sql & ",'"& CFG_FOLDER_META										&"' 				 " &vbCrlf
		sql = sql & ",'"& newFileName												&"' 				 " &vbCrlf
		sql = sql & ",'"& oldFileName												&"'					 " &vbCrlf
		sql = sql & ",'"& viewFileName											&"'					 " &vbCrlf
		sql = sql & ",'"& fileSize													&"' 				 " &vbCrlf
		sql = sql & ",'"& fileCapacity											&"' 				 " &vbCrlf
		sql = sql & ","& pageStep														&"					 " &vbCrlf
		sql = sql & ")																									 " &vbCrlf
		Call execQuery(sql)
	End If 

	If Err.Number <> 0 Then	
		answer		= "error"
		message		= "데이터베이스 처리 에러!"
		Call errorWrite(sql)
	End If 

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
