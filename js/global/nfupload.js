/*****************************************************
/* 함수 - 초기화
/****************************************************/
var NFUpload = function(args) {
	try{
		if (navigator.appName.indexOf("explorer") > 0){
			document.execCommand("BackgroundImageCache", false, true);
		}
	}catch(e){
		Debug("Initialize error.");
	}

	try{
		this.Variables = {};
		this.Initialize(args);
		NFUpload.instances[this.GetValue("NFUploadId")] = this;
		this.Load();
	}catch(e) {
		Debug("Flash uploader error.");
	}
};

NFUpload.instances = {};
NFUpload.prototype.Initialize = function(args) {
    this.SetValue("NFUploadId",						args.nf_upload_id,							"");
    this.SetValue("Width",								args.nf_width,									"450");
    this.SetValue("Height",								args.nf_height,									"170");
    this.SetValue("ColumnHeader1",				args.nf_field_name1,						"File Name");
    this.SetValue("ColumnHeader2",				args.nf_field_name2,						"Size");
    this.SetValue("MaxFileSize",					args.nf_max_file_size,					"20480");
    this.SetValue("MaxFileCount",					args.nf_max_file_count,					"10");
    this.SetValue("UploadUrl",						args.nf_upload_url,							"");
    this.SetValue("FileFilter",						args.nf_file_filter,						"");
    this.SetValue("DataFieldName",				args.nf_data_field_name,				"DataFieldName");
    this.SetValue("FontFamily",						args.nf_font_family,						"New Times Roman");
    this.SetValue("FontSize",							args.nf_font_size,							"11");
    this.SetValue("FlashUrl",							args.nf_flash_url,							"");
    this.SetValue("FileOverwrite",				args.nf_file_overwrite,					true);
    this.SetValue("LimitExt",							args.nf_limit_ext,							"asp;php;aspx;jsp;html;htm");
    this.SetValue("ImgFileBrowse",				args.nf_img_file_browse,				"images/btn_file_browse.gif");			// [2008-10-28] Flash 10 support
    this.SetValue("ImgFileBrowseWidth",		args.nf_img_file_browse_width,	"59");
    this.SetValue("ImgFileBrowseHeight",	args.nf_img_file_delete_height, "22");
    this.SetValue("ImgFileDelete",				args.nf_img_file_delete,				"images/btn_file_delete.gif");
    this.SetValue("ImgFileDeleteWidth",		args.nf_img_file_delete_width,	"59");
    this.SetValue("ImgFileDeleteHeight",	args.nf_img_file_delete_height, "22");
    this.SetValue("TotalSizeText",				args.nf_total_size_text,				"Total size: ");
    this.SetValue("TotalSizeFontFamily",	args.nf_total_size_font_family, "굴림");
    this.SetValue("TotalSizeFotnSize",		args.nf_total_size_font_size,		"12");
};

NFUpload.prototype.SetValue = function(name, value, defValue) {
	if (typeof(value) == null){
		this.Variables[name] = defValue;
	}else if (typeof(value) != null && value == null){
		this.Variables[name] = defValue;
	}else{
		this.Variables[name] = value;
	}
	return this.Variables[name];
};

NFUpload.prototype.GetValue = function(name) {
	if (typeof(this.Variables[name]) == null || typeof(this.Variables[name]) == "undefined"){
			return "";
	}else{
			return this.Variables[name];
	}
};

NFUpload.prototype.GetFlashTag = function() {
	var str = "";
	if (navigator.plugins && navigator.mimeTypes && navigator.plugins.length){
		str = "<embed type=\"application/x-shockwave-flash\" src=\"" + this.GetValue("FlashUrl") + "\" width=\"" + this.GetValue("Width") + "\" height=\"" + this.GetValue("Height") + "\"";
		str += " Id=\"" + this.GetValue("NFUploadId") + "\" name=\"" + this.GetValue("NFUploadId") + "\" quality=\"high\" bgcolor=\"#869ca7\" type=\"application/x-shockwave-flash\"";
		str += " allDomain=\"allDomain.com\"";
		str += " flashvars=\"" +  this.GetFlashVars() + "\" />";
	}else{
		str = "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\"" + this.GetValue("Width") + "\" height=\"" + this.GetValue("Height") + "\"";
		str += " Id=\"" + this.GetValue("NFUploadId") + "\" codebase=\"http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab\">";
		str += "<param name=\"movie\" value=\"" + this.GetValue("FlashUrl") + "\" />";
		str += "<param name=\"bgcolor\" value=\"#869ca7\" />";
		str += "<param name=\"quality\" value=\"high\" />";
		str += "<param name=\"flashvars\" value=\"" + this.GetFlashVars() + "\" />";
		str += "</object>";
	}
	return str;
};

NFUpload.prototype.GetFlashVars = function() {
	var str = "";
	str =  "NFUploadId="						+ encodeURIComponent(this.GetValue("NFUploadId"));
	str += "&Width="								+ encodeURIComponent(this.GetValue("Width"));
	str += "&Height="								+ encodeURIComponent(this.GetValue("Height"));
	str += "&ColumnHeader1="				+ encodeURIComponent(this.GetValue("ColumnHeader1"));
	str += "&ColumnHeader2="				+ encodeURIComponent(this.GetValue("ColumnHeader2"));
	str += "&MaxFileSize="					+ encodeURIComponent(this.GetValue("MaxFileSize"));
	str += "&MaxFileCount="					+ encodeURIComponent(this.GetValue("MaxFileCount"));
	str += "&UploadUrl="						+ encodeURIComponent(this.GetValue("UploadUrl"));
	str += "&FileFilter="						+ encodeURIComponent(this.GetValue("FileFilter"));
	str += "&DataFieldName="				+ encodeURIComponent(this.GetValue("DataFieldName"));
	str += "&FontFamily="						+ encodeURIComponent(this.GetValue("FontFamily"));
	str += "&FlashUrl="							+ encodeURIComponent(this.GetValue("FlashUrl"));
	str += "&FileOverwrite="				+ encodeURIComponent(this.GetValue("FileOverwrite"));
	str += "&LimitExt="							+ encodeURIComponent(this.GetValue("LimitExt"));
	str += "&ImgFileBrowse="				+ encodeURIComponent(this.GetValue("ImgFileBrowse"));				// [2008-10-28] Flash 10 support
	str += "&ImgFileBrowseWidth="		+ encodeURIComponent(this.GetValue("ImgFileBrowseWidth"));
	str += "&ImgFileBrowseHeight="	+ encodeURIComponent(this.GetValue("ImgFileBrowseHeight"));
	str += "&ImgFileDelete="				+ encodeURIComponent(this.GetValue("ImgFileDelete"));
	str += "&ImgFileDeleteWidth="		+ encodeURIComponent(this.GetValue("ImgFileDeleteWidth"));
	str += "&ImgFileDeleteHeight="	+ encodeURIComponent(this.GetValue("ImgFileDeleteHeight"));
	str += "&TotalSizeText="				+ encodeURIComponent(this.GetValue("TotalSizeText"));
	str += "&TotalSizeFontFamily="	+ encodeURIComponent(this.GetValue("TotalSizeFontFamily"));
	str += "&TotalSizeFontSize="		+ encodeURIComponent(this.GetValue("TotalSizeFontSize"));
	return str;
};

/*****************************************************
/* 함수 - 클라이언트(로드/파일선택/업로드/단일삭제/모두삭제)
/****************************************************/
NFUpload.prototype.Load						= function(){
	document.write(this.GetFlashTag());
};

NFUpload.prototype.FileBrowse			= function(target){
	document.all[this.GetValue(target)].FileBrowse();
};

NFUpload.prototype.FileUpload			= function(target) {
	document.getElementById(target).FileUpload();
};

NFUpload.prototype.AllFileDelete	= function(target){
	document.getElementById(target).AllFileDelete();
}

/*****************************************************
/* 함수 - 용량
/****************************************************/
function SizeCalc(fileSize) {
  var strSize = "";
  result *= 1024;																	// 넘어오는 값 단위가 KB 단위이기 때문에 1024를 곱해준다.
   
  if (result > (1024*1024*1024)){									// GB 단위 계산			
			result /= (1024 * 1024 * 1024);							
			strSize = Math.round(result)	+ " GB";
	}else if (result > (1024*1024)){	              // MB 단위 계산
		result /= (1024*1024);
		strSize = Math.round(result)		+ " MB";
	}else if (result > 1024){	                      // KB 단위 계산
		result /= 1024;
		strSize = Math.round(result)		+ " KB";
	}else{
		strSize = result.toString()			+ " Byte";
	}
	return strSize;
}

/*****************************************************
/* 함수 - 디버그 
/****************************************************/
function Debug(value) {
	alert(value);
	return;
}