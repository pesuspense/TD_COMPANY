<!-- #include virtual="/lib/include/charset.asp"	-->
<!-- #include virtual="/lib/config/global.asp"		-->
<!-- #include virtual="/lib/class/dbHelper.asp"		-->
<!-- #include virtual="/lib/function/global.asp"	-->
<!-- #include virtual="/lib/include/json.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Aligo
'-----------------------------------------------------------------------------------------------------
Dim CFG_ALIGO_ID						: CFG_ALIGO_ID						= "ddabongeleven"
Dim CFG_ALIGO_API_KEY				: CFG_ALIGO_API_KEY				= "wk37d5lkx1660886tqbi5znz4ilmla0g"
Dim CFG_ALIGO_SENDER_KEY		: CFG_ALIGO_SENDER_KEY		= "157de6903458f933153cd9da8aadaf99d6faa389"
Dim CFG_ALIGO_SENDER_TEL		: CFG_ALIGO_SENDER_TEL		= "010-2530-8691"
Dim CFG_ALIGO_RECEIVER_TEL	: CFG_ALIGO_RECEIVER_TEL	= "010-9961-0511"
Dim CFG_ALIGO_RECEIVER_NAME	: CFG_ALIGO_RECEIVER_NAME	= "옥길아라동물의료센터"
Dim CFG_ALIGO_TITLE					: CFG_ALIGO_TITLE					= "옥길아라동물의료센터 - 상담신청"

Function getAligoKakaoToken()
	Dim js
	Dim param
	Dim req,resData
	Dim result
	result = "x"
	param	 = ""
	param	 = param & "apikey="		& CFG_ALIGO_API_KEY 
	param	 = param & "&userid="		&	CFG_ALIGO_ID
	Set req = Server.CreateObject("MSXML2.ServerXMLHTTP")
	req.open "POST", "https://kakaoapi.aligo.in/akv10/token/create/60/s/?apikey=wk37d5lkx1660886tqbi5znz4ilmla0g&userid=ddabongeleven", False
	req.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"		
	req.send param
	resState = req.status
	resData	 = req.responseText
	If resState = "200" Then
		resData	 = req.responseText
		Set js = JSON.parse(resData)
		If js.code = "0" Then
			result = js.urlencode
		End If 
		Set js = Nothing 
	End If 
	Set req = Nothing
	getAligoKakaoToken = result 
End Function

Function sendAligoKakaoNotificationTalk(msg)
	Dim js
	Dim param
	Dim token
	Dim result
	Dim req,resData
	token		= getAligoKakaoToken()
	result	= "x"
	If token <> "x" Then
		param = ""
		param = param & "apikey="					& CFG_ALIGO_API_KEY
		param = param & "&userid="				& CFG_ALIGO_ID
		param = param & "&token="					& token
		param = param & "&senderkey="			& CFG_ALIGO_SENDER_KEY
		param = param & "&tpl_code="			& "TD_3517"
		param = param & "&sender="				& server.UrlEncode(CFG_ALIGO_SENDER_TEL)
		param = param & "&receiver_1="		& server.UrlEncode(CFG_ALIGO_RECEIVER_TEL)
		param = param & "&recvname_1="		& server.UrlEncode(CFG_ALIGO_RECEIVER_NAME)
		param = param & "&subject_1="			& server.UrlEncode(CFG_ALIGO_TITLE)
		param = param & "&message_1="			&	server.UrlEncode(msg)
		param = param & "&fsubject_1="		&	server.UrlEncode(CFG_ALIGO_TITLE)
		param = param & "&fmessage_1="		&	server.UrlEncode(msg)
		param = param & "&failover=Y"																				 
		param = param & "&testMode=N"
		Set req = Server.CreateObject("MSXML2.ServerXMLHTTP")
		req.open "POST", "https://kakaoapi.aligo.in//akv10/alimtalk/send/", False
		req.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"			
		req.send param
		resState = req.status
		resData	 = req.responseText
		Set js = JSON.parse(resData)
		If js.code = "0" Then
			result = "o"		
		Else
			'Response.write js.message
		End If 
		Set req		= Nothing 
		Set js		= Nothing 
	End If 
	sendAligoKakaoNotificationTalk = result
End Function

'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim msg
Dim answer,message

Dim sql
Dim idx
Dim req_type,req_division,req_name,req_tel,req_email,req_address,req_title,req_contents,req_state

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer							= "ok"
message							= "완료"

sql									= ""
req_type						= "top"
req_division				= ""
req_name						= getClearstr(request("name"))
req_tel							= getClearstr(request("tel"))
req_contents				= getClearstr(request("contents"))
req_state						= "대기"

'-----------------------------------------------------------------------------------------------------
'Check
'-----------------------------------------------------------------------------------------------------
If Len(req_name)			< 2		Then
	answer	= "error" : message	= "이름을 2자 이상 입력하세요!"
End If 

If Len(req_tel)				< 11		Then
	answer	= "error" : message	= "전화번호 11자 이상 입력하세요!"
End If 

If Len(req_contents)	= ""	Then
	answer	= "error" : message	= "문의하실 내용을 입력하세요!"
End If 

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then
	sql = ""
	sql = sql & "Insert Into inquiry_default(inquiryNum,type,division,name,phone,email,address,title,reqContents,state)						" &vbCrlf
	sql = sql & "Select																																																						" &vbCrlf
	sql = sql & " (Select isNull(max(inquiryNum),999999999) +1 From inquiry_default)																							" &vbCrlf
	sql = sql & ",'"& req_type				&"'																																													" &vbCrlf
	sql = sql & ",'"& req_division		&"'																																													" &vbCrlf
	sql = sql & ",'"& req_name				&"'																																													" &vbCrlf
	sql = sql & ",'"& req_tel					&"'																																													" &vbCrlf
	sql = sql & ",'"& ""							&"'																																													" &vbCrlf
	sql = sql & ",'"&	""							&"'																																													" &vbCrlf
	sql = sql & ",'"& ""							&"'																																													" &vbCrlf
	sql = sql & ",'"& req_contents		&"'																																													" &vbCrlf
	sql = sql & ",'"& req_state				&"'																																													" &vbCrlf
	'response.write Replace(sql,vbCrlf,"<br/>") : response.end
	Call execQuery(sql)

	If Err.Number <> 0 Then	
		answer	= "error"
		message	= "데이터베이스 처리 에러!"
		Call errorWrite(sql)
	Else

		msg = ""
		msg = msg & "옥길아라동물의료센터 문의가 도착했습니다."						&vbCrlf &vbCrlf
		msg = msg & "고객성명: "& req_name &""							&vbCrlf
		msg = msg & "전화번호: "& req_tel		&""						&vbCrlf
		msg = msg & "문의내용:"														&vbCrlf
		msg = msg & req_contents												&vbCrlf	
		Call sendAligoKakaoNotificationTalk(msg)

		'If sendAligoKakaoNotificationTalk(msg) = "x" Then
		'	answer	= "error"
		' message	= "관리자에게 문의하세요!"
		'End If 
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
