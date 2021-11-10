<%
Function setCommonHistory()

	On Error Resume Next
	'-------------------------------------------------------------------------------------------------------------------------------------------
	'||Define
	'-------------------------------------------------------------------------------------------------------------------------------------------
	Dim table
	Dim tempStr
	Dim tempObj
	Dim dataHistory
	Set dataHistory  	 = server.CreateObject("scripting.dictionary") 

	'-------------------------------------------------------------------------------------------------------------------------------------------
	'||Config
	'-------------------------------------------------------------------------------------------------------------------------------------------
	dataHistory.add	"site_host",			request.serverVariables("HTTP_HOST")

	dataHistory.add	"user_device",		getCheckBroswer()
	dataHistory.add	"user_id",				getCookie("userNum")
	dataHistory.add	"user_ip",				request.serverVariables("REMOTE_ADDR")
	dataHistory.add	"user_ref",				request.serverVariables("HTTP_REFERER")
	dataHistory.add	"user_url",				request.serverVariables("URL")
	dataHistory.add	"user_qry",				request.serverVariables("QUERY_STRING")
	dataHistory.add	"user_type",			""
	dataHistory.add	"user_division",	""
	dataHistory.add	"user_visit",			getCookie("visit")
	dataHistory.add	"user_agent",			request.serverVariables("HTTP_USER_AGENT")
	dataHistory.add	"user_cookie",		request.serverVariables("HTTP_COOKIE")
	dataHistory.add	"user_method",		request.serverVariables("REQUEST_METHOD")
	dataHistory.add	"user_session",		session.sessionID
	dataHistory.add	"user_language",	request.serverVariables("HTTP_ACCEPT_LANGUAGE")
	
	For Each tempObj In dataHistory
		dataHistory(tempObj) = replace(dataHistory(tempObj),"<","&lt;")
		dataHistory(tempObj) = replace(dataHistory(tempObj),">","&gt;")				
		dataHistory(tempObj) = replace(dataHistory(tempObj),"'","")				
		dataHistory(tempObj) = replace(dataHistory(tempObj),"--","")				
		dataHistory(tempObj) = replace(dataHistory(tempObj),Chr(10),"")			
		dataHistory(tempObj) = replace(dataHistory(tempObj),Chr(13),"")			
		dataHistory(tempObj) = replace(dataHistory(tempObj),Chr(39),"")			'따옴표(소)
		dataHistory(tempObj) = replace(dataHistory(tempObj),Chr(34),"")			'따옴표(대)
		dataHistory(tempObj) = Trim(dataHistory(tempObj))
	Next

	If			InStr(dataHistory.item("user_agent"),"google") > 0 Then			
		dataHistory.item("user_type")			= "robot"
		dataHistory.item("user_division") = "google"
	ElseIf	InStr(dataHistory.item("user_agent"),"naver")	 > 0 Then			
		dataHistory.item("user_type")			= "robot"
		dataHistory.item("user_division") = "naver"
	ElseIf	InStr(dataHistory.item("user_agent"),"daum")	 > 0 Then			
		dataHistory.item("user_type")			= "robot"
		dataHistory.item("user_division") = "daum"
	ElseIf	InStr(dataHistory.item("user_agent"),"zum")		 > 0 Then			
		dataHistory.item("user_type")			= "robot"
		dataHistory.item("user_division") = "zum"
	ElseIf	InStr(dataHistory.item("user_agent"),"bing")	 > 0 Then			
		dataHistory.item("user_type")			= "robot"
		dataHistory.item("user_division") = "bing"
	End If

	'-------------------------------------------------------------------------------------------------------------------------------------------
	'||Save
	'-------------------------------------------------------------------------------------------------------------------------------------------

	If dataHistory.item("user_type") = "" Then
		table = "user_history"
	Else
		table = "robot_history"
	End If

	tempStr = ""
	tempStr = tempStr &"Insert Into "& table &"(												" &vbCrlf
	tempStr = tempStr &" userNum																				" &vbCrlf
	tempStr = tempStr &",type																						" &vbCrlf
	tempStr = tempStr &",division																				" &vbCrlf
	tempStr = tempStr &",ip																							" &vbCrlf
	tempStr = tempStr &",session																				" &vbCrlf
	tempStr = tempStr &",device																					" &vbCrlf
	tempStr = tempStr &",host																						" &vbCrlf
	tempStr = tempStr &",cookie																					" &vbCrlf
	tempStr = tempStr &",agent																					" &vbCrlf
	tempStr = tempStr &",visit																					" &vbCrlf
	tempStr = tempStr &",ref																						" &vbCrlf
	tempStr = tempStr &",url																						" &vbCrlf
	tempStr = tempStr &")																								" &vbCrlf
	tempStr = tempStr &"Values(																					" &vbCrlf
	tempStr = tempStr &" '"& dataHistory.item("user_id")			    &"'		" &vbCrlf
	tempStr = tempStr &",'"& dataHistory.item("user_type")		    &"'		" &vbCrlf
	tempStr = tempStr &",'"& dataHistory.item("user_division")		&"'		" &vbCrlf
	tempStr = tempStr &",'"& dataHistory.item("user_ip")			    &"'		" &vbCrlf
	tempStr = tempStr &",'"& dataHistory.item("user_session")			&"'		" &vbCrlf
	tempStr = tempStr &",'"& dataHistory.item("user_device")		  &"'		" &vbCrlf
	tempStr = tempStr &",'"& dataHistory.item("site_host")		    &"'		" &vbCrlf
	tempStr = tempStr &",'"& dataHistory.item("user_cookie")	    &"'		" &vbCrlf
	tempStr = tempStr &",'"& dataHistory.item("user_agent")				&"'		" &vbCrlf
	tempStr = tempStr &",'"& dataHistory.item("user_visit")				&"'		" &vbCrlf
	tempStr = tempStr &",'"& dataHistory.item("user_ref")				  &"'		" &vbCrlf
	tempStr = tempStr &",'"& dataHistory.item("user_url")					&"'		" &vbCrlf
	tempStr = tempStr &")																								" &vbCrlf

	'Call execQuery(tempStr)

	If Err.Number <> 0 Then
		Call errWrite()
		Err.Clear		
	End If


	'-------------------------------------------------------------------------------------------------------------------------------------------
	'||Destruction
	'-------------------------------------------------------------------------------------------------------------------------------------------
	If check = "" Then
		Set dataHistory = Nothing
	End If

	'-------------------------------------------------------------------------------------------------------------------------------------------
End Function


'-------------------------------------------------------------------------------------------------------------------------------------------
'||실행
'-------------------------------------------------------------------------------------------------------------------------------------------
Call setCommonHistory()

'-------------------------------------------------------------------------------------------------------------------------------------------
%>


