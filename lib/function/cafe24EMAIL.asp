<%
'-----------------------------------------------------------------------------------------------------
'Function
'-----------------------------------------------------------------------------------------------------
'Function sendMail(toMail,fromMail,subject,message)
'	Dim result				: result = true
'	Dim objCDO
'	Set objCDO = CreateObject("CDO.Message")
'	With objCDO
'		.To							= toMail											'[받는 메일 주소]
'		.From						= fromMail									'[보낼 메일 주소]
'		.Subject				= subject										'[메일 제목]
'		.HTMLBody	= message									'[메일 내용]
'		.Send
'	End With
'	Set objCDO = Nothing
'
'	If Err.Number <> 0 Then	
'		result = false
'	End If 
'	sendMail = result
'End Function

Function sendMail(subject,bcc,admin,email,body)

		Const cdoBasic															= 1 
		Const cdoSendUsingPort									= 2 
		Const cdoSendUsingMethod						= "http://schemas.microsoft.com/cdo/configuration/sendusing"
		Const cdoSMTPServer										= "http://schemas.microsoft.com/cdo/configuration/smtpserver"
		Const cdoSMTPServerPort								= "http://schemas.microsoft.com/cdo/configuration/smtpserverport"
		Const cdoSMTPConnectionTimeout		= "http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout"
		Const cdoSMTPAccountName					= "http://schemas.microsoft.com/cdo/configuration/smtpaccountname"
		Const cdoSMTPAuthenticate						= "http://schemas.microsoft.com/cdo/configuration/smtpauthenticate"
		Const cdoSendUserName								= "http://schemas.microsoft.com/cdo/configuration/sendusername"
		Const cdoSendPassword								= "http://schemas.microsoft.com/cdo/configuration/sendpassword"

		Dim result		: result = true
		Dim iConf
		Dim Flds

		Set iConf = CreateObject("CDO.Configuration")
		iConf.Load 1

		Set Flds = iConf.Fields
		With Flds
			.Item(cdoSendUsingMethod)	= cdoSendUsingPort 
			.Item(cdoSMTPServer)						= "mw-002.cafe24.com"
			.Item(cdoSMTPServerPort)			= 25 
			.Item(cdoSMTPAuthenticate)	= cdoBasic 
			.Item(cdoSendUserName)				= "helper@gju-plant.co.kr"
			.Item(cdoSendPassword)				= "gjdental2875!"
			.Update
		End With

		Set objMail										= Server.CreateObject("CDO.Message")
		objMail.Configuration			= iConf
		objMail.From								= admin							'보내는사람 이메일
		objMail.To										= email								'받는사람 이메일
		objMail.Bcc									= bcc									'숨은 참조 Bcc
		objMail.Subject							= subject						'제목
		objMail.HTMLBody				= body								'내용
		objMail.Send

		Set objMail = Nothing
		Set iConf = Nothing
		Set Fields = Nothing

		If Err.Number <> 0 Then	
			result = false
		End If 

		sendMail = result

End Function

 

'Set Fields = Nothing
'Set objMessage = Nothing
'Set objConfig = Nothing
%>