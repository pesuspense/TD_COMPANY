<%
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||Util
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function getContentsByte(strText)
		Dim strLen, strByte, strCut, strRes, char, i 
		strLen = 0 
		strByte = 0 
		strLen = Len(strText) 
		for i = 1 to strLen 
			char = "" 
			strCut = Mid(strText, i, 1) 
			char = len(hex(ascw(strCut)))
			if char = 2 then
					strByte = strByte + 1
			else 
					strByte = strByte + 2 
			end if 
		next 
		getContentsByte = strByte
End Function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||Cafe24
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function sendCafe24SMS(sendPhon, receivePhone, title, message)
	Dim sendurl
	Dim sms_url
	Dim postData
	Dim serverXmlHttp,tmpResult
	Dim user_id,secure,encoderurl,subject,msg,rphone,sphone1,sphone2,sphone3,rdate
	Dim reserveTime,mode,rtime,returnurl,testflag,destination,repeatFlag,repeatNum,repeatTime
	Dim actionFlag,nointeractive,smsType
	Dim resultArray,resultText,resultCount,resultMessage,resultFlag

	resultFlag		= False 

	sms_url				= "https://sslsms.cafe24.com/sms_sender.php"																																				' SMS 요청 URL
	sendurl				= "http://" & Request.ServerVariables("server_name") & request.ServerVariables("PATH_INFO")
	user_id				= "tdsms1"																																																														' SMS 아이디                                                                             
	secure					= "c3cb8958ff43264dfbca28041b08f369"																																											' 인증키                                                                                 
	encoderurl		= "Y"																																																																		' 리턴 URL을 encode 해서 받을지를 결정합니다. (사용:Y, 사용안함:N, Y가 아닐 경우 변수를 여러개 넘겨받을 없습니다.) 
	subject				= ""																																																																			' 제목(LMS일 경우만)                                                                       

	msg								= message																																						                                                                          
	rphone						= receivePhone
	sphone1				= sendPhon(0) & ""
	sphone2				= sendPhon(1) & ""
	sphone3				= sendPhon(2) & ""
	rdate							= ""																																					                                                                          
	reserveTime		= ""																																					                                                                          
	mode							= "0"																																																																		'// base64 사용시 반드시 모드값을 1로 주셔야 합니다.                                              
	rtime							= ""																																																																	                                                                          
	returnurl					= ""	
	testflag					= ""	
	destination			= ""	
	repeatFlag			= ""																																														
	repeatNum			= ""																																														
	repeatTime			= ""																																														
	actionFlag			= ""	
	nointeractive		= ""																																																																				'성공시 대화 상자를 사용 하지 않게 합니다.                                                        
	smsType				= ""																																																																				'LMS 사용시 L                                                                           

	If getContentsByte(msg) > 80 Then
		smsType = "L"	
		subject =	title
	End If 

	postData			= "lang="
	postData			= postData & "&sendurl="					& sendurl
	postData			= postData & "&user_id="					& user_id
	postData			= postData & "&secure="					& secure
	postData			= postData & "&subject="					& subject
	postData			= postData & "&msg="							& msg
	postData			= postData & "&rphone="					& rphone
	postData			= postData & "&sphone1="				& sphone1
	postData			= postData & "&sphone2="				& sphone2
	postData			= postData & "&sphone3="				& sphone3
	postData			= postData & "&rdate="							& rdate
	postData			= postData & "&rtime="							& rtime
	postData			= postData & "&reserveTime="		& reserveTime
	postData			= postData & "&mode="						& mode
	postData			= postData & "&returnurl="				& returnurl
	postData			= postData & "&testflag="					& testflag
	postData			= postData & "&destination="		& destination
	postData			= postData & "&repeatFlag="			& repeatFlag
	postData			= postData & "&repeatNum="			& repeatNum
	postData			= postData & "&repeatTime="		& repeatTime
	postData			= postData & "&nointeractive="	& nointeractive
	postData			= postData & "&encoderurl="			& encoderurl
	postData			= postData & "&smsType="				& smsType

	Set serverXmlHttp = Server.CreateObject("MSXML2.serverXmlHttp.6.0")
	serverXmlHttp.open "POST", sms_url
	serverXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	serverXmlHttp.setRequestHeader "Content-Length", Len(postData)			
	serverXmlHttp.send postData
	If serverXmlHttp.status = 200 Then
			tmpResult = serverXmlHttp.responseText
	Else
			tmpResult = "Connection Fail"	' Handle missing response or other errors here
	End If
	Set serverXmlHttp = Nothing

	resultArray				=  split(tmpResult , ",")
	resultText					=  resultArray (0)
	resultCount			=  resultArray (1)
	resultMessage	= ""

	Select Case resultText
	Case "Test Success!"
		resultFlag		= True 
		resultMessage = "테스트성공  잔여건수는 "& resultCount &"건 입니다."
	Case "success"
		resultFlag		= True 
		resultMessage = "문자 정상적으로 전송되었습니다."
	Case "reserved"
		resultMessage = "예약되었습니다. 잔여건수는 "& resultCount &"건 입니다."
	Case "3205"
		resultMessage = "잘못된 번호형식입니다."
	Case "0044"
		resultMessage = "스팸문자는 보낼 수 없습니다."
	Case Else
		resultMessage = "[Error]"& Result
	End Select
	
	If resultFlag = False Then
		'Response.Write resultText & "<br>"
		'Response.write "SMS Error Message : " & resultMessage & "<br>"
	End If 
	sendCafe24SMS = resultFlag
End Function

' [발송하기]
'	Dim sendPhone, receivePhone, title, message
'	sendPhone				= Split("010-2530-8691", "-")
'	receivePhone			= "010-2530-8691"
'	title										= "옥길아라동물의료센터"
'	message						= ""
'	message						= message & "상담 문의가 도착했습니다."																&vbCrlf
'	message						= message & "성명: "			& "테스터"																					&vbCrlf
'	message						= message & "연락처: "			& receivePhone																&vbCrlf
'	message						= message & "문의내용▼ "																											&vbCrlf
'	Response.write sendCafe24SMS(sendPhone, receivePhone, title, message)
'	Response.end
%>
                