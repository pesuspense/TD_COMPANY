<%
'-------------------------------------------------------------------------------------------------------------------------------------------
'||Meta
'-------------------------------------------------------------------------------------------------------------------------------------------
Function getMetaData(ByRef data)
	
	Dim rs,sql
	Dim dTitle,dDescription,dKeyword,dImages			
	Dim tTitle,tDescription,tKeyword,tImages			

	sql = ""
	sql = sql & "Select																																			" &vbCrlf
	sql = sql & " max(Case When type = 'd' Then title				Else null End) dTitle						" &vbCrlf
	sql = sql & ",max(Case When type = 'd' Then description	Else null End) dDescription			" &vbCrlf
	sql = sql & ",max(Case When type = 'd' Then keyword			Else null End) dKeyword					" &vbCrlf
	sql = sql & ",max(Case When type = 'd' Then images			Else null End) dImages					" &vbCrlf
	sql = sql & ",max(Case When type = 't' Then title				Else null End) tTitle						" &vbCrlf
	sql = sql & ",max(Case When type = 't' Then description	Else null End) tDescription			" &vbCrlf
	sql = sql & ",max(Case When type = 't' Then keyword			Else null End) tKeyword					" &vbCrlf
	sql = sql & ",max(Case When type = 't' Then images			Else null End) tImages					" &vbCrlf
	sql = sql & "From(																																			" &vbCrlf
	sql = sql & "	Select																																		" &vbCrlf
	sql = sql & "	 'd'																type																	" &vbCrlf
	sql = sql & "	,BB.title														title																	" &vbCrlf
	sql = sql & "	,BB.description											description														" &vbCrlf
	sql = sql & "	,BB.keyword													keyword																" &vbCrlf
	sql = sql & "	,dbo.getMetaImages(BB.pageNum)			images																" &vbCrlf
	sql = sql & "	From				page_item As AA																								" &vbCrlf
	sql = sql & "	Inner Join	page_meta As BB On AA.pageNum = BB.pageNum										" &vbCrlf
	sql = sql & "	Where		AA.state is Null																									" &vbCrlf
	sql = sql & "	And			AA.title = '홈'																										" &vbCrlf
	sql = sql & "	Union All																																	" &vbCrlf
	sql = sql & "	Select																																		" &vbCrlf
	sql = sql & "	 't'																type																	" &vbCrlf
	sql = sql & "	,BB.title														title																	" &vbCrlf
	sql = sql & "	,BB.description											description														" &vbCrlf
	sql = sql & "	,BB.keyword													keyword																" &vbCrlf
	sql = sql & "	,dbo.getMetaImages(BB.pageNum)			images																" &vbCrlf
	sql = sql & "	From				page_item As AA																								" &vbCrlf
	sql = sql & "	Inner Join	page_meta As BB On AA.pageNum = BB.pageNum										" &vbCrlf
	sql = sql & "	Where		AA.state is Null																									" &vbCrlf
	sql = sql & "	And			isNull(AA.location,'') <> ''																			" &vbCrlf
	sql = sql & "	And			CHARINDEX(AA.location,'"& request.serverVariables("URL") &"') > 0	" &vbCrlf
	sql = sql & ")TB																																				" &vbCrlf

	Set rs = getExecQueryReRs(sql)
	If Not rs.eof Then
		dTitle										= ""& rs("dTitle")
		dDescription							= ""& rs("dDescription")
		dKeyword									= ""& rs("dKeyword")
		dImages										= ""& rs("dImages")
		tTitle										= ""& rs("tTitle")
		tDescription							= ""& rs("tDescription")
		tKeyword									= ""& rs("tKeyword")
		tImages										= ""& rs("tImages")

		dDescription							=	getClearTagStr(dDescription)
		dDescription							=	replace(dDescription, Chr(10), "")
		dDescription							=	replace(dDescription, Chr(13), "")

		tDescription							=	getClearTagStr(tDescription)
		tDescription							=	replace(tDescription, Chr(10), "")
		tDescription							=	replace(tDescription, Chr(13), "")


		data.item("title")				=	iif(tTitle				= "", dTitle,				tTitle)  
		data.item("keyword")			=	iif(tKeyword			= "", dKeyword,			tKeyword)	
		data.item("description")	=	iif(tDescription	= "", dDescription, tDescription)	
		data.item("images")				=	iif(tImages				= "", dImages,			tImages)	
		data.item("movie")				=	""	
		data.item("author")				=	""	
		data.item("robots")				=	""	
	End If 
	rs.close() : Set rs = Nothing

	
'	If InStr("/customer/news/detail.asp,/customer/reference/detail.asp,",request.serverVariables("PATH_INFO") &",") Then
'		data.item("title")				=	iif(dicContents("title")				= "", dTitle,				dicContents("title"))  
'		data.item("keyword")			=	iif(dicContents("keyword")			= "", dKeyword,			dicContents("keyword"))	
'		data.item("description")	=	iif(dicContents("detail")				= "", dDescription, getClearTagStr(dicContents("detail")))	
'		data.item("images")				=	iif(dicContents("thumbnail")		= "", dImages,			dicContents("thumbnail"))	
'		data.item("movie")				=	""	
'		data.item("author")				=	""	
'		data.item("robots")				=	""	
'	End If 

End Function 

Function getMetaTag()

	Dim result
	Dim site
	Dim title,description,keyword,author,robots,copyright
	Dim ogType,ogTitle,ogDescription,ogUrl,ogImages
	Dim twType,twTitle,twDescription,twDomain,twImages

	Dim dicMeta 
	Set dicMeta = Server.CreateObject("Scripting.Dictionary")
	dicMeta.Add "title",						""
	dicMeta.Add "keyword",					""
	dicMeta.Add "description",			""
	dicMeta.Add "images",						""
	dicMeta.Add "movie",						""
	dicMeta.Add "author",						""
	dicMeta.Add "robots",						""
	dicMeta.Add "copyright",				""
	Call getMetaData(dicMeta)


	site						= "옥길아라동물의료센터"
	title						= dicMeta.item("title")				
	keyword					= dicMeta.item("keyword")			
	description			= dicMeta.item("description")	
	images					= dicMeta.item("images")			
	movie						= dicMeta.item("movie")				
	author					= dicMeta.item("author")			
	robots					= dicMeta.item("robots")			
	copyright				= ""

	ogType					= "website"
	ogTitle					= title
	ogDescription		=	description
	ogImages				= images

	twCard					= "summary"
	twTitle					= title
	twDescription		= description
	twDomain				= ""
	twImages				= images

	if title					<> "" Then result = result & "<title>"																				 & title									&"</title>"																					&vbCrlf																					
	if description		<> "" Then result = result & "	<meta name='description'"					&" content='"& description						&"'>"																								&vbCrlf																					
	if keyword				<> "" Then result = result & "	<meta name='keywords'"						&" content='"& keyword								&"'>"																								&vbCrlf																					
	if author					<> "" Then result = result & "	<meta name='author'"							&" content='"& author									&"'>"																								&vbCrlf																													
	if robots					<> "" Then result = result & "	<meta name='robots'"							&" content='"& robots									&"'>"																								&vbCrlf																													
	if copyright			<> "" Then result = result & "	<meta name='copyright'"						&" content='"& copyright							&"'>"																								&vbCrlf																													
	if copyright			<> "" Then result = result & "	<meta name='googlebot'"						&" content='index,follow' >"																															&vbCrlf																									
	if ogType					<> "" Then result = result & "	<meta property='og:type'"					&" content='"& ogType									&"'>"																								&vbCrlf																					
	if ogTitle				<> "" Then result = result & "	<meta property='og:title'"				&" content='"& ogTitle								&"'>"																								&vbCrlf																					
	if ogImages				<> "" Then result = result & "	<meta property='og:image'"				&" content='"& ogImages								&"'>"																								&vbCrlf																					
	if site						<> "" Then result = result & "	<meta property='og:site_name'"		&" content='"& site										&"'>"																								&vbCrlf																					
	if ogDescription	<> "" Then result = result & "	<meta property='og:description'"	&" content='"& ogDescription					&"'>"																								&vbCrlf																					
	if twCard					<> "" Then result = result & "	<meta name='twitter:card'"				&" content='"& twCard									&"'>"																								&vbCrlf																															
	if twTitle				<> "" Then result = result & "	<meta name='twitter:title'"				&" content='"& twTitle								&"'>"																								&vbCrlf																					
	if twDescription	<> "" Then result = result & "	<meta name='twitter:description'"	&" content='"& twDescription					&"'>"																								&vbCrlf																					
	if twDomain				<> "" Then result = result & "	<meta name='twitter:domain'"			&" content='"& twDomain								&"'>"																								&vbCrlf																					
	if twImages				<> "" Then result = result & "	<meta name='twitter:image'"				&" content='"& twImages							  &"'>"																								&vbCrlf																					

	getMetaTag = Replace(result,"'","""")

End Function
%>