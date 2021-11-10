<!-- #include virtual="/lib/include/adminProcessBundle.asp"	-->
<%
On Error Resume Next
'-----------------------------------------------------------------------------------------------------
'Config
'-----------------------------------------------------------------------------------------------------
Dim answer,message

Dim data
Dim sqlField,sqlTable,sqlSearch,sqlSort
Dim search_keyword

Dim target

'-----------------------------------------------------------------------------------------------------
'Request
'-----------------------------------------------------------------------------------------------------
answer						= "ok"
message						= "완료"
search_keyword		= getClearstr(request("keyword"))
target						= getClearstr(request("target"))

sqlField					= "*"
sqlField					= sqlField & ",dbo.getPageItemParentTitle(pageNumParent) parentTitle"
sqlTable					= "page_item TB"
sqlSearch					= "state is Null"
sqlSort						= "order by step asc"

'-----------------------------------------------------------------------------------------------------
'Search
'-----------------------------------------------------------------------------------------------------

'-----------------------------------------------------------------------------------------------------
'Process
'-----------------------------------------------------------------------------------------------------
If answer = "ok" Then

	data = getListData(sqlField,sqlTable,sqlSearch,sqlSort)

	If Err.Number <> 0 Then	
		answer	= "error"
		message	= "데이터베이스 처리 에러!"
		Call errorWrite("exec getList '"& Replace(sqlField,"'","''") &"', '"& Replace(sqlTable,"'","''") &"', '"& Replace(sqlSearch,"'","''") &"', '"& Replace(sqlSort,"'","''") &"'")
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
If Not IsNull(data) Then
response.write						getXmlListData(data)
End If 
response.Write						"</result>"

'-----------------------------------------------------------------------------------------------------
%>
