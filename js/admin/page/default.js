/*--------------------------------------------------------------------------------------------------------------------------------
||Define
--------------------------------------------------------------------------------------------------------------------------------*/
var globalPageItem			= {
	idx				: "",
	first			: "",
	count			: 0,
	load			: 0
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
||Search
--------------------------------------------------------------------------------------------------------------------------------*/


/*--------------------------------------------------------------------------------------------------------------------------------
||Form
--------------------------------------------------------------------------------------------------------------------------------*/
function setDefaultForm(){
	var arg = arguments;

	if(arg.length == 1){
		if(arg[0] == ""){
			$(".form_default .filebox").hide();
		}else{
			$(".form_default .filebox").show();
		}
	}

	$(".form_default #file").off().on("change", function(){
		if(this.value.right(3) == "jpg"){
			$(".form_default .upload-name").val(this.value);
			uploadImage();
		}else{
			$(".form_default .upload-name").val("");
			alert("*.jpg 이미지만 등록 가능합니다.");
		}
	})
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Check
--------------------------------------------------------------------------------------------------------------------------------*/
function checkUpdatePageMeta(){
	var check = function(){
		var result = true;
		if(globalPageItem.idx == "" ) result = false;
		return result;
	};

	if(event.type == "focus"){
		if(check() == false){
			alert("선택된 대상이 없습니다.\n\n선택 후 진행하세요.");
			window.focus();
		}else{
			$("#list_pageItem_mask").show();
		}
	}else if	((event.type == "blur") || (event.type == "change") || ((event.type == "keydown") && (event.keyCode == 13))){
		$("#list_pageItem_mask").hide();

		if(check() == false){
			event.srcElement.value = "";
		}else{
			var field = event.srcElement.id.split("form_")[1];
			if(detail[field].trim() != event.srcElement.value.trim()){
				//if(confirm("내용을 변경하시겠습니까?")){
					updatePageMeta(globalPageItem.idx,field ,event.srcElement.value);
				//}else{
					//event.srcElement.value = detail[field].trim();
				//}
			}else{
				event.srcElement.value = event.srcElement.value.trim();
			}
		}
	}
}

function checkInsertImages(){
	var check = function(){
		var result = true;
		if(globalPageItem.idx == ""					) result = false;
		return result;
	};
	if(check() == false){
		alert("선택된 대상이 없습니다.");
		return;
	}
	uploadImages.obj.FileUpload(uploadImages.idForFlash);
}

function checkUpdateImages(target,field,value){
	if(field == "state"){
		if(confirm("선택하신 이미지를 삭제하시겠습니까?") == false){
			return;
		}
	}
	updateImages(target, field, value);
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Process
--------------------------------------------------------------------------------------------------------------------------------*/
function insertPageItem(){
	var arg		= arguments;
	var param = {"parent" : ""};

	if(arg.length == 1){
		param.parent = arg[0];
	}

	if(confirm("새로운 페이지 항목을 등록 하시겠습니까?") == false) return;

	$.ajax({
			url				: "/process/admin/page/insert_pageItem.asp",
			type			: "POST",
			data			: param,
			dataType	: "xml",
			async			: false,
			success		: function(xml,textStatus){
				
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();
				var idx			= $(xml).find("result").find("idx").text().unescape().trim();

				if(answer == "ok"){
					globalPageItem.idx = idx;
					getPageItemList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus){alert('error:insertPageItem();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
}

function updatePageItem(target,field,value){

	$.ajax({
			url				: "/process/admin/page/update_pageItem.asp",
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
					if(field == "step"){
						getPageItemList();
					}
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus)	{alert('error:updatePageItem();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
}

function deletePageItem(){
	var getTarget = function(){
		var result = "";
		$("input[name='list_checkbox_pageNum']").each(function(i){
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
			url				: "/process/admin/page/delete_pageItem.asp",
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
					getPageItemList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus){alert('error:deletePageItem();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
}

function updatePageMeta(target,field,value){
	$.ajax({
			url				: "/process/admin/page/update_pageMeta.asp",
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
					getPageItemList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus)	{alert('error:updatePageMeta();\n\n관리자에게 문의하세요.'+textStatus);}
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
			url				: "/process/admin/page/update_images.asp",
			type			: "POST",
			data			: param,
			dataType	: "xml",
			async			: false,
			success		: function(xml,textStatus){
				
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();

				if(answer == "ok"){
					getPageItemList();
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus){alert('error:updateImages();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});	
}

function uploadImage(){
	if(globalPageItem.idx == ""){
		$(".form_default .upload-name").val("");
		alert("선택된 대상이 없습니다!.");
		return;
	}else{

		var data = new FormData();
		data.append("file", $(".form_default #file").prop("files")[0]);		

		$.ajax({
				url					: "/process/admin/page/upload_image.asp?target="+globalPageItem.idx,
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
						$(".form_default .upload-name").val("");
						getPageItemList();
						console.log("hi");
					}else{
						$(".form_default .upload-name").val("");
						alert("error!\n"+message);
					}				
				},
				error			:	function(xhr,textStatus){parent.alert('error:uploadImage();<br>관리자에게 문의하세요.<br>status:'+textStatus);}
		});

	}


}

/*--------------------------------------------------------------------------------------------------------------------------------
||Init
--------------------------------------------------------------------------------------------------------------------------------*/
function init(){
	setDefaultForm();
	getPageItemList();
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Load
--------------------------------------------------------------------------------------------------------------------------------*/
$(document).ready(function(){
	init();
});
/*------------------------------------------------------------------------------------------------------------------------------*/