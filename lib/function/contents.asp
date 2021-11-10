<%
Function getParam(target)

	Dim i
	Dim arr
	Dim result
	result	= ""
	arr			= Split(Replace(request.serverVariables("QUERY_STRING"),"?",""), "&")
	For i = 0 To ubound(arr,1)
		If InStr(arr(i), target) > 0 Then
			If InStr(arr(i),"=") > 0 Then
				result = Trim(Split(arr(i),"=")(1) & "")
			End If 
		End If 
	Next
	getParam = result
End Function

Function getContentsListData(ByVal target)

	'------------------------------------------------------------------
	'||Define
	'------------------------------------------------------------------
	Dim i
	Dim data
	Dim sqlField,sqlTable,sqlSearch,sqlSort
	Dim searchPage,searchPageSize,searchPageGroup
	Dim searchKeyword

	'------------------------------------------------------------------
	'||Request
	'------------------------------------------------------------------
	sqlSearch										= ""
	searchPage									= getParam("page")				: searchPage			= iif(searchPage			= "", "1",		searchPage)
	searchPageSize							= getParam("pageSize")		: searchPageSize	= iif(searchPageSize	= "", "15",		searchPageSize)
	searchPageGroup							= getParam("PageGroup")		: searchPageGroup	= iif(searchPageGroup	= "", "10",		searchPageGroup)
	searchKeyword								=	unescape(getParam("keyword")&"")

	'------------------------------------------------------------------
	'||Search
	'------------------------------------------------------------------
	sqlSearch = sqlSearch & "			AA.state	= '게시' "
	sqlSearch = sqlSearch & "And	AA.type		= '"& target &"' "

	If searchKeyword					<> "" Then
		sqlSearch = sqlSearch & "And (																								"
		sqlSearch = sqlSearch & "			AA.title				like '%"& searchKeyword &"%'		"
		sqlSearch = sqlSearch & " or	AA.keyword			like '%"& searchKeyword &"%'		"
		sqlSearch = sqlSearch & " or	AA.contentsNum	in(															"
		sqlSearch = sqlSearch & "			Select																					"
		sqlSearch = sqlSearch & "			contentsNum																			"
		sqlSearch = sqlSearch & "			From contents_detail														"
		sqlSearch = sqlSearch & "			Where contents like '%"& searchKeyword &"%'			"
		sqlSearch = sqlSearch & "			)																								"
		sqlSearch = sqlSearch & ")																										"
	End If 

	'------------------------------------------------------------------
	'||Process
	'------------------------------------------------------------------
	sqlField				= ""
	sqlField				= sqlField & " AA.*																																			"
	sqlField				= sqlField & ",BB.contents																								detail				"
	sqlField				= sqlField & ",dbo.getContentsThumbnailImages(AA.contentsNum)							thumbnail			"
	sqlField				= sqlField & ",''																													url						"
	sqlTable				= ""
	sqlTable				= sqlTable & "						contents_default  As AA																				"
	sqlTable				= sqlTable & "Inner Join	contents_detail		As BB On	AA.contentsNum = BB.contentsNum		"
	sqlTable				= sqlTable & "																		And BB.type				 = 'default'				"

	sqlSearch				=	sqlSearch																										
	sqlSort					=	sqlSort & "Order By	AA.idx desc"					
	data						= getPageListData(searchPage,searchPageSize,searchPageGroup,sqlField,sqlTable,sqlSearch,sqlSort)

	data(0).Add "searchPage",			searchPage
	data(0).Add "searchPageSize",	searchPageSize
	data(0).Add "searchKeyword",	searchKeyword


	getContentsListData = data

End Function

Function getContentsList(ByVal target, ByRef dicResult)

	'------------------------------------------------------------------
	'||Define
	'------------------------------------------------------------------
	Dim i
	Dim dicRequest
	Dim listNo,listType,listDivision,listThumbnail,listTitle,listDetail,listHit,listDate,listUrl,param
	Dim recordCount,pageCount,pageStart,pageEnd,pageFirst,pageLast,pageBefore,pageAfter,numStart,numEnd
	Dim searchPage,searchPageSize,searchKeyword

	'------------------------------------------------------------------
	'||Request
	'------------------------------------------------------------------
	dicRequest			= getContentsListData(target)
	recordCount			= dicRequest(0).item("recordCount")
	pageCount				= dicRequest(0).item("pageCount")
	pageStart				= dicRequest(0).item("pageStart")
	pageEnd					= dicRequest(0).item("pageEnd")
	pageFirst				= dicRequest(0).item("pageFirst")
	pageLast				= dicRequest(0).item("pageLast")
	pageBefore			= dicRequest(0).item("pageBefore")
	pageAfter				= dicRequest(0).item("pageAfter")
	numStart				= dicRequest(0).item("numStart")
	numEnd					= dicRequest(0).item("numEnd")
	searchPage			= dicRequest(0).item("searchPage")
	searchPageSize	= dicRequest(0).item("searchPageSize")
	searchKeyword		= dicRequest(0).item("searchKeyword")

	param						= request.serverVariables("URL")
	param						= param & "?page=@page"
	param						= param & iif(searchKeyword		= "",  "", iif(instr(param, "?page") = 0, "?keyword=", "&keyword="	) & escape(searchKeyword)	)

	'------------------------------------------------------------------
	'||Page
	'------------------------------------------------------------------
	dicResult.item("page")	= dicResult.item("page") & iif(pageFirst	="", "", "<li><a href='"& Replace(param,"@page", pageFirst)		&"'>&lt;&lt;</a></li>")
	dicResult.item("page")	= dicResult.item("page") & iif(pageBefore	="", "", "<li><a href='"& Replace(param,"@page", pageBefore)	&"'>&lt;</a></li>")

	For i = pageStart To pageEnd
		If i = (searchPage * 1) Then
			dicResult.item("page")	= dicResult.item("page") &												 "<li><a class='on' href='"& Replace(param,"@page", i)						&"'>"& i &"</a></li>"	
		Else
			dicResult.item("page")	= dicResult.item("page") &												 "<li><a						href='"& Replace(param,"@page", i)						&"'>"& i &"</a></li>"	
		End If 
	Next

	dicResult.item("page")	= dicResult.item("page") & iif(pageAfter	="", "", "<li><a href='"& Replace(param,"@page", pageAfter)		&"'>&gt;</a></li>")
	dicResult.item("page")	= dicResult.item("page") & iif(pageLast		="", "", "<li><a href='"& Replace(param,"@page", pageLast)		&"'>&gt;&gt;</a></li>")

	'------------------------------------------------------------------
	'||List
	'------------------------------------------------------------------
	param				= ""
	param				= param & iif(searchPage		= "1", "", iif(param = "", "?page=",		"&page="		) & searchPage		)
	param				= param & iif(searchKeyword = "",  "", iif(param = "", "?keyword=",	"&keyword="	) & searchKeyword	)

	For i = 0 To ubound(dicRequest(1),1) -1

		listNo					= recordCount - (((searchPage - 1) * searchPageSize) + i)
		listIdx					= dicRequest(1)(i).item("idx")
		listType				= dicRequest(1)(i).item("type")
		listDivision		= dicRequest(1)(i).item("division")
		listThumbnail		= dicRequest(1)(i).item("thumbnail")
		listTitle				= dicRequest(1)(i).item("title")
		listDetail			= dicRequest(1)(i).item("detail")			: listDetail	= RemoveHTML(listDetail)
		listHit					= dicRequest(1)(i).item("hit")
		listDate				= dicRequest(1)(i).item("regdate")		: listDate		= Replace(Left(listDate,10),"-",".")
		listUrl					= ""

		Select Case listType
		Case "news"
			listUrl = "/customer/news/detail.asp" & param & iif(param = "", "?idx=", "&idx=") & listIdx 
			dicResult.item("list") = dicResult.item("list") & "<li>"
			dicResult.item("list") = dicResult.item("list") & "	<article>"

			If listDivision <> "" Then
			dicResult.item("list") = dicResult.item("list") & "		<div class='block tag'><span>"& listDivision &"</span></div>"
			End If 

			dicResult.item("list") = dicResult.item("list") & "		<div class='thumbnail'><img src='"& listThumbnail &"' alt='"& listTitle &"'></div>"
			dicResult.item("list") = dicResult.item("list") & "		<div class='text title'><a href='"& listUrl &"'>"& listTitle &"</a></div>"
			dicResult.item("list") = dicResult.item("list") & "		<div class='text description'><p>"& listDetail &"</p></div>"
			dicResult.item("list") = dicResult.item("list") & "		<div class='text date'>"& listDate &"</div>"
			dicResult.item("list") = dicResult.item("list") & "	</article>"
			dicResult.item("list") = dicResult.item("list") & "</li>"
		Case "reference"
			listUrl = "/customer/reference/detail.asp" & param & iif(param = "", "?idx=", "&idx=") & listIdx 
			dicResult.item("list") = dicResult.item("list") & "<li>"
			dicResult.item("list") = dicResult.item("list") & "	<article>"

			If listDivision <> "" Then
			dicResult.item("list") = dicResult.item("list") & "		<div class='block tag'><span>"& listDivision &"</span></div>"
			End If 

			dicResult.item("list") = dicResult.item("list") & "		<div class='thumbnail'><img src='"& listThumbnail &"' alt='"& listTitle &"'></div>"
			dicResult.item("list") = dicResult.item("list") & "		<div class='text title'><a href='"& listUrl &"'>"& listTitle &"</a></div>"
			dicResult.item("list") = dicResult.item("list") & "		<div class='text description'><p>"& listDetail &"</p></div>"
			dicResult.item("list") = dicResult.item("list") & "		<div class='text date'>"& listDate &"</div>"
			dicResult.item("list") = dicResult.item("list") & "	</article>"
			dicResult.item("list") = dicResult.item("list") & "</li>"
		End Select
		
	Next

	If dicResult.item("list") = "" Then
		If searchKeyword = "" Then
			dicResult.item("list") = "<tr><td style='height:100px;'>등록된 컨텐츠가 없습니다.</td></tr>"
		Else
			dicResult.item("list") = "<tr><td style='height:100px;'>검색된 컨텐츠가 없습니다.</td></tr>"
		End If 
	End If 

	If dicResult.item("page")	= "" Then
		dicResult.item("page")	= "<li><a style='border:0;'>&nbsp;</a><li>"
	End If 

	dicResult.item("page")					= Replace(dicResult.item("page"),"'","""")
	dicResult.item("list")					= Replace(dicResult.item("list"),"'","""")
	dicResult.item("searchKeyword")	= searchKeyword

End Function

Function getContentsDetailData()

	Dim sql
	Dim data

	sql = ""
	sql	= sql & "Select																																		" &vbCrlf
	sql	= sql & "Top 1																																		" &vbCrlf
	sql	= sql & " AA.*																																		" &vbCrlf
	sql	= sql & ",BB.contents																								contents			" &vbCrlf
	sql	= sql & ",dbo.getContentsThumbnailImages(AA.contentsNum)						thumbnail			" &vbCrlf
	sql	= sql & "From				contents_default	As AA																				" &vbCrlf
	sql	= sql & "Inner Join	contents_detail		As BB On	AA.contentsNum = BB.contentsNum		" &vbCrlf
	sql	= sql & "																		And	BB.type = 'default'								" &vbCrlf
	sql	= sql & "Where AA.state = '게시'																										" &vbCrlf
	sql	= sql & "And		AA.idx	 = '"& getParam("idx") &"'																" &vbCrlf
	'Response.write Replace(sql,Chr(10),"<br>")
	Call getDicDetailData(sql, data)
	Call execQuery("Update contents_default Set hit = hit +1 Where idx = '"& getParam("idx") &"'")
	
	If isNull(data) Then
		Set getContentsDetailData = Server.CreateObject("Scripting.Dictionary")
	Else
		Set getContentsDetailData = data
	End If 

End Function

Function getContentsDetail(ByRef dicResult)

	Dim i
	Dim rs
	Dim arr
	Dim keyword
	Dim dicRequest

	Set dicRequest = getContentsDetailData()

	arr			= Split(dicRequest.item("keyword") & ",", ",")
	keyword = ""
	For i = 0 To ubound(arr,1)
		If Trim(arr(i) & "") <> "" Then
			keyword = keyword &iif(arr(i) = "", "", "#" &Trim(arr(i) & "&nbsp;&nbsp;"))
		End If 
	Next


	dicResult.Add "thumbnail",	dicRequest.item("thumbnail")
	dicResult.Add "title",			dicRequest.item("title")
	dicResult.Add "article",		""
	dicResult.Add "detail",			Replace(dicRequest.item("contents"),Chr(10),"<br/>")
	dicResult.Add "keyword",		dicRequest.item("keyword")
	dicResult.Add "name",				dicRequest.item("authorName")
	dicResult.Add "hit",				dicRequest.item("hit")
	dicResult.Add "date",				Left(dicRequest.item("regdate"),10)
	dicResult.Add "bIdx",				""
	dicResult.Add "aIdx",				""

	sql = ""
	sql = sql & ""
	sql = sql & "Select																													 " &vbCrlf
	sql = sql & " max(Case When goType = 'b' Then goIdx Else null End) bIdx			 " &vbCrlf
	sql = sql & ",max(Case When goType = 'a' Then goIdx Else null End) aIdx			 " &vbCrlf
	sql = sql & "From(																													 " &vbCrlf
	sql = sql & "	Select 																												 " &vbCrlf
	sql = sql & "	Top 1 																												 " &vbCrlf
	sql = sql & "	 'b'				goType																						 " &vbCrlf
	sql = sql & "	,idx				goIdx																							 " &vbCrlf
	sql = sql & "	From contents_default																					 " &vbCrlf
	sql = sql & "	Where state = '게시'																						 " &vbCrlf
	sql = sql & "	And		type  = '"& dicRequest.item("type") &"'									 " &vbCrlf
	sql = sql & "	And		idx < '"& getParam("idx") &"'														 " &vbCrlf
	sql = sql & "	Order by idx desc																							 " &vbCrlf
	sql = sql & "	Union All																											 " &vbCrlf
	sql = sql & "	Select 																												 " &vbCrlf
	sql = sql & "	Top 1 																												 " &vbCrlf
	sql = sql & "	'a'					goType																						 " &vbCrlf
	sql = sql & "	,idx				goIdx																							 " &vbCrlf
	sql = sql & "	From contents_default																					 " &vbCrlf
	sql = sql & "	Where state = '게시'																						 " &vbCrlf
	sql = sql & "	And		type  = '"& dicRequest.item("type") &"'									 " &vbCrlf
	sql = sql & "	And		idx > '"& getParam("idx") &"'														 " &vbCrlf
	sql = sql & "	Order by idx asc																							 " &vbCrlf
	sql = sql & ")TB																														 " &vbCrlf
	Set rs = getExecQueryReRs(sql)
	If Not rs.eof Then
		dicResult.item("bIdx") = rs(0)
		dicResult.item("aIdx") = rs(1)
	End If 
	rs.close() : Set rs = Nothing	



	Select Case dicRequest.item("type")
	Case "news"
	Case "reference"
	End Select

End Function
%>