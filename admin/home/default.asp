<!-- #include virtual="/lib/include/adminDefaultBundle.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>옥길아라동물의료센터</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<script src="/js/global/jquery-3.5.1.min.js"></script>
	<script src="/js/global/jquery-cookie.js"></script>
	<script src="/js/global/common.js"></script>
	<script src="/js/admin/home/default.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/admin/home/default.css"/>
</head>
<body>

	<div id="wrap">

		<div id="header">
			<div id="headerTop">
				<div id="headerTopLeft">
					<a href="javascript:setMenu('admin/page');"><img src="/resource/image/common/logo.png"/></a>
				</div>
				<div id="headerTopCenter">
					<ul>
						<li><a class="menu" id="admin/page"					href="javascript:setMenu('admin/page');">메타설정</a></li>
						<li><a class="menu" id="admin/popup"				href="javascript:setMenu('admin/popup');">팝업설정</a></li>
					</ul>
				</div>
				<div id="headerTopRight">
					<a href="/process/admin/logout/">&nbsp;<%=getCookie("mem_name")%> 로그아웃</a>&nbsp;&nbsp;
				</div>
			</div>
			<div id="headerBot">
				<ul><li></li></ul>
			</div>
		</div>

		<div id="body">
			
		</div>

		<div id="footer">

		</div>

	</div>

</body>
</html>
