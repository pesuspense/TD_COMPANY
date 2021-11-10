<!-- #include virtual="/lib/include/adminProcessBundle.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

Dim data
Dim sqlField,sqlTable,sqlSearch,sqlSort
Dim searchPage,searchPageSize,searchPageGroup
Dim searchDevice,searchState,searchKeyword

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer										= "ok"
message										= "완료"

sqlSearch									= "AA.use_yn = 'y'"
searchPage								= getClearstr(request("page"))				: searchPage			= iif(searchPage			= "", "1",		searchPage)
searchPageSize						= getClearstr(request("pageSize"))		: searchPageSize	= iif(searchPageSize	= "", "10",		searchPageSize)
searchPageGroup						= getClearstr(request("pageGroup"))		: searchPageGroup	= iif(searchPageGroup	= "", "10",		searchPageGroup)

searchDevice							= getClearstr(request("view_device"))
searchState								= getClearstr(request("state"))
searchKeyword							=	getClearstr(request("keyword"))

'-----------------------------------------------------------------------------------------------------
'Search
'-----------------------------------------------------------------------------------------------------
sqlSearch = sqlSearch & "And AA.use_yn = 'y'"
If searchKeyword					<> "" Then
	sqlSearch = sqlSearch & "And (																								"
	sqlSearch = sqlSearch & "			AA.name					like '%"& searchKeyword &"%'		"
	sqlSearch = sqlSearch & " or	AA.summary			like '%"& searchKeyword &"%'		"
	sqlSearch = sqlSearch & " or	AA.contents			like '%"& searchKeyword &"%'		"
	sqlSearch = sqlSearch & ")																										"
End If 

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then	

	sqlField				= ""
	sqlField				= sqlField & " AA.*																																					"
	sqlField				= sqlField & ",dbo.getPopupThumbnailImage(AA.popup_no)													thumbnail		"
	sqlField				= sqlField & ",dbo.getPopupState(AA.popup_no)																		stateStr		"

	sqlTable				= ""
	sqlTable				= sqlTable & "						dbo.popup  As AA																									"
	sqlSearch				=	sqlSearch																										
	sqlSort					=	sqlSort & "Order By	AA.order_num desc "					
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
