<!-- #include virtual="/lib/include/adminProcessBundle.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

Dim queryFileName
Dim fileFormName,filePath,fName1,fName2,fNameExt,fileSize,fileCapacity

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer				= "ok"
message				= "완료"

sql						= ""

If request.querystring("methodType")&"" = "" Then
	Set	uploadform							= Server.CreateObject("DEXT.FileUpload")
			uploadform.DefaultPath	= server.mappath(CFG_FOLDER_CONTENTS)
			uploadform.CodePage			= 65001
Else
	Set	uploadform							= request
End If

procType			= uploadform("procType")					: If procType & "" = "" Then procType = "w"

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then

	Select Case procType 
	Case "w"																																														'파일등록
		fileFormName			= "DataFieldName"
		fName1						= uploadform(fileFormName).FileName		&""
		fName2						= Replace(Replace(date,"-","") & Replace(Right(now,8),":","") & getRnd(10000,99999), " ", "")
		fName3						= fName2
		fNameExt					= LCase(Mid(fName1, InstrRev(fName1,".")+1))
		queryFileName			= server.mappath(CFG_FOLDER_CONTENTS) &"\"& CFG_SES_NUM  &".txt"

		'||파일저장
		filePath			= uploadform(fileFormName).SaveAs(fName2&"."&fNameExt , true)
		fileSize			= uploadform(fileFormName).ImageWidth &"*"& uploadform(fileFormName).ImageHeight
		fileCapacity	= uploadform(fileFormName).FileLen 

		Set uploadform = Nothing

		'||Sql저장(원본)
		sql = ""
		sql = sql & "Insert Into contents_file( " 
		sql = sql & " contentsNum" 
		sql = sql & ",type" 
		sql = sql & ",division" 
		sql = sql & ",fileDirectory" 
		sql = sql & ",fileNameNew" 
		sql = sql & ",fileNameOld" 
		sql = sql & ",fileNameView" 
		sql = sql & ",fileSize" 
		sql = sql & ",fileCapacity" 
		sql = sql & ",step" 
		sql = sql & ") " 
		sql = sql & "Values(" 
		sql = sql & " 'set_target'" 
		sql = sql & ",'set_type'" 
		sql = sql & ",'set_division'" 
		sql = sql & ",'"& CFG_FOLDER_CONTENTS								&"'" 
		sql = sql & ",'"& fName2 &"."& fNameExt							&"'" 
		sql = sql & ",'"& fName1														&"'" 
		sql = sql & ",''" 
		sql = sql & ",'"& fileSize													&"'" 
		sql = sql & ",'"& fileCapacity											&"'" 
		sql = sql & ",set_step" 
		sql = sql & ");"																		&vbCrlf
		Call file_write(queryFileName, sql)
		response.end
	End Select
	
	
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
response.Write						"		<idx>"			& escape(idx)				&" </idx>"					&vbCrlf
response.Write						"		<answer>"		& escape(answer)		&" </answer>"				&vbCrlf
response.Write						"		<message>"	& escape(message)		&" </message>"			&vbCrlf
response.Write						"</result>"

'-----------------------------------------------------------------------------------------------------
%>
