<!-- #include virtual="/lib/include/adminIframeBundle.asp" -->
<!-- #include virtual="/lib/include/adminIframeHeader.asp" -->
	<script src="/js/admin/page/default.js"></script>
	<script src="/js/admin/page/list_pageItem.js"></script>
	<script src="/js/admin/page/detail_pageMeta.js"></script>
	<script src="/js/admin/page/list_file.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/admin/page/default.css"/>
</head>
<body>
	<div class="wrap">

		<form name="theForm" id="theForm" method="post" action="">
			<!-- Hidden Form Start -->
			<input type="hidden" id="hidFileName"			name="hidFileName"			value="" />
			<!-- Hidden Form	 End -->
		</form>


		<div class="form_default">
			<div class="title_main">상세</div>

			<div class="form_group" style="height:200px;">
				<div class="title_left"><br/>메타정보</div>
				<div class="scroll_x">
					<table class="form_table">
						<tr>
							<td class="form_item_title">고유번호</td>
							<td class="form_item_contents">
								<span id="view_pageNum" class="view">&nbsp;</span>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">Title</td>
							<td class="form_item_contents">
								<input type="text" id="form_meta_title"							value=""	onfocus="checkUpdatePageMeta();" onblur="checkUpdatePageMeta();" onkeydown="checkUpdatePageMeta();"	style="ime-mode:active;" placeholder=""/>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">Description</td>
							<td class="form_item_contents">
								<textarea id="form_meta_description"													onfocus="checkUpdatePageMeta();" onblur="checkUpdatePageMeta();" onkeydown="checkUpdatePageMeta();"	style="ime-mode:active;" placeholder=""></textarea>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">Keyword</td>
							<td class="form_item_contents">
								<textarea id="form_meta_keyword"															onfocus="checkUpdatePageMeta();" onblur="checkUpdatePageMeta();" onkeydown="checkUpdatePageMeta();"	style="ime-mode:active;" placeholder=""></textarea>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="form_group" style="height:553px;">
				<div class="title_left"><br/>이미지</div>
				<div id="list_images" class="scroll_x" style="height:553px;">
				</div>
			</div>

			<div style="display:none;margin:-145px 0 0 20px;padding:10px;width:580px;height:145px;border:1px solid black;">
				<!--
				<script>setUploadForm();</script>
				-->
			</div>

			<div style="padding:7px 0 0 0;text-align:right;">
				<!--
				<input type="button"	id="button_new"				class="button"	value="오픈 그래프 이미지 등록"			onclick="checkInsertImages();"	style="background:blue;border:blue;"		/>
				-->
				<div class="filebox"> 
					<input type="file" id="file" accept=".jpg"> 
					<input class="upload-name" value="이미지경로" readonly>
					<label for="file">이미지 선택</label> 
				</div>
			</div>


		</div>

		<div class="list_pageItem">
			<div class="title_main">목록</div>
			
			<div class="list_header">
				<table>
					<tr>
						<td class="list_item_1">&nbsp;</td>
						<td class="list_item_2">No</td>
						<td class="list_item_3">고유번호</td>
						<td class="list_item_4">네비게이션</td>
						<td class="list_item_5">디렉토리</td>
						<td class="list_item_6">기능</td>
					</tr>
				</table>
			</div>

			<div class="list_body" style="height:730px;">
				<div id="list_pageItem_mask" class="mask" style="width:780px;height:730px;"></div>
				<div id="list_pageItem" class="scroll_x"></div>
			</div>
				
			<div class="list_function">
				<div class="ltItem">
				</div>
				<div class="rtItem">
					<input type="button"	id="button_new"				class="button"	value="신규 경로 등록"				onclick="insertPageItem();"	style="background:blue;border:blue;"		/>
					<input type="button"	id="button_del"				class="button"	value="선택 경로 삭제"				onclick="deletePageItem();"	style="background:black;border:black;"	/>
				</div>
			</div>

			</div>

		</div>

	</div>
</body>
</html>
