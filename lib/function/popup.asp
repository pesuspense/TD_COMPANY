<%

Function getPopup()
	Dim i
	Dim rs,sql
	Dim result
	Dim itemStyle,bodyStyle,imageStyle

	Dim popup_no,name,view_depth,view_device,pc_size,pc_position,mo_size,mo_position,exposed_time,order_num,thumbnail
	Dim pc_size_width,pc_size_height,pc_position_top,pc_position_left,mo_size_width,mo_size_height,mo_position_top,mo_position_left
	Dim size_widht,size_height,position_top,position_left

	i				= 1
	sql			= ""
	result	= ""

	sql = ""
	sql = sql & "Select																											" &vbCrlf
	sql = sql & " popup_no															popup_no						" &vbCrlf
	sql = sql & ",name																	name								" &vbCrlf
	sql = sql & ",view_depth														view_depth					" &vbCrlf
	sql = sql & ",view_device														view_device					" &vbCrlf
	sql = sql & ",pc_size																pc_size							" &vbCrlf
	sql = sql & ",pc_position														pc_position					" &vbCrlf
	sql = sql & ",mo_size																mo_size							" &vbCrlf
	sql = sql & ",mo_position														mo_position					" &vbCrlf
	sql = sql & ",exposed_time													exposed_time				" &vbCrlf
	sql = sql & ",order_num															order_num						" &vbCrlf
	sql = sql & ",dbo.getPopupThumbnailImage(popup_no)	thumbnail						" &vbCrlf
	sql = sql & "From dbo.popup																							" &vbCrlf
	sql = sql & "Where	dbo.getPopupState(popup_no) = '노출중'									" &vbCrlf
	sql = sql & "And		use_yn						= 'y'															" &vbCrlf
	sql = sql & "Order By order_num desc																		" &vbCrlf
	Set rs = getExecQueryReRs(sql)
	
	If Not rs.eof Then
		Do Until rs.eof 
			popup_no						= rs("popup_no") 			&""
			name								= rs("name") 					&""
			view_depth					= rs("view_depth") 		&""
			view_device					= rs("view_device")		&""
			pc_size							= rs("pc_size")				&""
			pc_position					= rs("pc_position")		&""
			mo_size							= rs("mo_size")				&""
			mo_position					= rs("mo_position")		&""
			exposed_time				= rs("exposed_time")  &""
			order_num						= rs("order_num")			&""
			thumbnail						= rs("thumbnail")			&""	
	
			pc_size_width				= split(pc_size				&"*", "*")(0)	&""
			pc_size_height			= split(pc_size				&"*", "*")(1)	&""
			pc_position_top			= split(pc_position		&"*", "*")(0)	&""
			pc_position_left		= split(pc_position		&"*", "*")(1)	&""
			mo_size_width				= split(mo_size				&"*", "*")(0)	&""
			mo_size_height			= split(mo_size				&"*", "*")(1)	&""
			mo_position_top			= split(mo_position		&"*", "*")(0)	&""
			mo_position_left		= split(mo_position		&"*", "*")(1)	&""

			pc_size_width				= iif(pc_size_width			 = "", "", pc_size_width		&"px")
			pc_size_height			= iif(pc_size_height		 = "", "", pc_size_height		&"px")
			pc_position_top			= iif(pc_position_top		 = "", "", pc_position_top	&"px")
			pc_position_left		= iif(pc_position_left	 = "", "", pc_position_left	&"px")
			mo_size_width				= iif(mo_size_width			 = "", "", mo_size_width		&"px")
			mo_size_height			= iif(mo_size_height		 = "", "", mo_size_height		&"px")
			mo_position_top			= iif(mo_position_top		 = "", "", mo_position_top	&"px")
			mo_position_left		= iif(mo_position_left	 = "", "", mo_position_left	&"px")

			size_widht					= iif(getDeviceType() = "pc", pc_size_width,		mo_size_width)
			size_height					= iif(getDeviceType() = "pc", pc_size_height,		mo_size_height)
			position_top				=	iif(getDeviceType() = "pc", pc_position_top,	mo_position_top)		
			position_left				= iif(getDeviceType() = "pc", pc_position_left, mo_position_left) 

			size_widht					= iif(size_widht		= "", "", "width:"				&size_widht				&";")
			size_height					= iif(size_height		= "", "", "height:"				&size_height			&";line-height:"& size_height &";")
			position_top				=	iif(position_top	= "", "", "top:"					&position_top			&";")
			position_left				= iif(position_left	= "", "", "left:"					&position_left		&";")

			If getDeviceType() = "pc" Then
				itemStyle						= "display:none;"
				itemStyle						= itemStyle & "z-index:"& 1000 + i &";"
				itemStyle						= itemStyle & position_top
				itemStyle						= itemStyle & position_left

				bodyStyle						= "overflow:hidden;background:white;text-align:center;"
				bodyStyle						= bodyStyle & size_widht
				bodyStyle						= bodyStyle & size_height

				imageStyle					= "vertical-align:middle;"
			Else
				itemStyle						= "display:none;"
				itemStyle						= itemStyle & "z-index:"& 1000 + i &";max-width:90vw;"
				itemStyle						= itemStyle & position_top
				itemStyle						= itemStyle & position_left

				bodyStyle						= "overflow:hidden;background:white;text-align:center;"
				bodyStyle						= bodyStyle & size_widht
				bodyStyle						= bodyStyle & size_height

				imageStyle					= "vertical-align:middle;width:100%;"
			End If 

			result = result & "<div class='item' id='popup_"& popup_no &"' style='"& itemStyle &"'>"
			result = result & "	<input id='exposed_time' type='hidden' value='"& exposed_time &"'>"
			result = result & "	<input id='view_device' type='hidden' value='"& view_device &"'>"
			result = result & "	<div class='top'></div>"
			result = result & "	<div class='body' style='"& bodyStyle &"'><img src='"& thumbnail &"' alt='"& name &"' style='"& imageStyle &"'></div>"
			result = result & "	<div class='bottom'><span class='left'><a class='closeToday' href='#'>오늘은 그만보기</a></span><span class='right'><a class='close' href='#'>창닫기</a></span></div>"
			result = result & "</div>"

			i = i - 1
			rs.moveNext()
			

		Loop

	End If 
	rs.close() : Set rs = Nothing
	getPopup = result
End Function

%>