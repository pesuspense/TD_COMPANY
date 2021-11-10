<!-- #include virtual="/lib/include/adminIframeBundle.asp" -->
<!-- #include virtual="/lib/include/adminIframeHeader.asp" -->
	<script src="/js/global/nfupload.js"></script>
	<script src="/js/admin/contents/upload.js"></script>
	<script src="/js/admin/contents/default.js"></script>
	<script src="/js/admin/contents/list_contents.js"></script>
	<script src="/js/admin/contents/list_images.js"></script>
	<script src="/js/admin/contents/detail_contents.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/admin/contents/default.css"/>
</head>
<body>
	<div class="wrap">

		<form name="theForm" id="theForm" method="post" action="">
			<!-- Hidden Form Start -->
			<input type="hidden" id="hidFileName"			name="hidFileName"			value="" />
			<!-- Hidden Form	 End -->
		</form>


		<div class="preview">
			<div class="title_main">&nbsp;</div>
			<div id="preview_contents"	class="scroll_x" style="height:770px;border:0;margin:0px 0 0 0;border-bottom:0px solid #cccccc;"></div>
		</div>

		<div class="detail">
			<div class="title_main">&nbsp;</div>

			<ul>
				<li><a class="contentsTap on" href="javascript:setTap('contents');"	>컨텐츠</a></li>
				<li><a class="imagesTap"			href="javascript:setTap('images');"		>이미지</a></li>
			</ul>

			<div class="contents">
				<table>
					<tr><td><input type="text"	id="form_division"	onfocus="checkUpdateContents();" onblur="checkUpdateContents();" style="ime-mode:active;" class="title"			placeholder="구분"		/></td></tr>
					<tr><td><input type="text"	id="form_title"			onfocus="checkUpdateContents();" onblur="checkUpdateContents();" style="ime-mode:active;" class="title"			placeholder="제목"		/></td></tr>
					<tr><td><textarea						id="form_contents"	onfocus="checkUpdateContents();" onblur="checkUpdateContents();" style="ime-mode:active;" class="contents"	placeholder="내용"		></textarea></td></tr>
					<tr><td><textarea						id="form_keyword"		onfocus="checkUpdateContents();" onblur="checkUpdateContents();" style="ime-mode:active;" class="keyword"		placeholder="키워드" ></textarea></td></tr>
					<tr>
						<td>
							<div id="list_images_form" class="scroll_x" style="height:230px;border:0;margin:5px 0 0 0;"></div>
						</td>
					</tr>
				</table>
			</div>

			<div class="images">
				<!--
				<div id="list_images_og"				class="scroll_x" style="margin-top:0;border:0;height:190px;"></div>
				-->
				<div id="list_images_list"			class="scroll_x" style="margin-top:5px;border:0;height:285px;"></div>
				<div id="list_images_detail"		class="scroll_x" style="margin-top:5px;border:0;height:285px;"></div>
				<div style="height:115px;padding:7px 0 0 0;border-top:1px solid black;">
					<script>setUploadForm();</script>
				</div>
				<div style="height:40px;padding:5px 0 0 0;border-top:1px solid black;">
					<!--
					<input type="button" id="button_reg_og"					class="button" value="OG 이미지 등록"			onclick="checkInsertImages('og');"				/>
					-->
					<input type="button" id="button_reg_thumbnail"	class="button" value="섬네일 이미지 등록" onclick="checkInsertImages('list');"				/>
					<input type="button" id="button_reg_detail"			class="button" value="디테일 이미지 등록" onclick="checkInsertImages('detail');"			/>
				</div>
			</div>

		</div>

		<div class="list">
			<div class="title_main">컨텐츠 목록</div>
			<div class="list_header">
				<table>
					<tr>
						<td class="item1">&nbsp;</td>
						<td class="item2">No</td>
						<td class="item3">타입</td>
						<td class="item4">제목</td>
						<td class="item5">뷰</td>
						<td class="item6">상태</td>
						<td class="item7">Date</td>
					</tr>
				</table>
			</div>

			<div class="list_body" style="height:700px;">
				<div id="list_contents_mask" class="mask" style="width:600px;height:700px;"></div>
 				<div id="list_contents" class="scroll_x"></div>
			</div>

			<div class="list_page">
				<div id="page_contents" style="position:absolute;padding:10px 0 0 0;"></div>
				<div id="top_button" style="float:right;margin:7px 0 0 0;display:none;">
					<input type="button" class="button" value="Top On"			id="button_onTop"			onclick="setTop('on');"/>
					<input type="button" class="button" value="Top Off"			id="button_offTop"		onclick="setTop('off');"/>
				</div>
			</div>

			<div class="list_function">
				<div style="float:left;width:40%;">
					<input type="button" class="button" value="컨텐츠게시"		id="button_publish"			onclick="publish();"		style="display:none;"/>
					<input type="button" class="button" value="컨텐츠게시취소"id="button_unPublish"		onclick="unPublish();"	style="display:none;"/>
					<input type="button" class="button" value="선택삭제"																onclick="deleteContents();"/>
				</div>
				<div style="float:right;width:60%;text-align:right;">
					<select id="search_type" onchange="search('search_type',this.value);window.focus();">
						<!--<option value="">전체</option>-->
						<option value="news">라이마소식</option>
						<option value="reference">자료실</option>
					</select>
					<input type="search" class="search" value=""							id="search_keyword" onkeydown="if(event.keyCode == 13){search('search_keyword',this.value);};"/>
					<input type="button" class="button" value="초기화"					onclick="clearSearchForm();"/>
					<input type="button" class="button" value="새글등록"				onclick="insertContents();"/>
				</div>
			</div>

		</div>

	</div>
</body>
</html>
