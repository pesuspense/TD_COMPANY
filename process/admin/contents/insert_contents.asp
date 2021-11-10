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
Dim comSite,comUrl
Dim contentsType


'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
sql						= ""
answer				= "ok"
message				= "완료"
contentsType	= getClearstr(request("type"))

'-----------------------------------------------------------------------------------------------------
'Checking
'-----------------------------------------------------------------------------------------------------
If contentsType	= "" Then 
	answer			= "error"
	message			= "요청 데이터가 부족합니다!"
End If 

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then
	sql = ""
	sql = sql & "Declare @contentsNum		varchar(10)																																																																								" &vbCrlf
	sql = sql & "Declare @step					int								= (Select isNull(max(step),0)+1 From contents_default Where type = '"& contentsType &"')																								" &vbCrlf
	sql = sql & "Select @contentsNum = isNull(max(contentsNum),999999999) +1 From contents_default																																																" &vbCrlf
	sql = sql & "Insert Into contents_default(memberNum,contentsNum,type,division,step,state)	values('"& getCookie("mem_num") &"',@contentsNum, '"& contentsType &"', '', @step, '대기')						" &vbCrlf
	sql = sql & "Insert Into contents_detail(contentsNum,type,division,contents)	values(@contentsNum, 'default', '', '')																																					" &vbCrlf
	'response.write Replace(sql,vbCrlf,"<br/>") : response.end
	Call execQuery(sql)

	If Err.Number <> 0 Then	
		answer	= "error"
		message	= "데이터베이스 처리 에러!"
		Call errorWrite(sql)
	Else
		idx	= getExecQueryReValue("Select Top 1 idx From contents_default order by idx desc")
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
