<!-- #include virtual="/lib/include/adminLoginBundle.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>로그인 : 옥길아라동물의료센터</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<script src="/js/global/jquery-3.5.1.min.js"></script>
	<script src="/js/global/jquery-cookie.js"></script>
	<script src="/js/global/common.js"></script>
	<script src="/js/admin/login/default.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/admin/login/default.css"/>
</head>
<body>

	<div id="wrap">

		<div id="header">
			<img src="/resource/image/common/logo.png" alt="옥길아라동물의료센터" title="옥길아라동물의료센터" />
		</div>

		<div id="body">

			<div id="box_title"><%'옥길아라동물의료센터%></div>
			<div id="box_message">&nbsp;</div>
			<div id="box_login">
				<input id="id" class="input" value="" type="text"	style="ime-mode:disabled;" onkeypress="if(event.keyCode == 13){login();}" maxlength="30" placeholder="아이디"/>
				<input id="pw" class="input" value="" type="password"												 onkeypress="if(event.keyCode == 13){login();}" maxlength="30" placeholder="비밀번호"/>
				<input type="button" id="login" class="button" value="LOGIN" onclick="login();" />
			</div>
			<div id="box_check">
				<input type="checkbox" id="save_check" value="o" onclick="setFormCheck(this);"> <label for="save_check">아이디 기억하기</label>
			</div>
		</div>

		<div id="footer">
			
		</div>

	</div>

</body>
</html>
