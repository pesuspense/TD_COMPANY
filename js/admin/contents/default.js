function getContentsList(){
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Define
--------------------------------------------------------------------------------------------------------------------------------*/
var globalContents = {
	idx				: "",
	first			: "",
	count			: 0,
	load			: 0
};

var param		= {
	type			: getCookie("contents_type"),
	page			: "1",
	keyword		: ""
};

var detail = {
	idx				: "",
	imagesType: "",
	clear			: function(){
		for(var key in detail){
			if(typeof detail[key] == "string"){
				detail[key] = "";
			}
		}
	}
};

/*--------------------------------------------------------------------------------------------------------------------------------
||Form
--------------------------------------------------------------------------------------------------------------------------------*/
function initSearchForm(){
	$("#search_type").val(param.type);
	if(param.type == ""){
		$("#top_button").hide();
	}else{
		$("#top_button").hide();
	}
}

function setTap(){
	var arg = arguments;

	if(arg.length == 1){
		setCookie("contents_tap", arg[0]);
	}

	var tap = getCookie("contents_tap");
			tap = (tap == "")? "contents" : tap;

	$(".detail .contentsTap"	).removeClass("on");
	$(".detail .imagesTap"		).removeClass("on");
	$(".detail ."+ tap +"Tap"	).addClass("on");

	$(".detail .contents"		).hide();	
	$(".detail .images"			).hide();
	$(".detail ."+tap				).show();
}

function setSearchForm(){
	var setCheckForm	= function(name,value){
		$("input[name='"+ name +"']").each(function(index){
			if(value.indexOf($(this).val()) > -1){
				$(this).attr("checked", true);
			}else{
				$(this).attr("checked", false);
			}
		});
	};

	var setInputForm = function(id,value){
		$("#"+id).val(value);
	}

	setInputForm("search_type",				param.type);
	setInputForm("search_keyword",		param.keyword);
}

function insertContentsImages(src){
	var tag			 = '<img src="'+ src +'" alt="" />'
	var contents = $("#form_contents").val();

	if(contents.indexOf(src) != -1){
		alert("이미 내용에 포함된 이미지 입니다.");
		return;
	}
	insertCurrentPositionText("form_contents",tag);
}

function init(){

	if(getCookie("contents_type") == ""){
		setCookie("contents_type", "news");
		param.type = "news";
	}

	setTap();
	getContentsList();
	initSearchForm();
}


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

		if(arg[0].split("_")[1] == "type"){
			setCookie("contents_type",$("#search_type").val());
			initSearchForm();
			window.focus();
		}
	}
	param.type		= $("#search_type").val();
	param.keyword = $("#search_keyword").val();
	getContentsList();
}

function clearSearchForm(){
	param.page			= "1";
	param.keyword		= "";

	setCookie("contents_type","");

	setSearchForm();
	getContentsList();
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Check
--------------------------------------------------------------------------------------------------------------------------------*/
function checkUpdateContents(){
	var check = function(){
		var result = true;
		if(globalContents.idx == ""					) result = false;
		return result;
	};

	if				(event.type == "focus"){
		if(check() == false){
			alert("선택된 대상이 없습니다.\n\n선택 후 진행하세요.");
			window.focus();
		}else{
			$("#list_contents_mask").show();
		}
	}else if	((event.type == "blur") || (event.type == "change") || ((event.type == "keydown") && (event.keyCode == 13))){

		$("#list_contents_mask").hide();

		if(check() == false){
			event.srcElement.value = "";
		}else{
			var field = event.srcElement.id.split("form_")[1];
			if(detail[field].trim() != event.srcElement.value.trim()){
				//if(confirm("내용을 변경하시겠습니까?")){

					updateContents(globalContents.idx,field ,event.srcElement.value);

				//}else{
					//event.srcElement.value = detail[field].trim();
				//}
			}else{
				event.srcElement.value = event.srcElement.value.trim();
			}
		}
	}
}

function checkInsertImages(type){
	var check = function(){
		var result = true;
		if(globalContents.idx == "") result = false;
		return result;
	};

	if(check() == false){
		alert("선택된 대상이 없습니다.");
		return;
	}

	detail.imagesType = type;
	uploadImages.obj.FileUpload(uploadImages.idForFlash);
}

function checkUpdateImages(target,field,value){

	if(value == "d"){
		if(confirm("선택하신 이미지를 삭제하시겠습니까?") == false){
			return;
		}
	}
	updateImages(target, field, value);
}

function setTop(type){
	var getTarget = function(){
		var result = "";
		$("input[name='list_checkbox_contentsNum']").each(function(i){
			if($(this).is(":checked") == true){
				result+= ","+ $(this).val() +",";
			}
		});
		return result;
	};
	if(getTarget() == ""){
		alert("선택 대상이 없습니다.");
		return;		
	}
	updateContents(getTarget(),"division",type)
}
/*--------------------------------------------------------------------------------------------------------------------------------
||Process
--------------------------------------------------------------------------------------------------------------------------------*/
function insertContents(){

	if($("#search_type").val() == ""){
		alert("새글의 타입을 선택하세요!");
		$("#search_type").focus();
		return;
	}

	if(confirm("컨텐츠를 등록 하시겠습니까?") == false) return;

	$.ajax({
			url				: "/process/admin/contents/insert_contents.asp",
			type			: "POST",
			data			: {"type" : param.type},
			dataType	: "xml",
			async			: false,
			success		: function(xml,textStatus){
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();
				var idx			= $(xml).find("result").find("idx").text().unescape().trim();
				if(answer == "ok"){
					globalContents.idx = idx;
					getContentsList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus){alert('error:insertContents();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
}

function updateContents(target,field,value){
	$.ajax({
			url				: "/process/admin/contents/update_contents.asp",
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
					getContentsList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus)	{alert('error:updateContents();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
}

function deleteContents(){
	var getTarget = function(){
		var result = "";
		$("input[name='list_checkbox_contentsNum']").each(function(i){
			if($(this).is(":checked") == true){
				result+= ","+ $(this).val() +",";
			}
		});
		return result;
	};
	if(getTarget().trim() == ""){
		alert("삭제할 컨텐츠를 선택하세요!");
		return;
	}
	if(confirm("선택 컨텐츠를 삭제 하시겠습니까?") == false) return;

	$.ajax({
			url				: "/process/admin/contents/delete_contents.asp",
			type			: "POST",
			data			: {
										"target" : getTarget()
									},
			dataType	: "xml",
			async			: false,
			success		: function(xml,textStatus){
				
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();

				if(answer == "ok"){
					getContentsList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus){alert('error:deleteContents();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
}

function updateImages(){
	var arg			= arguments;
	var param		= {
		"target"	: arg[0],
		"field"		: arg[1],
		"value"		: arg[2]
	};

	$.ajax({
			url				: "/process/admin/contents/update_images.asp",
			type			: "POST",
			data			: param,
			dataType	: "xml",
			async			: false,
			success		: function(xml,textStatus){
				
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();

				if(answer == "ok"){
					getContentsList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus){alert('error:updateImages();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});	
}

function publish(){
	if(detail.idx == ""){
		alert("선택된 대상이 없습니다.");
		return;
	}

	if($("#form_division").val().trim() == ""){
		alert("컨텐츠 구분을 입력하세요.");
		$("#form_division").focus();
		return;
	}

	if($("#form_title").val().trim() == ""){
		alert("컨텐츠 제목을 입력하세요.");
		$("#form_title").focus();
		return;
	}

	if($("#form_contents").val().trim() == ""){
		alert("컨텐츠 내용을 입력하세요.");
		$("#form_contents").focus();
		return;
	}

	/*
	if($("#form_keyword").val().trim() == ""){
		alert("컨텐츠 키워드를 입력하세요.");
		$("#form_keyword").focus();
		return;
	}
	*/

	if(confirm("컨텐츠를 게시하시겠습니까?") == false){
		return;
	}

	$.ajax({
			url				: "/process/admin/contents/publish.asp",
			type			: "POST",
			data			: {
										"target"	: detail.idx
									},
			dataType	: "xml",
			async			: false,
			success		: function(xml,textStatus){
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();
				if(answer == "ok"){
					getContentsList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus)	{alert('error:publish();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});
}

function unPublish(){

	if(confirm("컨텐츠를 발행 취소하시겠습니까?") == false){
		return;
	}

	$.ajax({
			url				: "/process/admin/contents/unPublish.asp",
			type			: "POST",
			data			: {
										"target"	: detail.idx
									},
			dataType	: "xml",
			async			: false,
			success		: function(xml,textStatus){
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();
				if(answer == "ok"){
					getContentsList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus)	{alert('error:unPublish();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Load
--------------------------------------------------------------------------------------------------------------------------------*/
$(document).ready(function(){
	init();
});
/*------------------------------------------------------------------------------------------------------------------------------*/