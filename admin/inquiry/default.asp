<!-- #include virtual="/lib/include/adminIframeBundle.asp" -->
<!-- #include virtual="/lib/include/adminIframeHeader.asp" -->
	<script src="/js/admin/inquiry/default.js"></script>
	<script src="/js/admin/inquiry/list_inquiryDefault.js"></script>
	<script src="/js/admin/inquiry/detail_inquiryDefault.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/admin/inquiry/default.css"/>
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

			<div class="form_group" style="height:723px;">
				<div class="title_left"><br/>문의정보</div>
				<div class="scroll_x">
					<table class="form_table">
						<tr>
							<td class="form_item_title">고유번호</td>
							<td class="form_item_contents">
								<span id="view_inquiryNum" class="view">&nbsp;</span>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">문의구분</td>
							<td class="form_item_contents">
								<span id="view_type" class="view">&nbsp;</span>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">고객성명</td>
							<td class="form_item_contents">
								<span id="view_name" class="view">&nbsp;</span>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">전화번호</td>
							<td class="form_item_contents">
								<span id="view_phone" class="view">&nbsp;</span>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">이메일</td>
							<td class="form_item_contents">
								<span id="view_email" class="view">&nbsp;</span>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">문의제목</td>
							<td class="form_item_contents">
								<span id="view_title" class="view">&nbsp;</span>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">문의날짜</td>
							<td class="form_item_contents">
								<span id="view_regdate" class="view">&nbsp;</span>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">문의상태</td>
							<td class="form_item_contents">
								<span id="view_state" class="view">&nbsp;</span>
								<ul id="form_state"></ul>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">문의내용</td>
							<td class="form_item_contents">
								<textarea id="form_inquiry_reqContents"		onfocus="checkUpdateInquiryDefault();" onblur="checkUpdateInquiryDefault();" onkeydown="checkUpdateInquiryDefault();"	style="ime-mode:active;" placeholder="" disabled></textarea>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">처리내용</td>
							<td class="form_item_contents">
								<textarea id="form_inquiry_resContents"		onfocus="checkUpdateInquiryDefault();" onblur="checkUpdateInquiryDefault();" onkeydown="checkUpdateInquiryDefault();"	style="ime-mode:active;" placeholder=""></textarea>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div style="padding:7px 0 0 0;text-align:right;">

			</div>


		</div>

		<div class="list_inquiryDefault">
			<div class="title_main">목록</div>
			
			<div class="list_header">
				<table>
					<tr>
						<td class="list_item_1">&nbsp;</td>
						<td class="list_item_2">No</td>
						<td class="list_item_3">문의구분</td>
						<td class="list_item_4">성명</td>
						<td class="list_item_5">전화번호</td>
						<td class="list_item_6">이메일</td>
						<td class="list_item_7">등록일시</td>
						<td class="list_item_8">상태</td>
					</tr>
				</table>
			</div>

			<div class="list_body" style="height:701px;">
				<div id="list_inquiryDefault_mask" class="mask" style="width:780px;height:701px;"></div>
				<div id="list_inquiryDefault" class="scroll_x"></div>
			</div>
				
			<div class="list_function">
				<div class="ltItem">
					<div class="search_pageing">
						<div id="page_inquiryDefault"></div>
					</div>
				</div>
				<div class="rtItem">
					<div class="search_form">
						<input type="text"		id="search_keyword"		class="input"		value=""								onkeydown="if(event.keyCode == 13){search();}" placeholder="검색어"/>
						<input type="button"	id="button_search"		class="button"	value="검색"							onclick="search();"/>
						<input type="button"	id="button_clear"			class="button"	value="초기화"						onclick="clearSearchForm();" />
						<input type="button"	id="button_delete"		class="button"	value="선택삭제"					onclick="deleteInquiryDefault();" />
					</div>
				</div>
			</div>

			</div>

		</div>

	</div>
</body>
</html>
