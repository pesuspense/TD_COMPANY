/*--------------------------------------------------------------------------------------------------------------------------------
||Detail
--------------------------------------------------------------------------------------------------------------------------------*/
function getInquiryDefaultDetailData(url,target){
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
				error			:	function(xhr,textStatus){alert('error:getInquiryDefaultDetailData();\n\n관리자에게 문의하세요.'+textStatus);}
				//beforeSend:	function(xhr)						{alert('데이터보내기전');},
				//complete:		function(xhr,textStatus){alert('응답완료.');}
		});			
	}
	return result;
}

function getInquiryDefaultDetail(target){
	var xml										= getInquiryDefaultDetailData("/process/admin/inquiry/detail_inquiryDefault.asp",target);
	var strButton							= "";

	detail.idx								= "";
	detail.inquiryNum					= "";
	detail.type								= "";
	detail.division						= "";
	detail.name								= "";
	detail.phone							= "";
	detail.email							= "";
	detail.address						= "";
	detail.title							= "";
	detail.reqContents				= "";
	detail.resContents				= "";
	detail.state							= "";
	detail.regdate						= "";

	$(".button_wait").hide();
	$(".button_run").hide();
	$(".button_complet").hide();

	if(xml == null){
		detail.clear();
	}else{
		detail.idx								= xml.getElementsByTagName("idx")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.inquiryNum					= xml.getElementsByTagName("inquiryNum")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.type								= xml.getElementsByTagName("type")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.division						= xml.getElementsByTagName("division")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.name								= xml.getElementsByTagName("name")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.phone							= xml.getElementsByTagName("phone")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.email							= xml.getElementsByTagName("email")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.address						= xml.getElementsByTagName("address")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.title							= xml.getElementsByTagName("title")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.reqContents				= xml.getElementsByTagName("reqContents")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.resContents				= xml.getElementsByTagName("resContents")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.state							= xml.getElementsByTagName("state")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.regdate						= xml.getElementsByTagName("regdate")[0].firstChild.nodeValue.unescape().replace('','').trim();

		switch (detail.state){
		case "대기": strButton += "<li><input type='button' class='state_button button_run'	value='진행' onclick=updateInquiryDefault('"+ detail.idx +"','state','진행');> <input type='button' class='state_button button_complet' value='완료' onclick=updateInquiryDefault('"+ detail.idx +"','state','완료');></li>";		break;
		case "진행": strButton += "<li><input type='button' class='state_button button_wait' value='대기' onclick=updateInquiryDefault('"+ detail.idx +"','state','대기');> <input type='button' class='state_button button_complet' value='완료' onclick=updateInquiryDefault('"+ detail.idx +"','state','완료');></li>";		break;
		case "완료": strButton += "<li><input type='button' class='state_button button_wait' value='대기' onclick=updateInquiryDefault('"+ detail.idx +"','state','대기');> <input type='button' class='state_button button_run' value='진행' onclick=updateInquiryDefault('"+ detail.idx +"','state','진행');> </li>";			break;
		}
	}
	$("#view_inquiryNum"						).html("&nbsp;" +detail.inquiryNum+"&nbsp;");
	$("#view_type"									).html("&nbsp;" +detail.type+"&nbsp;");
	$("#view_name"									).html("&nbsp;" +detail.name+"&nbsp;");
	$("#view_phone"									).html("&nbsp;" +detail.phone+"&nbsp;");
	$("#view_email"									).html("&nbsp;" +detail.email+"&nbsp;");
	$("#view_title"									).html("&nbsp;" +detail.title+"&nbsp;");
	$("#view_regdate"								).html("&nbsp;" +detail.regdate+"&nbsp;");
	$("#view_state"									).html("&nbsp;" +detail.state+"&nbsp;");

	$("#form_inquiry_reqContents"		).val(detail.reqContents);
	$("#form_inquiry_resContents"		).val(detail.resContents);

	$("#form_state"									).html(strButton);

}
/*-------------------------------------------------------------------------------------------------------------------------------*/