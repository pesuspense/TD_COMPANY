/*--------------------------------------------------------------------------------------------------------------------------------
||Define
--------------------------------------------------------------------------------------------------------------------------------*/
var globalInquiryDefault			= {
	idx				: "",
	first			: "",
	count			: 0,
	load			: 0
};

var param		= {
	page			: "1",
	keyword		: ""
};

var detail = {
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
||Form
--------------------------------------------------------------------------------------------------------------------------------*/
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

	setInputForm("search_keyword",		param.keyword);
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
			param.page = "1";
		}
	}

	param.keyword = $("#search_keyword").val();
	getInquiryDefaultList();
}

function clearSearchForm(){
	param.page			= "1";
	param.keyword		= "";
	setSearchForm();
	getInquiryDefaultList();
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Check
--------------------------------------------------------------------------------------------------------------------------------*/
function checkUpdateInquiryDefault(){
	var check = function(){
		var result = true;
		if(globalInquiryDefault.idx == "" ) result = false;
		return result;
	};

	if(event.type == "focus"){
		if(check() == false){
			alert("선택된 대상이 없습니다.\n\n선택 후 진행하세요.");
			window.focus();
		}else{
			$("#list_inquiryDefault_mask").show();
		}
	}else if	((event.type == "blur") || (event.type == "change") || ((event.type == "keydown") && (event.keyCode == 13))){
		$("#list_inquiryDefault_mask").hide();

		if(check() == false){
			event.srcElement.value = "";
		}else{
			var field = event.srcElement.id.split("form_inquiry_")[1];
			if(detail[field].trim() != event.srcElement.value.trim()){
				//if(confirm("내용을 변경하시겠습니까?")){
					updateInquiryDefault(globalInquiryDefault.idx,field ,event.srcElement.value);
				//}else{
					//event.srcElement.value = detail[field].trim();
				//}
			}else{
				event.srcElement.value = event.srcElement.value.trim();
			}
		}
	}
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Process
--------------------------------------------------------------------------------------------------------------------------------*/
function updateInquiryDefault(target,field,value){
	$.ajax({
			url				: "/process/admin/inquiry/update_inquiryDefault.asp",
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
					if(field == "state"){
						getInquiryDefaultList();
					}
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus)	{alert('error:updateInquiryDefault();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
}

function deleteInquiryDefault(){
	var getTarget = function(){
		var result = "";
		$("input[name='list_checkbox_inquiryNum']").each(function(i){
			if($(this).is(":checked") == true){
				result+= ","+ $(this).val() +",";
			}
		});
		return result;
	};


	if(getTarget().trim() == ""){
		alert("삭제할 페이지를 선택하세요!");
		return;
	}

	if(confirm("선택 페이지를 삭제 하시겠습니까?") == false) return;

	$.ajax({
			url				: "/process/admin/inquiry/delete_inquiryDefault.asp",
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
					getInquiryDefaultList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus){alert('error:deleteInquiryDefault();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Init
--------------------------------------------------------------------------------------------------------------------------------*/
function init(){
	getInquiryDefaultList();
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Load
--------------------------------------------------------------------------------------------------------------------------------*/
$(document).ready(function(){
	init();
});
/*------------------------------------------------------------------------------------------------------------------------------*/