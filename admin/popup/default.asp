<!-- #include virtual="/lib/include/adminIframeBundle.asp" -->
<!-- #include virtual="/lib/include/adminIframeHeader.asp" -->
	<script src="/js/admin/popup/default.js"></script>
	<script src="/js/admin/popup/list_popup.js"></script>
	<script src="/js/admin/popup/detail_popup.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/admin/popup/default.css"/>
</head>
<body>

	<div id="bg_popup"></div>
	<div id="default_popup">
		<dl>
			<dt>신규 팝업 등록</dt>
			<dd>
				<table>
					<tr>
						<td colspan="2" class="preview"><img id="prviewImg" src=""></td>
					</tr>
					<tr class="point">
						<td class="field_name essential">팝업 제목</td>
						<td class="field_item">
							<div class="select_form">
								<input id="default_popup_name" type="text" value="" maxlength="50" style="ime-mode:active;" >
							</div>
						</td>
					</tr>
					<tr>
						<td class="field_name essential">팝업 이미지</td>
						<td class="field_item">
							<div class="select_form">

								<div class="default_popup_filebox"> 
									<input type="file" id="default_popup_file" accept="image/*"> 
									<input class="default_popup_upload-name" value="이미지경로" readonly>
									<label for="default_popup_file">이미지 선택</label> 
								</div>
				
							</div>
						</td>
					</tr>
					<tr>
						<td class="field_name essential">시간</td>
						<td class="field_item">
							<div class="select_form">
								<input id="default_popup_exposed_time" type="text" value="24" maxlength="3" style="ime-mode:disabled;">
							</div>
						</td>
					</tr>

					<tr>
						<td class="field_name essential">시작날짜</td>
						<td class="field_item">
							<div class="select_form">
								<input id="default_popup_start_date" type="text" value="" maxlength="20" style="ime-mode:active;" readonly onclick="Calendar(this,event);">
							</div>
						</td>
					</tr>

					<tr>
						<td class="field_name essential">종료날짜</td>
						<td class="field_item">
							<div class="select_form">
								<input id="default_popup_end_date" type="text" value="" maxlength="20" style="ime-mode:active;" readonly onclick="Calendar(this,event);">
							</div>
						</td>
					</tr>
					<tr>
						<td class="function" colspan="2">
							<input type="button" id="process" class="process_btn" value="팝업 등록">
							<input type="button" id="cancel"	class="cancel_btn"  value="등록 취소">
						</td>
					</tr>

				</table>
			<dd>
		</dl>
	</div>

	<div class="wrap">

		<div class="view_default">
			<div class="title_main">미리보기</div>					
			<div class="view_body">
				<div class="preview">
				</div>
			</div>
		</div>

		<div class="form_default">
			<div class="title_main">상세</div>

			<div class="form_group" style="height:128px;">
				<div class="title_left"><br/>기본정보</div>
				<div class="scroll_x">
					<table class="form_table">
						<tr>
							<td class="form_item_title">고유번호</td>
							<td class="form_item_contents"><span id="view_popup_no" class="view">&nbsp;</span></td>
						</tr>
						<tr>
							<td class="form_item_title">팝업제목</td>
							<td class="form_item_contents point"><input type="text" id="form_name" value="" class="formItem" style="ime-mode:active;" placeholder=""/></td>
						</tr>
						<tr>
							<td class="form_item_title">팝업설명</td>
							<td class="form_item_contents"><textarea id="form_summary" style="ime-mode:active;" class="formItem" placeholder=""></textarea></td>
						</tr>
						<tr>
							<td class="form_item_title">노출영역</td>
							<td class="form_item_contents device">
								<select id="form_view_device" class="formItem"></select>
								<div class="guide"><span class="text">노출될 영역을 설정 (*선택 안하면 노출 아됨)</span></div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="form_group" style="height:76px;">
				<div class="title_left"><br/>기간</div>
				<div class="scroll_x">
					<table class="form_table">
						<tr>
							<td class="form_item_title">시간</td>
							<td class="form_item_contents time">
								<input type="text" id="form_time" value="" class="formItem number" style="ime-mode:active;" placeholder="">
								<div class="guide"><span class="text">다시 보지 않음을 선택시 몇 시간동안 보여주지 않을지 설정</span></div>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">시작</td>
							<td class="form_item_contents start_date">
								<input type="text" id="form_start_date" value="" class="formItem calendar" style="ime-mode:active;" placeholder="" afterevent="blur"  onclick="Calendar(this,event);" readonly>
								<div class="guide" style="display:none;"><span class="text"><input id="check_default_start_date" type="checkbox"> <label for="check_default_start_date">시작일시를 오늘로</label></span></div>
							</td>
						</tr>
						<tr>
							<td class="form_item_title">종료</td>
							<td class="form_item_contents end_date">
								<input type="text" id="form_end_date" value="" class="formItem calendar" style="ime-mode:active;" placeholder="" afterevent="blur" onclick="Calendar(this,event);" readonly>
								<div class="guide" style="display:none;"><span class="text"><input id="check_default_end_date" type="checkbox"> <label for="check_default_end_date">종료일시를 오늘로부터 7일 후로</label></span></div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="form_group" style="height:63px;">
				<div class="title_left"><br/>P<br>C</div>
				<div class="scroll_x">
					<table class="form_table">
						<tr>
							<td class="form_item_title">위치</td>
							<td class="form_item_contents position">
								<span class="form_field_name">상단</span><input type="text" id="form_pc_top" value="" class="formItem number" style="ime-mode:disabled;" placeholder="" maxlength="5"> px
								<span class="form_field_name">좌측</span><input type="text" id="form_pc_left" value="" class="formItem number" style="ime-mode:disabled;" placeholder="" maxlength="5"> px
							</td>
						</tr>
						<tr>
							<td class="form_item_title">크기</td>
							<td class="form_item_contents size">
								<span class="form_field_name">넓이</span><input type="text" id="form_pc_width" value=""  class="formItem number" style="ime-mode:disabled;" placeholder="" maxlength="5"> px
								<span class="form_field_name">높이</span><input type="text" id="form_pc_height" value=""  class="formItem number" style="ime-mode:disabled;" placeholder="" maxlength="5"> px
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="form_group" style="height:63px;">
				<div class="title_left"><br/>M<br>O</div>
				<div class="scroll_x">
					<table class="form_table">
						<tr>
							<td class="form_item_title">위치</td>
							<td class="form_item_contents position">
								<span class="form_field_name">상단</span><input type="text" id="form_mo_top" value=""  class="formItem number" style="ime-mode:disabled;" placeholder="" maxlength="5"> px
								<span class="form_field_name">좌측</span><input type="text" id="form_mo_left" value="" class="formItem number" style="ime-mode:disabled;" placeholder="" maxlength="5"> px
							</td>
						</tr>
						<tr>
							<td class="form_item_title">크기</td>
							<td class="form_item_contents size">
								<span class="form_field_name">넓이</span><input type="text" id="form_mo_width" value="" class="formItem number" style="ime-mode:disabled;" placeholder="" maxlength="5"> px
								<span class="form_field_name">높이</span><input type="text" id="form_mo_height" value="" class="formItem number" style="ime-mode:disabled;" placeholder="" maxlength="5"> px
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="form_group" style="height:470px;">
				<div class="title_left"><br/>이미지</div>
				<div class="scroll_x">
					<div class="thumbnail"></div>
				</div>

				<div style="margin:-40px 15px 0 0;text-align:center;">
					<div class="filebox"> 
						<input type="file" id="file" accept="image/*"> 
						<input class="upload-name" value="이미지경로" readonly>
						<label for="file">이미지 변경</label> 
					</div>
				</div>
			</div>

		</div>

		<div class="list_popup">
			<div class="title_main">목록</div>
			
			<div class="list_header">
				<table>
					<tr>
						<td class="list_item_1">&nbsp;</td>
						<td class="list_item_2">No</td>
						<td class="list_item_3">내용</td>
						<td class="list_item_4">기능</td>
					</tr>
				</table>
			</div>

			<div class="list_body" style="height:730px;">
				<div id="list_popup_mask" class="mask" style="z-index:100;width:400px;height:730px;"></div>
				<div id="list_popup" class="scroll_x"></div>
			</div>

			<div id="list_page" class="list_page">&nbsp;</div>
				
			<div class="list_function">
				<div class="ltItem">
				</div>
				<div class="rtItem">
					<input type="button"	id="button_new"				class="button"	value="신규 팝업 등록"				onclick="openDefaultPopup();"	style="background:blue;border:blue;"	/>
				</div>
			</div>

			</div>

		</div>

	</div>
</body>
</html>
