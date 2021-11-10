<!-- #include virtual="/lib/include/charset.asp"	-->
<!-- #include virtual="/lib/config/global.asp"		-->
<!-- #include virtual="/lib/class/dbHelper.asp"		-->
<!-- #include virtual="/lib/function/global.asp"	-->
<!-- #include virtual="/lib/include/json.asp"	-->
<%
'On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Description
'-----------------------------------------------------------------------------------------------------
Dim CFG_ALIGO_ID						: CFG_ALIGO_ID						= "ddabongeleven"
Dim CFG_ALIGO_API_KEY				: CFG_ALIGO_API_KEY				= "wk37d5lkx1660886tqbi5znz4ilmla0g"
Dim CFG_ALIGO_SENDER_KEY		: CFG_ALIGO_SENDER_KEY		= "157de6903458f933153cd9da8aadaf99d6faa389"
Dim CFG_ALIGO_SENDER_TEL		: CFG_ALIGO_SENDER_TEL		= "010-2530-8691"
Dim CFG_ALIGO_RECEIVER_TEL	: CFG_ALIGO_RECEIVER_TEL	= "010-2530-8691"
Dim CFG_ALIGO_RECEIVER_NAME	: CFG_ALIGO_RECEIVER_NAME	= "옥길아라동물의료센터"
Dim CFG_KAKAO_PLUS_ID				: CFG_KAKAO_PLUS_ID				= "@ddabong11"

'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

'-----------------------------------------------------------------------------------------------------
'Function
'-----------------------------------------------------------------------------------------------------
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
	Dim req,resData
	Dim result
	result = "x"
	param = ""
	param = param & "apikey="					& CFG_ALIGO_API_KEY
	param = param & "&userid="				& CFG_ALIGO_ID
	param = param & "&token="					& token
	param = param & "&senderkey="			& CFG_ALIGO_SENDER_KEY
	param = param & "&tpl_code="			& "TD_3517"
	param = param & "&sender="				& server.UrlEncode(CFG_ALIGO_SENDER_TEL)
	param = param & "&receiver_1="		& server.UrlEncode(CFG_ALIGO_RECEIVER_TEL)
	param = param & "&recvname_1="		& server.UrlEncode(CFG_ALIGO_RECEIVER_NAME)
	param = param & "&subject_1="			& "옥길아라동물의료센터 - 상담신청"
	param = param & "&message_1="			&	server.UrlEncode(msg)
 	param = param & "&fsubject_1="		&	"옥길아라동물의료센터 - 상담신청"
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
	End If 
	Set req		= Nothing 
	Set js		= Nothing 
	sendAligoKakaoNotificationTalk = result
End Function

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer							= "ok"
message							= "완료"

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then

	Dim msg
	Dim token 

	token = getAligoKakaoToken()	

	If token <>  "x" Then

		msg = ""
		msg = msg & "옥길아라동물의료센터 문의가 도착했습니다."							&vbCrlf &vbCrlf
		msg = msg & "고객성명: 강경모"													&vbCrlf
		msg = msg & "전화번호: 010-2530-8691"								&vbCrlf
		msg = msg & "문의내용:"															&vbCrlf
		msg = msg & "안녕하세요? 강경모입니다."										&vbCrlf	

		Response.write sendAligoKakaoNotificationTalk(msg)

	End If 

End If
'-----------------------------------------------------------------------------------------------------
'Test
'-----------------------------------------------------------------------------------------------------
'||카카오채널 관리 - 인증요청
'	param = ""
'	param = param & "userid="					& CFG_ALIGO_ID
'	param = param & "&plusid="				& "@ddabong11"
'	param = param & "&apikey="				& CFG_ALIGO_API_KEY
'	param = param & "&token="					& token
'	param = param & "&phonenumber="		& token
'	Set req = Server.CreateObject("Msxml2.ServerXMLHTTP")
'	req.open "POST", "https://kakaoapi.aligo.in/akv10/profile/auth/", False
'	req.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
'	req.send param
'	resState = req.status
'	resData	 = req.responseText
'	Set js = JSON.parse(resData)
'	Response.write resState			&"<br>"
'	Response.write resData			&"<br>"
'	Response.write js.code			&"<br>"
'	Response.write js.message		&"<br>"

'	param = ""
'	param = param & "apikey="					& CFG_ALIGO_API_KEY
'	param = param & "&userid="				& CFG_ALIGO_ID
'	param = param & "&token="					& token
'	param = param & "&senderkey="			& CFG_ALIGO_SENDER_KEY
'	param = param & "&tpl_code="			& "TD_3517"
'	param = param & "&sender="				& server.UrlEncode(CFG_ALIGO_SENDER_TEL)
'	param = param & "&receiver_1="		& server.UrlEncode(CFG_ALIGO_RECEIVER_TEL)
'	param = param & "&recvname_1="		& server.UrlEncode(CFG_ALIGO_RECEIVER_NAME)
'	param = param & "&subject_1="			& "Subject"
'	param = param & "&message_1="			&	msg
'	param = param & "&fsubject_1="		&	"Subject"
'	param = param & "&fmessage_1="		&	msg
'	param = param & "&failover=Y"																				 
'	param = param & "&testMode=N"
'	Set req = Server.CreateObject("MSXML2.ServerXMLHTTP")
'	req.open "POST", "https://kakaoapi.aligo.in//akv10/alimtalk/send/", False
'	req.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"			
'	req.send param
'	resState = req.status
'	resData	 = req.responseText
'	Set js = JSON.parse(resData)
'	Response.write resState			&"<br>"
'	Response.write resData			&"<br>"
'	Response.write js.code			&"<br>"
'	Response.write js.message		&"<br>"
'-----------------------------------------------------------------------------------------------------
%>
