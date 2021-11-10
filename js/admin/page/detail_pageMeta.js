/*--------------------------------------------------------------------------------------------------------------------------------
||Detail
--------------------------------------------------------------------------------------------------------------------------------*/
function getPageMetaDetailData(url,target){
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
				error			:	function(xhr,textStatus){alert('error:getPageMetaDetailData();\n\n관리자에게 문의하세요.'+textStatus);}
				//beforeSend:	function(xhr)						{alert('데이터보내기전');},
				//complete:		function(xhr,textStatus){alert('응답완료.');}
		});			
	}
	return result;
}

function getPageMetaDetail(target){
	var xml										= getPageMetaDetailData("/process/admin/page/detail_meta.asp",target);
	detail.idx								= "";
	detail.pageNum						= "";
	detail.meta_title					= "";
	detail.meta_description		= "";
	detail.meta_keyword				= "";
	detail.meta_author				= "";
	detail.meta_robots				= "";
	if(xml == null){
		detail.clear();
	}else{
		detail.idx								= xml.getElementsByTagName("idx")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.pageNum						= xml.getElementsByTagName("pageNum")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.meta_title					= xml.getElementsByTagName("title")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.meta_description		= xml.getElementsByTagName("description")[0].firstChild.nodeValue.unescape().replace('','').trim();
		detail.meta_keyword				= xml.getElementsByTagName("keyword")[0].firstChild.nodeValue.unescape().replace('','').trim();
	}

	$("#view_pageNum"						).html("&nbsp;" +detail.pageNum+"&nbsp;");
	$("#form_meta_title"				).val(detail.meta_title);
	$("#form_meta_description"	).val(detail.meta_description);
	$("#form_meta_keyword"			).val(detail.meta_keyword);

	getImagesList(detail.pageNum);

}
/*-------------------------------------------------------------------------------------------------------------------------------*/