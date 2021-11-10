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
Dim idx
Dim target,parent


'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer				= "ok"
message				= "완료"

sql						= ""
target				= getClearstr(request("target"))
parent				= getClearstr(request("parent"))

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then
	sql = ""
	sql = sql & "Declare @pageNum				varchar(10)				= (Select isNull(max(pageNum),999999999) +1 From page_item)		" &vbCrlf
	sql = sql & "Declare @pageNumParent	varchar(10)				= '"& parent &"'																							" &vbCrlf
	sql = sql & "Declare @pageStep			int								= (Select isNull(max(step),0)+1 From page_item)								" &vbCrlf
	sql = sql & "Insert Into page_item(pageNum,pageNumParent,step) values(@pageNum, @pageNumParent, @pageStep)					" &vbCrlf
	sql = sql & "Insert Into page_meta(pageNum,step) values(@pageNum, 1)																								" &vbCrlf
	'response.write Replace(sql,vbCrlf,"<br/>") : response.end
	Call execQuery(sql)

	If Err.Number <> 0 Then	
		answer	= "error"
		message	= "데이터베이스 처리 에러!"
		Call errorWrite(sql)
	Else
		idx	= getExecQueryReValue("Select Top 1 idx From page_item order by idx desc")
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
