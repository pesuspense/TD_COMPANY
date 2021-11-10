<!-- #include virtual="/lib/include/adminProcessBundle.asp"	-->
<%
'On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

Dim data
Dim sqlField,sqlTable,sqlSearch,sqlSort
Dim searchPage,searchPageSize,searchPageGroup,searchState,searchKeyword

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer										= "ok"
message										= "완료"

sqlSearch									= "isNull(AA.state ,'') <> 'd'"
searchPage								= getClearstr(request("page"))				: searchPage			= iif(searchPage			= "", "1",		searchPage)
searchPageSize						= getClearstr(request("pageSize"))		: searchPageSize	= iif(searchPageSize	= "", "25",		searchPageSize)
searchPageGroup						= getClearstr(request("pageGroup"))		: searchPageGroup	= iif(searchPageGroup	= "", "10",		searchPageGroup)
searchState								= getClearstr(request("state"))
searchKeyword							=	getClearstr(request("keyword"))

'-----------------------------------------------------------------------------------------------------
'Search
'-----------------------------------------------------------------------------------------------------
If searchState						<> "" Then sqlSearch = sqlSearch & "And charindex(AA.state,'"					& searchState				&"') > 0 "

If searchKeyword					<> "" Then
	sqlSearch = sqlSearch & "And (																								"
	sqlSearch = sqlSearch & "			AA.name					like '%"& searchKeyword &"%'		"
	sqlSearch = sqlSearch & " or	AA.phone				like '%"& searchKeyword &"%'		"
	sqlSearch = sqlSearch & " or	AA.email				like '%"& searchKeyword &"%'		"
	sqlSearch = sqlSearch & " or	AA.address			like '%"& searchKeyword &"%'		"
	sqlSearch = sqlSearch & " or	AA.reqContents	like '%"& searchKeyword &"%'		"
	sqlSearch = sqlSearch & " or	AA.resContents	like '%"& searchKeyword &"%'		"
	sqlSearch = sqlSearch & ")																										"
End If 

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then	

	sqlField				= ""
	sqlField				= sqlField & " idx,inquiryNum,type,division,name,phone,email,address,state,regdate												"
	sqlTable				= ""
	sqlTable				= sqlTable & "inquiry_default											As AA																										"
	sqlSearch				=	sqlSearch																										
	
	sqlSort					= ""
	sqlSort					=	sqlSort & "Order By Case	When AA.state = '대기' Then 0																									"
	sqlSort					=	sqlSort & "								When AA.state = '진행' Then 1																									"
	sqlSort					=	sqlSort & "								When AA.state = '완료' Then 2																									"
	sqlSort					=	sqlSort & "					End, AA.idx desc																																		"

	data						= getPageListData(searchPage,searchPageSize,searchPageGroup,sqlField,sqlTable,sqlSearch,sqlSort)

	If Err.Number <> 0 Then	
		answer	= "error"
		message	= "데이터베이스 처리 에러!"
		Call errorWrite("exec getPageList '"& searchPage &"', '"& searchPageSize &"', '"& searchPageGroup &"', '"& Replace(sqlField,"'","''") &"', '"& Replace(sqlTable,"'","''") &"', '"& Replace(sqlSearch,"'","''") &"', '"& Replace(sqlSort,"'","''") &"'")
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
If Not IsNull(data(0)) Then
response.write						getXmlSummaryData(data(0))
End If 

If Not IsNull(data(1)) Then
response.write						getXmlListData(data(1))
End If 
response.Write						"</result>"

'-----------------------------------------------------------------------------------------------------
%>
