/*--------------------------------------------------------------------------------------------------------------------------------
||Detail
--------------------------------------------------------------------------------------------------------------------------------*/
function getPopupDetailData(url,target){
	var result = null;
	if(target != ""){
		$.ajax({
				url				: url,
				type			: "POST",
				data			: {"target" : target},
				dataType	: "xml",
				async			: false,
				success		: function(xml,textStatus){
					
					var answer	= $(xml).find("result").find("answer").text().unescape().trim();
					var message = $(xml).find("result").find("message").text().unescape().trim();
					if(answer == "ok"){
						result = xml;
					}else{
						alert("error!\n"+message);
					}
				},
				error			:	function(xhr,textStatus){alert('error:getPopupDetailData();\n\n관리자에게 문의하세요.'+textStatus);}
				//beforeSend:	function(xhr)						{alert('데이터보내기전');},
				//complete:		function(xhr,textStatus){alert('응답완료.');}
		});			
	}
	return result;
}

function getPopupDetail(target){

	//console.log("getPopupDetail('"+ target +"')");

	var xml													= getPopupDetailData("/process/admin/popup/detail_popup.asp",target);
	var preview											= "";

	detail.seq											= "";
	detail.popup_no									= "";
	detail.name											= "";
	detail.summary									= "";
	detail.contents									= "";
	detail.view_depth								= "";
	detail.view_device							= "";
	detail.exposed_time							= "";
	detail.start_date								= "";
	detail.end_date									= "";
	detail.use_yn										= "";
	detail.order_num								= "";
	detail.state										= "";
	detail.register_date						= "";
	detail.modified_date						= "";
	detail.thumbnail								= "";
	detail.stateStr									= "";
	detail.pc_size									= "";
	detail.pc_position							= "";
	detail.mo_size									= "";
	detail.mo_position							= "";

	detail.pc_size_arr							= ["",""];
	detail.pc_position_arr					= ["",""];
	detail.mo_size_arr							= ["",""];
	detail.mo_position_arr					= ["",""];

	detail.pc_size_width						= detail.pc_size_arr[0].trim();
	detail.pc_size_height						= detail.pc_size_arr[1].trim();
	detail.pc_position_top					= detail.pc_position_arr[0].trim();
	detail.pc_position_left					= detail.pc_position_arr[1].trim();
	detail.mo_size_width						= detail.mo_size_arr[0].trim();
	detail.mo_size_height						= detail.mo_size_arr[1].trim();
	detail.mo_position_top					= detail.mo_position_arr[0].trim();
	detail.mo_position_left					= detail.mo_position_arr[1].trim();

	$(".filebox").hide();
	$(".form_default .thumbnail").html("");
	$(".view_default .preview").html("");
	$("#view_popup_no").html("");
	$("#form_name").val("");
	$("#form_summary").val("");
	$("#form_view_device").val("");
	$("#form_time").val("");
	$("#form_start_date").val("");
	$("#form_end_date").val("");
	$("#form_pc_width").val("");
	$("#form_pc_height").val("");
	$("#form_pc_top").val("");
	$("#form_pc_left").val("");
	$("#form_mo_width").val("");
	$("#form_mo_height").val("");
	$("#form_mo_top").val("");
	$("#form_mo_left").val("");

	if(xml == null){
		detail.clear();
	}else{

		if(xml.getElementsByTagName("seq").length == 0){
			return;
		}

		detail.seq											= xml.getElementsByTagName("seq")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.popup_no									= xml.getElementsByTagName("popup_no")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.name											= xml.getElementsByTagName("name")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.summary									= xml.getElementsByTagName("summary")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.contents									= xml.getElementsByTagName("contents")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.view_depth								= xml.getElementsByTagName("view_depth")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.view_device							= xml.getElementsByTagName("view_device")[0].childNodes[0].nodeValue.unescape().replace('','').trim();

		detail.pc_size									= xml.getElementsByTagName("pc_size")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.pc_position							= xml.getElementsByTagName("pc_position")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.mo_size									= xml.getElementsByTagName("mo_size")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.mo_position							= xml.getElementsByTagName("mo_position")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.exposed_time							= xml.getElementsByTagName("exposed_time")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.start_date								= xml.getElementsByTagName("start_date")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.end_date									= xml.getElementsByTagName("end_date")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.use_yn										= xml.getElementsByTagName("use_yn")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.order_num								= xml.getElementsByTagName("order_num")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.state										= xml.getElementsByTagName("state")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.register_date						= xml.getElementsByTagName("register_date")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.modified_date						= xml.getElementsByTagName("modified_date")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.thumbnail								= xml.getElementsByTagName("thumbnail")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.stateStr									= xml.getElementsByTagName("stateStr")[0].childNodes[0].nodeValue.unescape().replace('','').trim();

		detail.pc_size_arr							= (detail.pc_size			+"*").split("*");
		detail.pc_position_arr					= (detail.pc_position +"*").split("*");
		detail.mo_size_arr							= (detail.mo_size			+"*").split("*");
		detail.mo_position_arr					= (detail.mo_position +"*").split("*");
		detail.pc_size_width						= detail.pc_size_arr[0].trim();
		detail.pc_size_height						= detail.pc_size_arr[1].trim();
		detail.pc_position_top					= detail.pc_position_arr[0].trim();
		detail.pc_position_left					= detail.pc_position_arr[1].trim();
		detail.mo_size_width						= detail.mo_size_arr[0].trim();
		detail.mo_size_height						= detail.mo_size_arr[1].trim();
		detail.mo_position_top					= detail.mo_position_arr[0].trim();
		detail.mo_position_left					= detail.mo_position_arr[1].trim();

		$(".filebox").show();

		$("#view_popup_no").html("&nbsp;&nbsp;&nbsp;"+detail.popup_no);
		$("#form_name").val(detail.name);
		$("#form_summary").val(detail.summary);
		$("#form_view_device").val(detail.view_device);
		$("#form_time").val(detail.exposed_time);
		$("#form_start_date").val(detail.start_date);
		$("#form_end_date").val(detail.end_date);
		$("#form_pc_width").val(detail.pc_size_width);
		$("#form_pc_height").val(detail.pc_size_height);
		$("#form_pc_top").val(detail.pc_position_top);
		$("#form_pc_left").val(detail.pc_position_left);
		$("#form_mo_width").val(detail.mo_size_width);
		$("#form_mo_height").val(detail.mo_size_height);
		$("#form_mo_top").val(detail.mo_position_top);
		$("#form_mo_left").val(detail.mo_position_left);

		if(detail.thumbnail != ""){
			$(".form_default .thumbnail").html("<img src='"+ detail.thumbnail +"'>");
			$(".view_default .preview").html("<img src='"+ detail.thumbnail +"'>");
		}

	}

}
/*-------------------------------------------------------------------------------------------------------------------------------*/