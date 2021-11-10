<!-- #include virtual="/lib/include/charset.asp"				-->
<!-- #include virtual="/lib/config/global.asp"						-->
<!-- #include virtual="/lib/class/dbHelper.asp"				-->
<!-- #include virtual="/lib/function/global.asp"					-->
<!-- #include virtual="/lib/include/json.asp"						-->
<!-- #include virtual="/lib/function/cafe24SMS.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim msg
Dim answer,message

Dim sql
Dim idx
Dim toAddress,fromAddress,mailSubject,mailMessage
Dim req_type,req_division,req_name,req_phone,req_email,req_address,req_title,req_contents,req_state

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer							= "ok"
message						= "완료"

sql										= ""
req_type							= "top"
req_division				= ""
req_name						= getClearstr(request("name"))
req_phone					= getClearstr(request("phone"))
req_contents			= getClearstr(request("contents"))
req_state						= "대기"

'-----------------------------------------------------------------------------------------------------
'Check
'-----------------------------------------------------------------------------------------------------
If Len(req_name)			< 2			Then
	answer	= "error" : message	= "이름을 2자 이상 입력하세요!"
End If 

If Len(req_phone)			< 13		Then
	answer	= "error" : message	= "연락처 13자리를 입력하세요!"
End If 

'If Len(req_contents)	= ""		Then
'	answer	= "error" : message	= "문의하실 내용을 입력하세요!"
'End If 

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then
	sql = ""
	sql = sql & "Insert Into inquiry_default(inquiryNum,type,division,name,phone,email,address,title,reqContents,state)		" &vbCrlf
	sql = sql & "Select																																																																				" &vbCrlf
	sql = sql & " (Select isNull(max(inquiryNum),999999999) +1 From inquiry_default)																										" &vbCrlf
	sql = sql & ",'"& req_type							&"'																																																							" &vbCrlf
	sql = sql & ",'"& req_division				&"'																																																							" &vbCrlf
	sql = sql & ",'"& req_name						&"'																																																							" &vbCrlf
	sql = sql & ",'"& req_phone					&"'																																																							" &vbCrlf
	sql = sql & ",'"& ""											&"'																																																							" &vbCrlf
	sql = sql & ",'"&	""											&"'																																																							" &vbCrlf
	sql = sql & ",'"& ""											&"'																																																							" &vbCrlf
	sql = sql & ",'"& req_contents				&"'																																																							" &vbCrlf
	sql = sql & ",'"& req_state						&"'																																																							" &vbCrlf
	'response.write Replace(sql,vbCrlf,"<br/>") : response.end
	'Call execQuery(sql)

	If Err.Number <> 0 Then	
		answer	= "error"
		message	= "데이터베이스 처리 에러!"
		Call errorWrite(sql)
	Else
		msg					= ""                                                                     
		msg					= msg & "[옥길아라동물의료센터]"																						&vbCrlf  
		msg					= msg & "상담 문의가 도착했습니다."																	&vbCrlf  
		msg					= msg & "성명: "					& req_name																			&vbCrlf  
		msg					= msg & "연락처: "			& req_phone																			&vbCrlf  &vbCrlf  
		msg					= msg & req_contents																																													
		Call sendCafe24SMS(Split("010-8690-2963", "-"), "010-9961-0511", "옥길아라동물의료센터", msg)                    '||010-9961-0511
		'Response.write Replace(msg,Chr(10),"<br>") & "<br>" : Response.End 
	
	End If 
Else
		Call errorWrite(message)
End If

'-----------------------------------------------------------------------------------------------------
'Returns
'-----------------------------------------------------------------------------------------------------
response.Charset			=		"euc-kr"
response.ContentType	=		"text/xml"
response.Write						"<?xml version=""1.0"" encoding=""utf-8"" ?>"										&vbCrlf
response.Write						"<result>"
response.Write						"		<answer>"		& escape(answer)		&" </answer>"					&vbCrlf
response.Write						"		<message>"	& escape(message)		&" </message>"			&vbCrlf
response.Write						"</result>"
'-----------------------------------------------------------------------------------------------------
%>
