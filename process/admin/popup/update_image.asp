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

Dim sql
Dim target,file
Dim fileFieldName,fileDirectory,fileSize,fileCapacity,fileExtension,saveFilePath
Dim oldFileName,newFileName,viewFileName

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer									= "ok"
message									= "완료"

sql											= ""
fileFieldName						= "file"
fileDirectory						= CFG_FOLDER_POPUP

Set	uploadform					= server.createObject("DEXT.FileUpload")
uploadform.defaultPath	= server.mappath(fileDirectory)
uploadform.codePage			= 65001

target									= uploadform("target")
file										= uploadform(fileFieldName)

'-----------------------------------------------------------------------------------------------------
'Check
'-----------------------------------------------------------------------------------------------------
If answer = "ok" And target = "" Then answer = "x" : message = "팝업 대상이 전달되지 않았습니다."
If answer = "ok" And file		= "" Then answer = "x" : message = "팝업 이미지가 전달되지 않았습니다."

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then

	fileExtension						= uploadform(fileFieldName).FileExtension & ""
	If fileExtension <> "" And InStr("jpg,png,gif",fileExtension) > 0 Then
		fileSize					= uploadform(fileFieldName).ImageWidth &"*"& uploadform(fileFieldName).ImageHeight
		fileCapacity			= uploadform(fileFieldName).FileLen										& ""
		oldFileName				= uploadform(fileFieldName).FileNameWithoutExt 				& ""
		oldFileName				= getClearstr(oldFileName)														& ""
		viewFileName			=	oldFileName
		newFileName				= Replace(Replace(date,"-","") & Replace(Right(now,8),":","") & getRnd(10000,99999), " ", "")
		oldFileName				= oldFileName		&"."& fileExtension
		viewFileName			=	viewFileName	&"."& fileExtension
		newFileName				= newFileName		&"."&	fileExtension
		saveFilePath			= uploadform(fileFieldName).saveAs(newFileName, true)
	Else
		answer	= "x"
		message	= "jpg, png, gif 파일 형식만 업로드 가능합니다."
	End If 

	If answer = "ok" Then
		sql = ""
		sql = sql & "Update BB																												" &vbCrlf
		sql = sql & "Set																															" &vbCrlf
		sql = sql & " BB.file_capacity		= '"& fileCapacity	&"'											" &vbCrlf
		sql = sql & ",BB.file_directory		= '"& fileDirectory &"'											" &vbCrlf
		sql = sql & ",BB.old_name					= '"& oldFileName		&"'											" &vbCrlf
		sql = sql & ",BB.new_name					= '"& newFileName	  &"'											" &vbCrlf
		sql = sql & ",BB.view_name				= '"& viewFileName	&"'											" &vbCrlf
		sql = sql & "From		dbo.popup		As AA																					" &vbCrlf
		sql = sql & "Inner Join	dbo.popup_file	As BB On AA.popup_no = BB.popup_no		" &vbCrlf
		sql = sql & "Where AA.seq = '"& target &"'																		" &vbCrlf
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

Set uploadform = Nothing 
'-----------------------------------------------------------------------------------------------------
'Returns
'-----------------------------------------------------------------------------------------------------
response.Charset			=		"euc-kr"
response.ContentType		=		"text/xml"
response.Write						"<?xml version=""1.0"" encoding=""utf-8"" ?>"							&vbCrlf
response.Write						"<result>"
response.Write						"		<answer>"		& escape(answer)		&" </answer>"					&vbCrlf
response.Write						"		<message>"	& escape(message)		&" </message>"				&vbCrlf
response.Write						"</result>"

'-----------------------------------------------------------------------------------------------------
%>
