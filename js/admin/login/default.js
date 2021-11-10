/*--------------------------------------------------------------------------------------------------------------------------------
||Define
--------------------------------------------------------------------------------------------------------------------------------*/
var param		= {
	id			: "",
	pw			: ""
};

/*--------------------------------------------------------------------------------------------------------------------------------
||Form
--------------------------------------------------------------------------------------------------------------------------------*/
function init(){
	if(getCookie("save_check") == "o"){
		$("#id").val(getCookie("save_id"));
		$("#save_check").attr("checked",true);
	}

	if((getCookie("save_check") == "o") && (getCookie("save_id") != "")){
		setTimeout(function(){document.getElementById("pw").focus();},700);
	}else{
		setTimeout(function(){document.getElementById("id").focus();},700);
	}
}

function setFormCheck(target){
	if(target.checked){
		setCookie("save_check","o");
	}else{
		setCookie("save_check","");
	}
}


function setMessage(message){
	$("#box_message").html("");
	$("#box_message").html("<span id='messages'>"+ message +"</span>");
	$("#messages").hide();
	$("#messages").show();
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Process
--------------------------------------------------------------------------------------------------------------------------------*/
function login(){

	if($("#id").val() == ""){
		setMessage("아이디를 입력하세요!");
		$("#id").focus();
		return;
	}else{
		if(getCookie("save_check") == "o"){
			setCookie("save_id",$("#id").val());
		}
	}

	if($("#pw").val() == ""){
		setMessage("비밀번호를 입력하세요!");
		$("#pw").focus();
		return;
	}

	$.ajax({
			url				: "/process/admin/login/default.asp",
			type			: "POST",
			data			: {
										"id" : $("#id").val().trim(),
										"pw" : $("#pw").val().trim()
									},
			dataType	: "xml",
			async			: true,
			success		: function(xml,textStatus){
				
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();
				if(answer == "ok"){
					location.href = "/admin/home/";
				}else{
					setMessage(message);
				}
			},
			error			:	function(xhr,textStatus){alert('error:login();\n\n관리자에게 문의하세요.'+textStatus);}
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