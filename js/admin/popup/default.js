/*--------------------------------------------------------------------------------------------------------------------------------
||Define
--------------------------------------------------------------------------------------------------------------------------------*/
var globalPopup = {
	seq				: "",
	first			: "",
	count			: 0,
	load			: 0
};

var param				= {
	page			: "1",
	pageSize	: "10",
	keyword		: ""
};

var detail			= {
	idx				: "",
	clear			: function(){
		for(var key in detail){
			if(typeof detail[key] == "string"){
				detail[key] = "";
			}
		}
	}
};

/*--------------------------------------------------------------------------------------------------------------------------------
||Search
--------------------------------------------------------------------------------------------------------------------------------*/
function search(){
	var arg						= arguments;
	var getChecValue	= function(target){
		var result = "";
		$("input[name='"+ target +"']").each(function(idx){
			result+= ($(this).attr("checked") == "checked")? $(this).val()+"," : "";
		});
		return result;
	};

	if				(arg.length == 0){
	}else if	(arg.length == 1){
		if				(arg[0].type == "text"){
			param[arg[0].name.split("_")[1]] = arg[0].value;
		}else if	((arg[0].type == "checkbox") || (arg[0].type == "radio")){
			param[arg[0].name.split("_")[1]] = getChecValue(arg[0].name);
		}
		param.page = "1";

	}else if	(arg.length == 2){
		param[arg[0].split("_")[1]] = arg[1];
		if(arg[0].split("_")[1] != "page"){
			globalContents.idx = "";
			param.page = "1";
		}
	}
	param.keyword = $("#search_keyword").val();
	getPopupList();
}

function clearSearchForm(){
	param.page			= "1";
	param.keyword		= "";
	setSearchForm();
	getPopupList();
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Date
--------------------------------------------------------------------------------------------------------------------------------*/
function getFormatDate(date){
	var year	= date.getFullYear();
	var month = (1+ date.getMonth());
	var day		= date.getDate();
	month		= month > 10	? month		: '0' + month;
	day			= day		>= 10 ? day			: '0'	+ day;
	return year +'-'+ month +'-'+ day;
}

function dateAdd(pInterval, pAddVal, pYyyymmdd, pDelimiter){
 var yyyy;
 var mm;
 var dd;
 var cDate;
 var oDate;
 var cYear, cMonth, cDay;
 
 if (pDelimiter != "") {
  pYyyymmdd = pYyyymmdd.replace(eval("/\\" + pDelimiter + "/g"), "");
 }

 yyyy = pYyyymmdd.substr(0, 4);
 mm		= pYyyymmdd.substr(4, 2);
 dd		= pYyyymmdd.substr(6, 2);
 
 if (pInterval == "yyyy") {
  yyyy = (yyyy * 1) + (pAddVal * 1); 
 } else if (pInterval == "m") {
  mm  = (mm * 1) + (pAddVal * 1);
 } else if (pInterval == "d") {
  dd  = (dd * 1) + (pAddVal * 1);
 }
 
 cDate = new Date(yyyy, mm - 1, dd) // 12월, 31일을 초과하는 입력값에 대해 자동으로 계산된 날짜가 만들어짐.
 cYear = cDate.getFullYear();
 cMonth = cDate.getMonth() + 1;
 cDay = cDate.getDate();
 
 cMonth = cMonth < 10 ? "0" + cMonth : cMonth;
 cDay = cDay < 10 ? "0" + cDay : cDay;

 if (pDelimiter != "") {
  return cYear + pDelimiter + cMonth + pDelimiter + cDay;
 } else {
  return cYear + cMonth + cDay;
 } 
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Popup
--------------------------------------------------------------------------------------------------------------------------------*/
function openDefaultPopup(){
	var arg			= arguments;
	var inParam = {
	};

	var setArg = function(){
	}

	var setForm	= function(){
		var date = new Date();
		var startDate = getFormatDate(date);
		var endDate		= dateAdd("d", 7, startDate, "-");
		$("#default_popup #prviewImg").attr("src","").hide();
		$("#default_popup #default_popup_name").val("");
		$("#default_popup .default_popup_upload-name").val("이미지경로");
		$("#default_popup #default_popup_time").val("24");
		$("#default_popup #default_popup_time").off().number(true, 0);
		$("#default_popup #default_popup_start_date").val(startDate);
		$("#default_popup #default_popup_end_date").val(endDate);
	};

	var setEvent = function(){
		$("#default_popup #process").off().click(function(){
			process();
		});

		$("#default_popup #cancel").off().click(function(){
			closeDefaultPopup();
		});
	};

	var checkForm = function(){
		var result = true;
		if(result && ($("#default_popup #default_popup_name").val().trim() == "")){
			alert("팝업 제목을 입력하세요.");			
			$("#default_popup #default_popup_name").focus();
			result = false;
		}
		if(result && ($("#default_popup #default_popup_file").val().trim() == "")){
			alert("팝업 이미지를 선택해주세요!");			
			$("#default_popup #default_popup_file").focus();
			result = false;
		}
		if(result && ($("#default_popup #default_popup_exposed_time").val().trim() == "")){
			alert("다시 보지 않음을 선택시\n몇 시간동안 보여주지 않을 시간을 입력하세요.");			
			$("#default_popup #default_popup_exposed_time").focus();
			result = false;
		}
		if(result && ($("#default_popup #default_popup_start_date").val().trim() == "")){
			alert("시작날짜를 입력하세요!");			
			$("#default_popup #default_popup_start_date").focus();
			result = false;
		}
		if(result && ($("#default_popup #default_popup_end_date").val().trim() == "")){
			alert("종료날짜를 입력하세요!");			
			$("#default_popup #default_popup_end_date").focus();
			result = false;
		}
		if(result && ($("#default_popup #default_popup_start_date").val().trim() > $("#default_popup #default_popup_end_date").val().trim())){
			alert("종료날짜가 시작 날짜보다 이전입니다.");			
			$("#default_popup #default_popup_end_date").focus();
			result = false;
		}
		return result;
	};

	var process = function(){
		if(checkForm()){
			var data = new FormData();
			data.append("name",						$("#default_popup #default_popup_name").val().trim());
			data.append("file",						$("#default_popup #default_popup_file")[0].files[0]);
			data.append("exposed_time",		$("#default_popup #default_popup_exposed_time").val().trim());
			data.append("start_date",			$("#default_popup #default_popup_start_date").val().trim());
			data.append("end_date",				$("#default_popup #default_popup_end_date").val().trim());
			$.ajax({
					url					: "/process/admin/popup/insert_popup.asp",
					type				: "POST",
					enctype			: "multipart/form-data",
					data				: data,
					dataType		: "xml",
					processData	: false,
					contentType	: false,
					cache				: false,
					async				: true,
					timeout			: 600000,
					success			: function(xml,textStatus){
						var answer	= $(xml).find("result").find("answer").text().unescape().trim();
						var message = $(xml).find("result").find("message").text().unescape().trim();
						if(answer == "ok"){
							globalPopup.seq = "";
							getPopupList();	
							closeDefaultPopup();
						}else{
							alert(message);
						}				
					},
					error			:	function(xhr,textStatus){parent.alert('error:openDefaultPopup() -> process();<br>관리자에게 문의하세요.<br>status:'+textStatus);}
			});
		}
	};

	setArg();
	setForm();
	setEvent();
	setTimeout(function(){
		openPopup("bg_popup,default_popup");
		$("#default_popup #default_popup_name").focus();
	},300);
}

function closeDefaultPopup(){
	closePopup("default_popup,bg_popup");
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Form
--------------------------------------------------------------------------------------------------------------------------------*/
function setDefaultPopupForm(){
	var targetFileForm	= "#default_popup #default_popup_file";
	var targetFileName	= "#default_popup .default_popup_upload-name";
	var targetImage			= "#default_popup #prviewImg";
	$(targetFileForm).off().on("change", function(){
		$(targetImage).hide();
		$(targetFileName).val("이미지경로");
		if(str_popup_fileExtension.indexOf(this.value.right(3)) == -1){
			alert("파일 확장자는 "+ str_popup_fileExtension + "만 가능합니다.");
			$(targetFileForm).val("");
			return;
		}else{
			var src = this.value;
			var file = this.files[0];
			try{ 
				var reader = new FileReader();
				reader.onload = function(e){
					$(targetImage).attr("src", e.target.result);
					$(targetImage).show();
				}
				reader.readAsDataURL(file);
				$(targetFileName).val(src);
			}catch(e){
				console.log("exception:"+ e);
			} 
		}
	});
}

function setDefaultForm(){
	//Clear Event
	$(".form_default .number").each(function(){
		$(this).off();
	});

	$(".form_default .formItem").each(function(){
		$(this).off();
	});

	//Set Default
	var arg = arguments;
	var setDeviceOption = function(){
		var target = "form_view_device";
		$("#"+target + " *").remove();
		$("#"+target).append("<option value=''>선택</option>"); 	
		$.each(arr_popup_device, function(idx, item){
			$("#"+target).append("<option value='"+ item.code +"'>"+ item.value +"</option>"); 	
		});
	};

	var setDefaultStartDate = function(){
		var target		= "form_start_date";
		var checkbox	= "check_default_start_date";
		$("#"+checkbox).click(function(){
			if($("#"+target).val().trim() == ""){
			}else{
			}
		});
	};

	var setDefaultEndDate = function(){
		var target		= "form_end_date";
		var checkbox	= "check_default_end_date";
		$("#"+checkbox).click(function(){
			if($("#"+target).val().trim() == ""){
			}else{
			}
		});
	};

	$(".form_default .number").each(function(){
   $(this).on("keyup", function(){
      $(this).val($(this).val().replace(/[^0-9]/g,""));
   });
	});

	$(".form_default .formItem").each(function(){
   $(this).on("focus", function(){		
			checkUpdatePopup();
	 });
   $(this).on("blur", function(){		
			checkUpdatePopup();
	 });
   $(this).on("change", function(){		
			checkUpdatePopup();
			window.focus();
	 });
   $(this).on("keydown", function(){		
			checkUpdatePopup();
	 });
	});

	//Set Upload
	$(".form_default .filebox label").click(function(){
		if(globalPopup.seq == ""){
			alert("선택된 팝업이 없습니다.");
			return;
		}
	});

	var targetFileForm	= ".form_default #file";
	var targetFileName	= ".form_default .upload-name";
	$(targetFileForm).off().on("change", function(){
		$(targetFileName).val("이미지경로");
		
		if(this.value.trim() != ""){
			if(str_popup_fileExtension.indexOf(this.value.right(3)) == -1){
				alert("파일 확장자는 "+ str_popup_fileExtension + "만 가능합니다.");
				$(targetFileForm).val("");
				return;
			}else{
				$(targetFileName).val(this.value);
				updateImage();
				console.log("check");
			}
		}

	});	


	//Run
	setDeviceOption();
	setDefaultStartDate();
	setDefaultEndDate();
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Check
--------------------------------------------------------------------------------------------------------------------------------*/
function checkUpdatePopup(){
	var check = function(){
		var result = true;
		if(globalPopup.seq == "" ) result = false;
		return result;
	};

	if(event.type == "focus"){
		if(check() == false){
			alert("선택된 대상이 없습니다.\n\n선택 후 진행하세요.");
			window.focus();
		}else{
			$("#list_popup_mask").show();
		}
	}else if((event.type == "blur") || (event.type == "change") || ((event.type == "keydown") && (event.keyCode == 13))){
		setTimeout(function(){
			$("#list_popup_mask").hide();
		},100);

		if((event.srcElement.id.replace("form_","") == "name") && event.target.value.trim() == ""){
			alert("팝업제목을 입력하세요!");
			init();
			return;
		}

		if((event.srcElement.id.replace("form_","") == "time") && event.target.value.trim() == ""){
			alert("시간을 입력하세요!");
			init();
			return;
		}


		if(("start_date,end_date".indexOf(event.srcElement.id.replace("form_","")) > -1)){
			if($("#form_start_date").val() > $("#form_end_date").val()){
				alert("종료일이 시작일보다 이전입니다.");
				init();
				return;
			}
		}
		if(check() == false){
			event.srcElement.value = "";
		}else{
			var field = event.srcElement.id.replace("form_","");
			var value = event.srcElement.value;
			//if(confirm("내용을 변경하시겠습니까?")){
				if			("pc_top,pc_left".indexOf(field)			> -1){
					field = "pc_position";
					value = $(".form_default #form_pc_top").val().trim() +"*"+ $(".form_default #form_pc_left").val().trim();
				}else if("pc_width,pc_height".indexOf(field)	> -1){
					field = "pc_size";
					value = $(".form_default #form_pc_width").val().trim() +"*"+ $(".form_default #form_pc_height").val().trim();
				}else if("mo_top,mo_left".indexOf(field)			> -1){
					field = "mo_position";
					value = $(".form_default #form_mo_top").val().trim() +"*"+ $(".form_default #form_mo_left").val().trim();
				}else if("mo_width,mo_height".indexOf(field)	> -1){
					field = "mo_size";
					value = $(".form_default #form_mo_width").val().trim() +"*"+ $(".form_default #form_mo_height").val().trim();
				}
				updatePopup(globalPopup.seq,field ,value);
			//}else{
				//event.srcElement.value = detail[field].trim();
			//}
		}
	}
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Process
--------------------------------------------------------------------------------------------------------------------------------*/
function updatePopup(target,field,value){
	$.ajax({
			url				: "/process/admin/popup/update_popup.asp",
			type			: "POST",
			data			: {
										"target"	: target,
										"field"		: field,
										"value"		: value
									},
			dataType	: "xml",
			async			: false,
			success		: function(xml,textStatus){
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();
				if(answer == "ok"){
						getPopupList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus)	{alert('error:updatePopup();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
}

function updatePopupOrderNum(maxNum,target){
		$.ajax({
			url				: "/process/admin/popup/update_popup_order_num.asp",
			type			: "POST",
			data			: {
										"maxNum" : maxNum,
										"target" : target
									},
			dataType	: "xml",
			async			: false,
			success		: function(xml,textStatus){
				
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();

				if(answer == "ok"){
					getPopupList();
				}else{
					alert("error!\n"+message);
				}
			},
			error					:	function(xhr,textStatus){alert('error:updatePopupOrderNum();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend	:	function(xhr)						{alert('데이터보내기전');},
			//complete		:	function(xhr,textStatus){alert('응답완료.');}
	});		
}

function deletePopup(target){
	if(confirm("선택 팝업을 삭제 하시겠습니까?") == false) return;

	$.ajax({
			url				: "/process/admin/popup/delete_popup.asp",
			type			: "POST",
			data			: {
										"target" : target
									},
			dataType	: "xml",
			async			: false,
			success		: function(xml,textStatus){
				
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();

				if(answer == "ok"){
					globalPopup.seq = "";
					setTimeout(function(){
						getPopupList();
					},200);
				}else{
					alert("error!\n"+message);
				}
			},
			error					:	function(xhr,textStatus){alert('error:deletePopup();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend	:	function(xhr)						{alert('데이터보내기전');},
			//complete		:	function(xhr,textStatus){alert('응답완료.');}
	});			
}

function updateImage(){
	var data = new FormData();
	data.append("target",					globalPopup.seq);
	data.append("file",						$(".form_default #file")[0].files[0]);

	$.ajax({
			url					: "/process/admin/popup/update_image.asp",
			type				: "POST",
			enctype			: "multipart/form-data",
			data				: data,
			dataType		: "xml",
			processData	: false,
			contentType	: false,
			cache				: false,
			async				: true,
			timeout			: 600000,
			success			: function(xml,textStatus){
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();
				if(answer == "ok"){
					getPopupList();	
				}else{
					alert(message);
				}				
			},
			error			:	function(xhr,textStatus){parent.alert('error:updateImage<br>관리자에게 문의하세요.<br>status:'+textStatus);}
	});

}

/*--------------------------------------------------------------------------------------------------------------------------------
||Init
--------------------------------------------------------------------------------------------------------------------------------*/
function init(){
	setDefaultForm();
	setDefaultPopupForm();
	getPopupList();
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Load
--------------------------------------------------------------------------------------------------------------------------------*/
$(document).ready(function(){
	init();
});
/*------------------------------------------------------------------------------------------------------------------------------*/