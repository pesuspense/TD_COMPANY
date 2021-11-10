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
Dim fileFieldName,fileDirectory,fileSize,fileCapacity,fileExtension,saveFilePath
Dim oldFileName,newFileName, viewFileName
Dim name,file,exposed_time,start_date,end_date,view_device

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

file										= uploadform(fileFieldName)
name										= getClearstr(uploadform("name"))
exposed_time						= getClearstr(uploadform("exposed_time"))
start_date							= getClearstr(uploadform("start_date"))
end_date								= getClearstr(uploadform("end_date"))
view_device							= "all"

'-----------------------------------------------------------------------------------------------------
'Check
'-----------------------------------------------------------------------------------------------------
If answer = "ok" And name									= ""		Then answer = "x" : message = "팝업 제목이 전달되지 않았습니다."
If answer = "ok" And file									= ""		Then answer = "x" : message = "팝업 파일이 전달되지 않았습니다."
If answer = "ok" And exposed_time					= ""		Then answer = "x" : message = "팝업 시간이 전달되지 않았습니다."
If answer = "ok" And start_date						= ""		Then answer = "x" : message = "팝업 시작날짜가 전달되지 않았습니다."
If answer = "ok" And isDate(start_date)		= False	Then answer = "x" : message = "팝업 시작날짜가 정확하지 않았습니다."
If answer = "ok" And end_date							= ""		Then answer = "x" : message = "팝업 종료날짜가 전달되지 않았습니다."
If answer = "ok" And isDate(end_date)			= False	Then answer = "x" : message = "팝업 종료날짜가 정확하지 않았습니다."

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
		sql = sql & "Declare @popup_no				varchar(10)	= (Select isNull(max(popup_no),				999999999)	+ 1 From dbo.popup)					" &vbCrlf
		sql = sql & "Declare @popup_file_no		varchar(10)	= (Select isNull(max(popup_file_no),	999999999)	+ 1 From dbo.popup_file)		" &vbCrlf
		sql = sql & "Declare @order_num				int					= (Select isNull(max(order_num),			0)					+ 1 From dbo.popup)					" &vbCrlf
		sql = sql & "Insert Into dbo.popup(																																															" &vbCrlf
		sql = sql & " popup_no																																																					" &vbCrlf
		sql = sql & ",name																																																							" &vbCrlf
		sql = sql & ",view_device																																																				" &vbCrlf
		sql = sql & ",exposed_time																																																			" &vbCrlf
		sql = sql & ",start_date																																																				" &vbCrlf
		sql = sql & ",end_date																																																					" &vbCrlf
		sql = sql & ",order_num																																																					" &vbCrlf
		sql = sql & ")																																																									" &vbCrlf
		sql = sql & "Values(																																																						" &vbCrlf
		sql = sql & " @popup_no																																																					" &vbCrlf
		sql = sql & ",'"& name							&"'																																													" &vbCrlf
		sql = sql & ",'"& view_device				&"'																																													" &vbCrlf
		sql = sql & ",'"& exposed_time			&"'																																													" &vbCrlf
		sql = sql & ",'"& start_date				&"'																																													" &vbCrlf
		sql = sql & ",'"& end_date					&"'																																													" &vbCrlf
		sql = sql & ",@order_num																																																				" &vbCrlf
		sql = sql & ")																																																									" &vbCrlf
		sql = sql & "Insert Into dbo.popup_file(																																												" &vbCrlf
		sql = sql & " popup_no																																																					" &vbCrlf
		sql = sql & ",popup_file_no																																																			" &vbCrlf
		sql = sql & ",file_type																																																					" &vbCrlf
		sql = sql & ",file_capacity																																																			" &vbCrlf
		sql = sql & ",file_directory																																																		" &vbCrlf
		sql = sql & ",old_name																																																					" &vbCrlf
		sql = sql & ",new_name																																																					" &vbCrlf
		sql = sql & ",view_name																																																					" &vbCrlf
		sql = sql & ",order_num																																																					" &vbCrlf
		sql = sql & ")																																																									" &vbCrlf
		sql = sql & "Values (																																																						" &vbCrlf
		sql = sql & " @popup_no																																																					" &vbCrlf
		sql = sql & ",@popup_file_no																																																		" &vbCrlf
		sql = sql & ",'image'																																																						" &vbCrlf
		sql = sql & ",'"& fileCapacity			&"'																																													" &vbCrlf
		sql = sql & ",'"& fileDirectory			&"'																																													" &vbCrlf
		sql = sql & ",'"& oldFileName				&"'																																													" &vbCrlf
		sql = sql & ",'"& newFileName				&"'																																													" &vbCrlf
		sql = sql & ",'"& viewFileName			&"'																																													" &vbCrlf
		sql = sql & ",1																																																									" &vbCrlf
		sql = sql & ")																																																									" &vbCrlf
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
