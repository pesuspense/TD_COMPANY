<SCRIPT LANGUAGE=VBScript RUNAT=Server>
Sub Session_OnStart

	On Error Resume Next
	'---------------------------------------------------------------------------------------------
	'Define
	'---------------------------------------------------------------------------------------------
	Dim data
	Dim tempSql
	Dim tempStr
	Dim tempDiv
	Dim tempArr
	Dim tempObj
	Dim dbCon,dbRs

	Set data  				= server.CreateObject("scripting.dictionary") 	
	Set dbCon			= server.CreateObject("ADODB.Connection")

	'---------------------------------------------------------------------------------------------
	'Config	
	'---------------------------------------------------------------------------------------------
	data.add	"site_db",							"Provider=SQLOLEDB;Data Source=sql19-002.cafe24.com;Initial Catalog=okaraamc4424;user ID=okaraamc4424;password=okaraamc4424_;Network Library=DBMSSOCN;"
	data.add	"site_host",					Replace(LCase(request.ServerVariables("HTTP_HOST")),"www.","")
	data.add	"user_id",							request.cookies("userNum")
	data.add	"user_ip",							request.serverVariables("REMOTE_ADDR")
	data.add	"user_ref",						request.serverVariables("HTTP_REFERER")
	data.add	"user_type",					""
	data.add	"user_agent",				request.serverVariables("HTTP_USER_AGENT")
	data.add	"user_cookie",			request.serverVariables("HTTP_COOKIE")
	data.add	"user_session",		session.sessionID
	
	For Each tempObj In data
		data(tempObj) = replace(data(tempObj),"<","&lt;")
		data(tempObj) = replace(data(tempObj),">","&gt;")				
		data(tempObj) = replace(data(tempObj),"'","")				
		data(tempObj) = replace(data(tempObj),Chr(10),"")			
		data(tempObj) = replace(data(tempObj),Chr(13),"")			
		data(tempObj) = replace(data(tempObj),Chr(39),"")			'따옴표(소)
		data(tempObj) = replace(data(tempObj),Chr(34),"")			'따옴표(대)
		data(tempObj) = Trim(data(tempObj))
	Next

	If			InStr(data.item("user_agent"),"google")		> 0 Then			
		data.item("user_type") = "robot"
	ElseIf	InStr(data.item("user_agent"),"naver")		> 0 Then			
		data.item("user_type") = "robot"
	ElseIf	InStr(data.item("user_agent"),"daum")			> 0 Then			
		data.item("user_type") = "robot"
	ElseIf	InStr(data.item("user_agent"),"zum")			> 0 Then			
		data.item("user_type") = "robot"
	ElseIf	InStr(data.item("user_agent"),"bing")			> 0 Then			
		data.item("user_type") = "robot"
	End If

	'---------------------------------------------------------------------------------------------
	'Initiallization
	'---------------------------------------------------------------------------------------------
	dbCon.open	data.item("site_db")

	'---------------------------------------------------------------------------------------------
	'Process - Cookie
	'---------------------------------------------------------------------------------------------
	'||Set
	If data.item("user_type") = ""	Then

		response.cookies("user_type")					= "user"
		response.cookies("user_type").expires	= DateAdd("m", 12, Now())

		If data.item("user_id") = ""	Then
			Set dbRs = dbCon.execute("Select 1000000000 +(count(*)) From [user]")
			If Not dbRs.eof Then
				data.item("user_id") = dbRs(0)
				dbCon.execute "Insert Into [user](userNum) Values('"& data.item("user_id") &"')"
				response.cookies("userNum")					= data.item("user_id")
				response.cookies("userNum").expires	= DateAdd("m", 12, Now())
			End If
			dbRs.close : Set dbRs = Nothing
		End If 
	End If

	If request.cookies("visit")					= "" Then
		response.cookies("visit")					= "0"
		response.cookies("visit").expires	= DateAdd("m", 12, Now())
	Else
		If IsNumeric(request.cookies("visit")) = True Then
			response.cookies("visit")				= request.cookies("visit") +1
		Else
			response.cookies("visit")					= "0"
			response.cookies("visit").expires	= DateAdd("m", 12, Now())
		End If		
	End if


	'---------------------------------------------------------------------------------------------
	'Destruction
	'---------------------------------------------------------------------------------------------
	Set data			= Nothing 
	Set dbCon			= Nothing

	'---------------------------------------------------------------------------------------------

End Sub

'--------------------------------------------------------------------------------------------------
'||Session End
'--------------------------------------------------------------------------------------------------
Sub Session_OnEnd

End Sub


</SCRIPT>