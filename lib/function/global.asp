<%
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||Common
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Sub echo(str)				: response.write str		: End Sub
Sub echoL(str)			: echo str & vbNewLine	: End Sub
Sub echoO(str)			: echo "<xmp style='padding:0px;font:10pt tahoma'>" & Str & "</xmp>" & vbNewLine : End Sub
Sub exitt(str)			: echo str : Response.End : End Sub
Sub echoR(arr)			: Dim i :For i=0 To UBound(arr) : echoO " Array " & i & " - " & Arr(i) : Next : End Sub
Sub echoR1(arr)			: Dim i,j :For i=0 To UBound(arr, 1) : For j=0 To UBound(arr, 2): echoO " Array("& i &", "& j &")=" & Arr(i, j) : Next :echo vbcrlf: Next : End Sub
Sub echoObj(Obj)		: Dim objItem : For Each objItem In Obj									: echoO objItem & "= Object(" & chr(34) & objItem & chr(34) & "): " & Obj(objItem) : Next : End Sub
Sub echoPost				: Dim objItem : For Each objItem In request.Form				: echoO objItem & "= request.Form(" & chr(34) & objItem & chr(34) & "): " & request.Form(objItem) &vbnewline : Next : End Sub
Sub echoGet					: Dim objItem : For Each objItem In request.QueryString	: echoO objItem & "= request.QueryString(" & chr(34) & objItem & chr(34) & "): " & request.QueryString(objItem) &vbnewline : Next : End Sub
Sub echorequest(Obj): Dim objItem : For Each objItem In Obj									: echoO "Dim "	& objItem & " : " & objItem & " = getRequest(Method, " & chr(34) & objItem & chr(34) & ", """")" : Next : End Sub

Function getRequest(ByVal Method, ByVal Param, ByVal Default)
		Dim Temp : Temp = ""
		If vartype(Method)=9 Then
				Temp = Trim(Method(Param))
		Else
				If uCase(Method) = "GET" Then
						Temp = Trim(Request.QueryString(Param))
				Else
						Temp = Trim(Request.Form(Param))
				End If
		End If
		If bc_IsBlink(Temp) Then Temp = Default
		Call getClearStr(Temp)

		getRequest = Temp
End Function

Function iif(ByVal v0, ByVal v1, ByVal v2)
	Dim result
	If v0 Then result = v1 Else result = v2
	iif = result
End Function 

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||문자열관련
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function getClearStr(values)
	values	= Trim(values)
	values	= Replace(values,"'","")
	values	= Replace(values,"--","")
	IF inStr(Lcase(values),"set ")				<> 0	Then	values	= Replace(Lcase(values),"set ","")
	IF inStr(Lcase(values),"exec ")				<> 0	Then	values	= Replace(Lcase(values),"exec ","")
	IF inStr(Lcase(values),"char(")				<> 0	Then	values	= Replace(Lcase(values),"char(","")
	IF inStr(Lcase(values),"varchar(")		<> 0	Then	values	= Replace(Lcase(values),"varchar(","")
	IF inStr(Lcase(values),"select")			<> 0	Then	values	= Replace(Lcase(values),"select","")
	IF inStr(Lcase(values),"update")			<> 0	Then	values	= Replace(Lcase(values),"update","")
	IF inStr(Lcase(values),"declare")			<> 0	Then	values	= Replace(Lcase(values),"declare","")
	IF inStr(Lcase(values),"sp_help")			<> 0	Then	values	= Replace(Lcase(values),"sp_help","")
	IF inStr(Lcase(values),"sp_tables")		<> 0	Then	values	= Replace(Lcase(values),"sp_tables","")
	IF inStr(Lcase(values),"sp_helptext")	<> 0	Then	values	= Replace(Lcase(values),"sp_helptext","")
	IF values & ""	= ""									Then	values	= ""
	getClearStr			= values
End Function

Function RemoveHTML(strText)

 dim contTmp

	set tagfree			= New Regexp
	tagfree.Pattern	= "<[^>]+>"
	tagfree.Global	=true
	strText=tagfree.Replace(strText,"")

	RemoveHTML= strText

End Function

Function getClearTagStr(str)
	Dim rex
	Set rex = new Regexp
	rex.Pattern		= "<[^>]+>"
	rex.Global		= True
	getClearTagStr	= rex.Replace(str,"")
	
End Function

Function getClearEnter(str)
	Dim result
	result = str
	result = Replace(result&"", Chr(10),"")
	result = Replace(result&"", Chr(13),"")
	getClearEnter = result
End Function


Function getClearUnnecessaryData(str)
	Dim result
	result = Trim(str & "")
	result = Replace(result, "+"							 ,"")
	result = Replace(result, "#"							 ,"")
	result = Replace(result, ")"							 ,"")
	result = Replace(result, ")"							 ,"")
	result = Replace(result, "<"							 ,"")
	result = Replace(result, ">"							 ,"")
	result = Replace(result, Chr(34)					 ,"")			'큰 따옴표
	result = Replace(result, Chr(39)					 ,"")			'작은 따옴표
	result = Trim(result)
	getClearUnnecessaryData = result
End Function

Function getClearUserContent(str)
	Dim result
	result = Trim(str & "")
	'result = Replace(result, "&"							 ,"&amp;")
	result = Replace(result, "<"							 ,"&lt;")
	result = Replace(result, ">"							 ,"&gt;")
	result = Replace(result, Chr(34)					 ,"&#034;")			'큰 따옴표
	result = Replace(result, Chr(39)					 ,"&#039;")			'작은 따옴표
	getClearUserContent = result
End Function

Function getConvertUserContent(str)
	Dim result
	result = Trim(str & "")
	'result = Replace(result, "&amp;"						 ,"&")
	result = Replace(result, "&lt;"							 ,"<")
	result = Replace(result, "&gt;"							 ,">")
	result = Replace(result, "&#034;"						 ,Chr(34))		'큰 따옴표
	result = Replace(result, "&#039;"						 ,Chr(39))		'작은 따옴표
	getConvertUserContent = result
End Function

Function getUrlEscape(url)
	Dim result
	result = Trim(url & "")
	result = Replace(result, "&"							 ,"&amp;")
	result = Replace(result, "<"							 ,"&lt;")
	result = Replace(result, ">"							 ,"&gt;")
	result = Replace(result, Chr(34)					 ,"&#034;")			'큰 따옴표
	result = Replace(result, Chr(39)					 ,"&#039;")			'작은 따옴표
	result = Replace(result, """"							 ,"&#034;")			'큰 따옴표
	result = Replace(result, "'"							 ,"&#039;")			'작은 따옴표
	getUrlEscape = result
End Function


Function getClearHtmlStr(str)
	Dim text
	if not(str = "" or IsNull(str)) then
		text = Replace(str, "&"								 ,"&amp;")
		text = Replace(text, "<"							 ,"&lt;")
		text = Replace(text, ">"							 ,"&gt;")
		text = Replace(text, Chr(34)					 ,"&#034;")			'큰 따옴표
		text = Replace(text, Chr(39)					 ,"&#039;")			'작은 따옴표
		text = Replace(text, Chr(13) & Chr(10) ,"<br>")				'줄바꿈
	end If

	getClearHtmlStr = text
End Function

Function getClearTag(str)
	Dim result
	Set objRegExp = New Regexp

	objRegExp.Pattern= "<[^>]+>"
	objRegExp.Global=true

	result = objRegExp.Replace(str,"")

	getClearTag= result

End Function

Function getConvertStr(types,str)
	If			types = "encode" Then
		str	= Server.HTMLEncode(str)
	ElseIf	types = "decode" then
		str	= Server.HTMLDecode(str)
		str	= Replace(str,chr(13)&chr(10),"<br>")
	Else
		str	= "Err - Parameters "
	End If

	getConvertStr = str
End Function

Function getMatchCount(data, search, isSingle)
	Dim regEx, CurrentMatch, CurrentMatches
	if isSingle then search = "^" & search & "$"
	Set regEx = New RegExp
	regEx.Pattern			= search
	regEx.IgnoreCase	= True
	regEx.Global			= True
	regEx.MultiLine		= True
	 Set	CurrentMatches = regEx.Execute(data)
				CountString = CurrentMatches.Count
	Set regEx					= Nothing    

	Set getMatchCount = Nothing
End Function

Function getRnd(s, e)
	Randomize()

	getRnd = (Int(Rnd * (e-s) ) + s)

End Function

Function getRegExpReplace(Patrn, TrgtStr, RplcStr)

	'"[^가-힣]"							'한글
	'"[^-0-9 ]"							'숫자
	'"[^-a-zA-Z]"						'영어
	'"[^-가-힣a-zA-Z0-9/ ]"	'한글, 영어, 숫자
	'"<[^>]*>"							'태그
	'"[^-a-zA-Z0-9/ ]"			'영어, 숫자

	Dim result
	Dim ObjRegExp
	Set ObjRegExp = New RegExp
	
	ObjRegExp.Pattern			= Patrn            '** 정규 표현식 패턴
	ObjRegExp.Global			= True             '** 문자열 전체를 검색함
	ObjRegExp.IgnoreCase	= True             '** 대.소문자 구분 안함
	
	result = ObjRegExp.Replace(TrgtStr, RplcStr)
	Set ObjRegExp = Nothing

	getRegExpReplace = result
	
End Function


'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||문자열관련
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function getLineContents(data,line)

 Dim i
 Dim arr
 Dim result

 result	= ""
 arr		= Split(data,"<br/>")

 If ubound(arr,1) < line Then
	result = result & data
 Else
	For i = 0 To line
	result = result & arr(i) & iif(i > line+1, "", "<br/>")
	Next	

	result = result & iif(ubound(arr,1) > line+1, "...", "")

 End If 
 
 getLineContents = result

End Function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||숫자관련
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function ceil(ByVal target)		'||소수점 무조건 올림
 ceil = -(Int(-(target)))
End Function

Function getFormatNumber(target)
	Dim result
	result = ""
	target = Trim(target & "")
	If target & "" <> "" Then
		If isNumeric(target) Then
			result = FormatNumber(target,0)	
		End If 
	End If 
	getFormatNumber = result
End Function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||날짜관련
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function getPeriodFrormat(data)

	Dim result
			result = ""

	data = iif(data  & "" = "0", "", data)

	If data & "" <> "" Then

			If data & "" = "" Then
				result = ""
			Else
				If isNumeric(data) Then
					If data = "0" Then
							result = ""
					Else
						If data Mod 12 = 0 Then
							result = (data / 12)	&"년"						
						Else
							result = data					&"개월"						
						End If  
					End If 
				Else
					result = ""
				End if 
			End If 

	End If 

	getPeriodFrormat = result

End Function


'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||HTTP관련
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function getHttp(ByVal url, ByVal param, ByVal header)
	Dim o1, o2, rt
	Set o1 = CreateObject("Msxml2.ServerXMLHTTP.3.0") 
												o1.open									"POST", url, True 
	If header <> "" Then	o1.setRequestHeader 		Split(header,",")(0), Split(header,",")(1)
												o1.send									param
	
	If o1.readyState=1 Then 
		o1.waitForResponse 5
		If o1.readyState=4 And o1.Status=200 Then 
			Set o2 = CreateObject("ADODB.Stream") 
			o2.Open 
			o2.Position = 0 
			o2.Type = 1 
			o2.Write o1.responseBody 
			o2.Position = 0 
			o2.Type = 2 
			o2.Charset = "utf-8" 
			rt = o2.ReadText 
		End If 
	End If 
	getHttp = rt
End Function 

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||파일관련
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Sub file_newObject
	Dim fso
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
End Sub

Sub file_closeObject
	Set fso= nothing
End Sub	

Sub file_delete(filePath)
	Dim fso,files
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	If fso.fileExists(filePath) = true Then
		Set files = fso.GetFile(filePath)
		files.Delete	' 파일을 삭제합니다.
	End If
	Set fso= nothing
End Sub

Function file_copy(saveDir,filename,saveFileName)
	Set fso = CreateObject("Scripting.FileSystemObject")
	if fso.fileExists(saveDir &"\"& filename) Then
		fso.CopyFile saveDir &"\"& filename, saveDir &"\"& saveFileName											'파일복사
	end If
	Set fso = nothing
End Function

Function file_write(filePath, datas)
	On Error Resume Next
	dim fs, filerw
	Set fs = CreateObject("Scripting.FileSystemObject")																		 '파일이 없으면 새로만들고 파일쓰기 속성으로 파일을 읽는다
	Set filerw = fs.OpenTextFile(filePath, 8, true)																				 '기존 내용에 추가
			filerw.writeLine(datas)
			filerw.close()
	set fs = nothing
	if err.number > 0 Then file_write = false Else file_write = True
End Function

Function file_write_new(filePath, datas)
	On Error Resume Next
	dim fs, filerw
	Set fs = CreateObject("Scripting.FileSystemObject")																		 '파일이 없으면 새로만들고 파일쓰기 속성으로 파일을 읽는다
	Set filerw = fs.OpenTextFile(filePath, 2, true)																				 '새로 내용을 추가
			filerw.writeLine(datas)
			filerw.close()
	set fs = nothing
	if err.number > 0 Then file_write = false Else file_write = True
End Function

Function getFileExists(filePath)
	Dim fso,files
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	If fso.fileExists(filePath) = true Then
		getfileExists = true
	Else
		getfileExists = false
	End If
	Set fso= nothing
End Function

Function getReadFile(filePath)
	Dim fso,files
	Set fso=Server.CreateObject("Scripting.FileSystemObject")

	If fso.fileExists(filePath) = true Then
		set files = fso.openTextFile(filePath)
		getReadFile = files.readAll
	Else
		getReadFile = ""
	End If
	Set fso= nothing
End Function

function ReadFromTextFile(FileUrl)
    dim str
    set stm=server.CreateObject("adodb.stream")
    stm.Type			=2 'for text type
    stm.mode			=3 
    stm.charset		="utf-8"
    stm.open
    stm.loadfromfile FileUrl
    str						=stm.readtext
    stm.Close
    set stm=Nothing
    
    ReadFromTextFile=str
end Function

Function getFileDownload(target,fileName)

	Response.Expires = 0
	Response.Buffer = True
	Response.Clear

	Dim fso,stm
	
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	Set stm = Server.CreateObject("ADODB.Stream")

	If fso.FileExists(target) Then
		Response.CacheControl		= "public"
		Response.ContentType		= "application/octet-stream"
		Response.AddHeader "Content-Disposition","attachment;filename=" & fileName
		stm.Open
		stm.Type		= 1
		stm.LoadFromFile target
		Response.BinaryWrite stm.Read
	End If
	Set stm = Nothing
	Set fso = Nothing

End Function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||Upload
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function makeThumbnail(img_path,img_name,thumb_paht,thumb_name,thumb_wsize,thumb_hsize)
     Dim thumb_path, thumb_image, objImage
 
     Set objImage = Server.CreateObject("DEXT.ImageProc")
     If objImage.SetSourceFile(img_path &"\"& img_name) Then
          thumb_path	= img_path &"\"& thumb_paht &"\"& thumb_name
          thumb_image = objImage.SaveasThumbnail(thumb_path, thumb_wsize, thumb_hsize, true)
     End If
 
     makeThumbnail = thumb_image
End Function
 
'Response.Write makeThumbnail(Server.MapPath("/images/"), "dev_logo.gif", "thumbnail", 40, 40)

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||Broswer
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function getDeviceType()

	Dim result : result = "pc"

	If InStr(LCase(request.ServerVariables("HTTP_USER_AGENT")),"mobile") > 0 Then
		result = "mobile"
	End If

	getDeviceType = result

End Function

Function getCheckBroswer()

	Dim result : result = "web"

	If InStr(LCase(request.ServerVariables("HTTP_USER_AGENT")),"mobile") > 0 Then
		result = "mobile"
	End If

	getCheckBroswer = result

End Function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||DB관련 || 내부
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Sub execQuery(query)
	Dim DBHelper
	Set DBHelper	= new clsDBHelper
	Call DBHelper.execSql(query,nothing,nothing)
	DBHelper.Dispose	: Set DBHelper	= Nothing
End Sub

Function getConectionStr()
	Dim result
	Dim DBHelper
	Set DBHelper					= new clsDBHelper
			result						= DBHelper.ReturnConnection()
	DBHelper.Dispose	: Set DBHelper	= Nothing
	getConectionStr = result
End Function

Function getExecQueryReRs(query)
	Dim DBHelper,rs
	Set DBHelper					= new clsDBHelper
	Set rs								= DBHelper.execSqlReturnRs(query,nothing,nothing)
	Set getExecQueryReRs	= rs
	DBHelper.Dispose	: Set DBHelper	= Nothing
End Function

Function getExecQueryReValue(query)
	Dim DBHelper,rs,reData : reData = Null

	Set DBHelper					= new clsDBHelper
	Set rs								= DBHelper.execSqlReturnRs(query,nothing,nothing)
	If Not rs.eof Then reData = rs(0)
	rs.Close					: Set rs				= Nothing
	DBHelper.Dispose	: Set DBHelper	= Nothing

	getExecQueryReValue = reData
End Function

Function getExecQueryReArr(query)
	Dim DBHelper,rs,arrData : arrData = null
	Set DBHelper	= new clsDBHelper

	Set rs				= DBHelper.execSqlReturnRs(query,nothing,nothing)
	If Not rs.eof Then arrData = rs.getRows()
	rs.Close					: Set rs				= Nothing
	DBHelper.Dispose	: Set DBHelper	= Nothing

	getExecQueryReArr = arrData
End Function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||List
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function getListData(field,table,search,sort)
	Dim i,j
	Dim result : result = Null
	Dim DBHelper,cmd,rs

	Set DBHelper	= new clsDBHelper
	Set rs				= server.CreateObject("ADODB.RecordSet")
	Set cmd				= server.CreateObject("ADODB.Command")
			cmd.CommandType											= adCmdStoredProc
			cmd.activeConnection								= DBHelper.ReturnConnection
			cmd.CommandText											= "dbo.getList"
			cmd.Parameters("@field").Value			= field
			cmd.Parameters("@table").Value			= table
			cmd.Parameters("@search").Value			= search
			cmd.Parameters("@sort").Value				= sort
			rs.cursorType												= adOpenKeyset
			rs.lockType													= adLockOptimistic
			rs.cursorLocation										= adUseClient
			rs.Open cmd, , adOpenKeyset, adLockBatchOptimistic
	Set cmd.ActiveConnection = Nothing

	If Not rs.eof Then
		
		i	= 0
		ReDim result(rs.recordCount)		
		Do Until rs.eof 
			Set result(i) = server.CreateObject("scripting.dictionary")
			For j = 0 To rs.fields.count -1
				result(i).add rs.fields(j).name, rs.fields(j) & ""
			Next 
			i = i + 1
			rs.moveNext
		Loop 

	End If 

	rs.Close					: Set rs				= Nothing
											Set cmd				= Nothing
	DBHelper.Dispose	: Set DBHelper	= Nothing

	getListData = result

End Function

Function getPageListData(page,pageSize,pageGroup,field,table,search,sort)
	Dim i,j
	Dim result		: result		= null
	Dim dataList	: dataList	= null
	Dim DBHelper,cmd,rs


	Set DBHelper	= new clsDBHelper
	Set rs				= server.CreateObject("ADODB.RecordSet")
	Set cmd				= server.CreateObject("ADODB.Command")
			cmd.CommandType											= adCmdStoredProc
			cmd.activeConnection								= DBHelper.ReturnConnection
			cmd.CommandText											= "dbo.getPageList"
			cmd.Parameters("@page").Value				= page
			cmd.Parameters("@pageSize").Value		= pageSize
			cmd.Parameters("@pageGroup").Value	= pageGroup
			cmd.Parameters("@field").Value			= field
			cmd.Parameters("@table").Value			= table
			cmd.Parameters("@search").Value			= search
			cmd.Parameters("@sort").Value				= sort
			rs.cursorType												= adOpenKeyset
			rs.lockType													= adLockOptimistic
			rs.cursorLocation										= adUseClient
			rs.Open cmd, , adOpenKeyset, adLockBatchOptimistic
	Set cmd.ActiveConnection = Nothing

	If Not rs.eof Then
		ReDim result(2)		
		Set result(0) = server.CreateObject("scripting.dictionary")
		For j = 0 To rs.fields.count -1
			result(0).add rs.fields(j).name, rs.fields(j) & ""
		Next 
	End If

	Set	rs = rs.nextRecordset
	If Not rs Is Nothing Then
		i = 0
		ReDim	dataList(rs.recordCount)		

		Do Until rs.eof
			Set dataList(i) = server.CreateObject("scripting.dictionary")
			For j = 0 To rs.fields.count -1
				dataList(i).add rs.fields(j).name, rs.fields(j) & ""
			Next
			i = i + 1
			rs.moveNext
		Loop

		result(1) = dataList

	End If 

	rs.Close					: Set rs				= Nothing
											Set cmd				= Nothing
	DBHelper.Dispose	: Set DBHelper	= Nothing

	getPageListData = result

End Function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||Dictionary
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||요청결과 -> Detail
Function getDicDetailData(ByVal sql, ByRef data)
	Dim i
	Dim rs

	Set rs				= getExecQueryReRs(sql)

	If rs.eof Then
		data   = Null
	Else
		Set data	= server.CreateObject("scripting.dictionary")	

		For i = 0 To rs.fields.count - 1
			data.Add rs.fields(i).name, rs(i) & ""		': response.write rs.fields(i).name &" | "& data(rs.fields(i).name) &"<br/>"
		Next	
	End If 

	rs.close()		: Set rs = Nothing

End Function

'||요청결과 -> List
Function getDicListData(ByVal sql, ByRef objData)
	Dim i,j
	Dim DBHelper,rs

	Set DBHelper	= new clsDBHelper
	Set rs	= server.CreateObject("ADODB.RecordSet")
			rs.cursorType												= adOpenKeyset
			rs.lockType													= adLockOptimistic
			rs.cursorLocation										= adUseClient
			rs.Open sql, DBHelper.ReturnConnection , adOpenKeyset, adLockBatchOptimistic

	If rs.eof Then
		objData   = Null
	Else
		i	= 0
		Set objData	= server.CreateObject("scripting.dictionary")	
		ReDim objData(rs.recordCount)		

		Do Until rs.eof
			Set objData(i) = server.CreateObject("scripting.dictionary")
			For j = 0 To rs.fields.count -1
				objData(i).add rs.fields(j).name, rs.fields(j) & ""
			Next
			i = i + 1
			rs.moveNext
		Loop
	End If 

	rs.close()				: Set rs = Nothing
	DBHelper.Dispose	: Set DBHelper	= Nothing

End Function

'||요청결과 -> XML List
Function getXmlSummaryData(ByRef objData)
	Dim i,key
	Dim strXml

	strXml	 = ""
	If Not IsNull(objData) Then
		strXml = strXml &"<summary>"
		For Each key In objData
			strXml = strXml &"<"& key &">"& escape(objData(key) &" ") &"</"& key &">"
		Next

		strXml = strXml &"</summary>"
	End If

	Set objData			= Nothing
	getXmlSummaryData	= strXml

End Function

'||요청결과 -> XML List
Function getXmlListData(ByRef objData)
	Dim i,key
	Dim strXml

	strXml	 = ""
	If Not IsNull(objData) Then
					strXml = strXml &"<data>"
		For i = 0 To UBound(objData,1) -1
					strXml = strXml &"<list>"
				For Each key In objData(i)
					strXml = strXml &"<"& key &">"& escape(objData(i)(key) &" ") &"</"& key &">"
				Next
					strXml = strXml &"</list>"
		Next
					strXml = strXml &"</data>"
	End If

	Set objData			= Nothing
	getXmlListData	= strXml

End Function

'||요청결과 -> XML Detail
Function getXmlDetailData(ByRef objData)
	Dim key
	Dim strXml

	strXml	 = ""
	If Not IsNull(objData) Then
			strXml = strXml &"<data>"
		For Each key In objData
			strXml = strXml &"<"& key &">"& escape(objData(key) &" ") &"</"& key &">"
		Next
			strXml = strXml &"</data>"
	End If

	Set objData			= Nothing
	getXmlDetailData	= strXml

End Function

'||요청결과 -> HTML TABLE
Function getExcelListHtml(ByRef objData, ByVal title, ByVal field, ByVal value, ByVal style)
	Dim i,j
	Dim Key
	Dim reTitle,reList,result
	Dim arrTitle,arrField,arrValue,arrStyle

	reTitle		= ""
	reList		= ""
	result		= ""
	arrTitle	= Split(title,",")
	arrField	= Split(field,",")
	arrValue	= Split(value,",")
	arrStyle	= Split(style,",")

	If Not isNull(objData) Then
		For j = 0 To ubound(arrTitle,1)
			reTitle = reTitle & "<td>"& arrTitle(j) &"</td>"
		Next

		For i = 0 To UBound(objData,1) -1
			reList = reList & "<tr style='border-bottom:1px solid #cccccc;'>"
			For j = 0 To ubound(arrField,1)
				If arrField(j) <> "" Then
					If arrValue(j) & "" = "" Then
						reList = reList & "<td style="& arrStyle(j) &">"& getDicItem(objData(i), arrField(j))	 &"</td>"
					Else 
						reList = reList & "<td style="& arrStyle(j) &">"& arrValue(j)													 &"</td>"
					End If 
				End If 
			Next
			reList = reList & "</tr>"
		Next
	End If 

	If reList <> "" Then
		result = ""
		result = result & "<table style=>"
		result = result & "	<tr style='border-bottom:1px solid #bbbbbb;'>"
		result = result & reTitle
		result = result & "	</tr>"
		result = result & reList
		result = result & "</table>"
	End If 

	getExcelListHtml = result

End Function

Function getDicItem(ByRef objDic,ByVal key)
	Dim result		: result = ""
	Dim itemKey

	For each itemKey In objDic
		If itemKey = key Then
			result = objDic.item(itemKey)
			Exit For
		End If		
	Next

	getDicItem = result

End Function

Function setDicItem(ByRef objDic,ByVal key, ByVal val)
	Dim itemKey
	For each itemKey In objDic
		If itemKey = key Then
			objDic.item(itemKey) = val
			Exit For
		End If		
	Next
End Function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||Family Site
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function getFamilySiteList()
	Dim i
	Dim rs
	Dim sql 
	Dim result
	result = ""
	sql = ""
	sql = sql & "Select																																														" &vbCrlf
	sql = sql & " replace(dbo.split(replace(name,' ','@'), '@', 1),'정수기렌탈','') +	company + '정수기'		name			" &vbCrlf
	sql = sql & ",domain																																								domain		" &vbCrlf
	sql = sql & "From site_default																																								" &vbCrlf
	sql = sql & "Where type			= '지역'																																						" &vbCrlf
	sql = sql & "And		division	= '렌탈킹'																																				" &vbCrlf
	sql = sql & "And		state			= '1000000036'																																	" &vbCrlf
	sql = sql & "And		company		<> '"& dicSite.item("company") &"'																							" &vbCrlf
	sql = sql & "And		charindex('area-guide', domain) = 0																												" &vbCrlf
	sql = sql & "And		comArea		= '"& dicSite.item("comArea") &"'																								" &vbCrlf

	Set rs = getExecQueryReRs(sql)
	If Not rs.eof Then
		Do Until rs.eof
			result = result & "<li><a href='"& rs("domain") &"'>"&  rs("name") &"</a></li>"
			rs.movenext
		Loop
	End If 
	If result & "" <> "" Then
		result = "<dl><dt>Family Site</dt><dd><ul>"& result &"</ul></dd></dl>"
	End If 
	getFamilySiteList = result
End Function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||SMS
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function getContentsByte(contents)

	Dim n, charAt,charLen
	For n=1 To len(contents)
		charAt = mid(contents, n, 1)
		If asc(charAt)> 0 And asc(charAt)< 255 Then 
			charLen=charLen+1
		Else
			charLen=charLen+2
		End If
	Next

	getContentsByte = charLen

End Function

Function sendServiceSms(division, destPhone, destName, contents)

	Dim i
	Dim arr
	Dim data
	Dim smsType,smsMsg
	Dim sendPhone,sendName

	Set data = Server.CreateObject("Scripting.Dictionary")

	Select Case division
	Case "렌탈"		: smsMsg = "{:고객명}님<br>{:사이트명} 입니다.<br>렌탈신청이 접수되었습니다.↔담당자 확인 후 전화드리겠습니다.<br>{:도메인}<br>감사합니다."
	Case "상담"		: smsMsg = "{:고객명}님<br>{:사이트명} 입니다.<br>상담신청이 접수되었습니다.↔담당자 확인 후 전화드리겠습니다.<br>{:도메인}<br>감사합니다."
	Case "견적"		: smsMsg = "{:고객명}님<br>{:사이트명} 입니다.<br>견적신청이 접수되었습니다.↔담당자 확인 후 전화드리겠습니다.<br>{:도메인}<br>감사합니다."
	Case "사은품"	: smsMsg = "{:고객명}님<br>{:사이트명} 입니다.<br>사은품신청이 접수되었습니다.↔담당자 확인 후 전화드리겠습니다.<br>{:도메인}<br>감사합니다."
	End Select

	Call getSiteData(data)

	arr					= Split(smsMsg,"↔")
	sendPhone		= data.item("문자번호")
	sendName		= "관리자"

	For i = 0 To ubound(arr,1)
		If Trim(arr(i)&"") <> "" Then
			arr(i)		= Replace(arr(i), "{:고객명}",		destName)
			arr(i)		= Replace(arr(i), "{:도메인}",		data.item("도메인"))
			arr(i)		= Replace(arr(i), "{:사이트명}", data.item("사이트명"))
			arr(i)		= Replace(arr(i), "<br>",				vbCrlf)
			smsType		= iif(getContentsByte(arr(i)) > 80, "mms", "")
			Call execQuery("Exec [BIZCLIENT].[dbo].[sendSMS] '"& destPhone &"', '"& destName &"', '"& sendPhone &"', '"& sendName &"', '"& arr(i) &"', '"& smsType &"'")
		End If 
	Next
	Set data = Nothing 

	smsMsg = ""
	smsMsg = smsMsg & "주인님!"																&vbCrlf
	smsMsg = smsMsg & division & "신청이 접수되었습니다."				&vbCrlf
	smsMsg = smsMsg & "고객성명: " & destName										&vbCrlf
	smsMsg = smsMsg & "전화번호: " & destPhone									&vbCrlf
	smsMsg = smsMsg & "상세내용: "															&vbCrlf
	smsMsg = smsMsg & contents										
	Call execQuery("Exec [BIZCLIENT].[dbo].[sendSMS] '"& sendPhone &"', '"& sendName &"', '"& sendPhone &"', '"& sendName &"', '"& smsMsg &"', 'mms'")

End Function

Function sendContentsSms(contentsType)

	Dim data
	Dim smsMsg
	Dim sendPhone,sendName

	Set data = Server.CreateObject("Scripting.Dictionary")

	Call getSiteData(data)
	sendPhone		= data.item("문자번호")
	sendName		= "관리자"

	Set data		= Nothing 

	smsMsg = ""
	smsMsg = smsMsg & "주인님!"																&vbCrlf
	smsMsg = smsMsg & contentsType & " 등록 되었습니다."				&vbCrlf
	smsMsg = smsMsg & "확인부탁드립니다."												&vbCrlf
	Call execQuery("Exec [BIZCLIENT].[dbo].[sendSMS] '"& sendPhone &"', '"& sendName &"', '"& sendPhone &"', '"& sendName &"', '"& smsMsg &"', 'sms'")

End Function

Function getSmsErrorMessage(code)

	Dim result

	Select Case code
	Case "00" : result = "정상(전송완료)"
	Case "10" : result = "잘못된 번호"
	Case "11" : result = "상위 서비스망 스팸 인식됨"
	Case "12" : result = "상위 서버 오류"
	Case "13" : result = "잘못된 필드값"
	Case "20" : result = "등록된 계정이 아니거나 패스워드가 틀림"
	Case "21" : result = "존재하지 않는 메시지 ID"
	Case "30" : result = "가능한 전송 잔량이 없음"
	Case "31" : result = "전송할 수 없음"
	Case "32" : result = "가입자 없음"
	Case "40" : result = "전송시간 초과"
	Case "41" : result = "단말기 busy"
	Case "42" : result = "음영지역"
	Case "43" : result = "단말기 Power off"
	Case "44" : result = "단말기 메시지 저장갯수 초과"
	Case "45" : result = "단말기 일시 서비스 정지"
	Case "46" : result = "기타 단말기 문제"
	Case "47" : result = "착신거절"
	Case "48" : result = "Unkown error"
	Case "49" : result = "Format Error"
	Case "50" : result = "SMS서비스 불가 단말기"
	Case "51" : result = "착신측의 호불가 상태"
	Case "52" : result = "이통사 서버 운영자 삭제"
	Case "53" : result = "서버 메시지 Que Full"
	Case "54" : result = "SPAM"
	Case "55" : result = "SPAM, nospam.or.kr 에 등록된 번호"
	Case "56" : result = "전송실패(무선망단)"
	Case "57" : result = "전송실패(무선망->단말기단)"
	Case "58" : result = "전송경로 없음"
	Case "60" : result = "예약취소"
	Case "70" : result = "허가되지 않은 IP주소"
	Case "81" : result = "게이트웨이 연결 실패"
	Case "82" : result = "이미지 미입력"
	Case "83" : result = "수신번호 미입력"
	Case "84" : result = "발신번호 미입력"
	Case "85" : result = "메시지 내용 미입력"
	Case "86" : result = "미지원 이미지 타입"
	Case "99" : result = "전송대기"
	End Select

	getSmsErrorMessage = result

End Function


'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||Session & Cookie
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function setApplication(key,val)
	application(key)			= getClearUnnecessaryData(val)
End Function

Function getApplication(key)
	getApplication				= getClearUnnecessaryData(application(key))
End Function

Function setSession(key,val)
	session(key)					= getClearUnnecessaryData(val)
End Function

Function getSession(key)
	getSession						= getClearUnnecessaryData(session(key))
End Function

Function setCookie(key,val)
	response.cookies(key)						= getClearUnnecessaryData(val)
	response.cookies(key).expires 	= DateAdd("m", 12, Now())
End Function

Function getCookie(key)
	getCookie							=	getClearUnnecessaryData(request.cookies(key))
End Function


'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||Broswer
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function getBroswerType()

	Dim result : result = "web"

	If InStr(LCase(request.ServerVariables("HTTP_USER_AGENT")),"mobile") > 0 Then
		result = "mobile"
	End If

	getBroswerType = result

End Function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||로그관련
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function parameterWrite()
	On Error Resume Next
	dim fs, filerw, filePath, fileName, datas
	datas = datas & "[ "
	datas = datas & "IP:"							&	request.serverVariables("REMOTE_ADDR")
	datas = datas & "| PATH_INFO:"		&	request.serverVariables("PATH_INFO")
	datas = datas & "| DATE:"					&	now
	datas = datas & "] "							& vbCrlf
	datas = datas & "@HTTP_REFERER: "	&	request.serverVariables("HTTP_REFERER") &vbCrlf
	datas = datas & "@URL: http://"		& SITE_DOMAIN & getRequestURL()						&vbCrlf
	datas = datas & "@PARAMETER:"			& vbCrlf 
	datas = datas											& getRequestList()			

	fileName	= Replace(request.serverVariables("PATH_INFO"),".asp","_"&Replace(Left(now,10),"-","")&".txt")
	fileName	= Replace(fileName,"/","_")

	filePath	= server.mapPath("/lib/log/" &fileName)

	Set fs = CreateObject("Scripting.FileSystemObject")
	Set filerw = fs.OpenTextFile(filePath, 8, true)
			filerw.writeLine(datas)
			filerw.close()
	set fs = Nothing

End Function

'||파라메터 가져오기
Function getRequestList()			
	Dim result
	Dim objItem 

	result = ""

	For Each objItem In request.form
		result = result  & "post: " &objItem &"="& chr(34) & request(objItem) & chr(34)  &vbCrlf
	Next

	For Each objItem In request.querystring
		result = result  & "get: "  &objItem &"="& chr(34) & request(objItem) & chr(34)  &vbCrlf
	Next

	If result & ""  = "" Then result = "(No Data)"

	getRequestList = result

End Function

'||요청주소 가져오기
Function getRequestURL()
	Dim i
	Dim result
	Dim objItem 

	i			 = 0
	result = ""

	For Each objItem In request.Form
		If i = 0 Then
			result = result  &"?"& objItem  &"="& request(objItem)
			i = i + 1
		Else
			result = result  &"&"& objItem  &"="& request(objItem)
			i = i + 1
		End If

	Next

	For Each objItem In request.querystring
		If i = 0 Then
			result = result  &"?"& objItem  &"="& request(objItem)
			i = i + 1
		Else
			result = result  &"&"& objItem  &"="& request(objItem)
			i = i + 1
		End If		
	Next

	getRequestURL = request.serverVariables("URL") & result

End Function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||에러관련
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'||파일저장
Function errorWrite(contents)
	dim fs, filerw, filePath, data
	If Err.Number <> 0 Then	
		data = data & " [ "
		data = data & "eIpaddress:"		&	request.serverVariables("REMOTE_ADDR")
		data = data & "| eSession:"		&	session.sessionID
		data = data & "| file:"				&	request.serverVariables("PATH_INFO")
		data = data & "| num:"				&	Err.number
		data = data & "| eSource:"		&	Err.source 
		data = data & "| eDate:"			&	now
		data = data & " ] "
		data = data & " "							& Err.description
	Else
		data = ""
	End If 

	
	filePath	= server.mapPath("/log/error_report"& Replace(Left(now,10),"-","") &".txt")
	Set fs = CreateObject("Scripting.FileSystemObject")
	Set filerw = fs.OpenTextFile(filePath, 8, true)
			filerw.writeLine(data & vbCrlf &contents)
			filerw.close()
	set fs = Nothing

	Err.Clear
End Function


%>