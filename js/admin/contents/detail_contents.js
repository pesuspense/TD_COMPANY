/*--------------------------------------------------------------------------------------------------------------------------------
||Detail
--------------------------------------------------------------------------------------------------------------------------------*/
function getContentsDetailData(url,target){
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
				error			:	function(xhr,textStatus){alert('error:getContentsDetailData();\n\n관리자에게 문의하세요.'+textStatus);}
				//beforeSend:	function(xhr)						{alert('데이터보내기전');},
				//complete:		function(xhr,textStatus){alert('응답완료.');}
		});			
	}
	return result;
}

function getContentsDetail(target){
	var xml													= getContentsDetailData("/process/admin/contents/detail_contents.asp",target);
	var preview											= "";

	detail.idx											= "";
	detail.memberNum								= "";
	detail.contentsNum							= "";
	detail.type											= "";
	detail.division									= "";
	detail.secruit									= "";
	detail.title										= "";
	detail.contents									= "";
	detail.keyword									= "";
	detail.hit											= "";
	detail.step											= "";
	detail.state										= "";
	detail.regdate									= "";
	detail.imagesType								= "";

	$("#button_publish").hide();
	$("#button_unPublish").hide();

	if(xml == null){
		detail.clear();
	}else{
		detail.idx										= xml.getElementsByTagName("idx")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.memberNum							= xml.getElementsByTagName("memberNum")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.contentsNum						= xml.getElementsByTagName("contentsNum")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.type										= xml.getElementsByTagName("type")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.division								= xml.getElementsByTagName("division")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.secruit								= xml.getElementsByTagName("secruit")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.title									= xml.getElementsByTagName("title")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.contents								= xml.getElementsByTagName("contents")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.keyword								= xml.getElementsByTagName("keyword")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.hit										= xml.getElementsByTagName("hit")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.step										= xml.getElementsByTagName("step")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.state									= xml.getElementsByTagName("state")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		detail.regdate								= xml.getElementsByTagName("regdate")[0].childNodes[0].nodeValue.unescape().replace('','').trim();

		globalContents.idx						= detail.idx;

		preview											 += "<p style='font-size:11px;line-height:16px;color:#777777;'>"
		preview											 += "제&nbsp;&nbsp;&nbsp;목: " + detail.title				+ "<br/>";
		preview											 += "작성일: " + detail.regdate		+	"<br/><br/>";
		preview											 += "</p>"
		preview											 += "<p style='line-height:16px;'>"+ detail.contents.replace(/\n/gi,"<br/>") +"</p>";

		switch (detail.state){
		case "대기": $("#button_publish").show();		break;
		case "게시": $("#button_unPublish").show();	break;		
		}

	}

	$("#form_division"			).val(detail.division);
	$("#form_title"					).val(detail.title);
	$("#form_contents"			).val(detail.contents);
	$("#form_keyword"				).val(detail.keyword);

	$("#preview_contents"		).html(preview);
	getImagesList(detail.contentsNum);

}
/*-------------------------------------------------------------------------------------------------------------------------------*/