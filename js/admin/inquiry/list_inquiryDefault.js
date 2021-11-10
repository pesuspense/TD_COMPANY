/*--------------------------------------------------------------------------------------------------------------------------------
||List
--------------------------------------------------------------------------------------------------------------------------------*/
function getInquiryDefaultListData(param,url){
	var result = null;
	$.ajax({
			url				: url,
			type			: "POST",
			data			: param,
			dataType	: "xml",
			async			: false,
			success		: function(xml,textStatus){
				
				var answer	= $(xml).find("result").find("answer").text().unescape().trim();
				var message = $(xml).find("result").find("message").text().unescape().trim();
				if(answer == "ok"){
					result = xml
				}else{
					alert("error!\n"+message);
				}
			},
			error			:	function(xhr,textStatus)	{alert('error:getInquiryDefaultListData();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
	return result;
}

function getInquiryDefaultList(){

	var xml						= getInquiryDefaultListData(param,"/process/admin/inquiry/list_inquiryDefault.asp");
	var check					= false;
	var result				= "";
	var listId				= "list_inquiryDefault";
	var pageId				= "page_inquiryDefault";
	var checkName			= "list_checkbox_inquiryNum";

	var setStyle			= function(target){
		globalInquiryDefault.idx = target;
		getInquiryDefaultDetail(target);
		$(xml).find("result").find("list").each(function(i){
			var str				= "";
			var idx				= $("idx",this).text().unescape().trim();
			if(target == idx){
					str +="document.getElementById('"+ listId +"_tr"+ idx +"').style.background = 'yellow';";
			}else{
				if($("#"+listId +"_tr"+ idx).attr("num") % 2 == 0){
					str +="document.getElementById('"+ listId +"_tr"+ idx +"').style.background = '#f0f0f0';";
				}else{
					str +="document.getElementById('"+ listId +"_tr"+ idx +"').style.background = 'white';";
				}
			}
			eval(str);
		});
	};

	var setEvent			= function(){
		$(xml).find("result").find("list").each(function(i){
			var str				= "";
			var idx				= $("idx",this).text().unescape().trim();
			str					 += "document.getElementById('"+ listId +"_tr"+ idx +"').onclick= function(){";
			str					 += "	setTimeout(function(){";
			str					 += "		setStyle('"+ idx +"');";
			str					 += "	},0);";
			str					 += "};";
			eval(str);
		});
	};

	//페이지 설정
	var setPage			= function(){
		var result			= "";
		var pageOn			= "class='on'"
		var pageFunction= "javascript:search('search_page','@page')";
		var recordCount = xml.getElementsByTagName("recordCount")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		var pageCount		= xml.getElementsByTagName("pageCount")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		var pageStart		= xml.getElementsByTagName("pageStart")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		var pageEnd			= xml.getElementsByTagName("pageEnd")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		var pageFirst		= xml.getElementsByTagName("pageFirst")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		var pageLast		= xml.getElementsByTagName("pageLast")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		var pageBefore	= xml.getElementsByTagName("pageBefore")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		var pageAfter		= xml.getElementsByTagName("pageAfter")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		var numStart		= xml.getElementsByTagName("numStart")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
		var numEnd			= xml.getElementsByTagName("numEnd")[0].childNodes[0].nodeValue.unescape().replace('','').trim();
			
		if(pageFirst	!= "")	result += "<li><a href="+ pageFunction.replace("@page", pageFirst)	+">&lt;&lt;</a></li>";
		if(pageBefore != "")	result += "<li><a href="+ pageFunction.replace("@page", pageBefore) +">&lt;</a></li>";

		if(pageCount > 1){
			if(typeof param.page == "undefined"){
				param.page = "1";
			}
			for (var i = pageStart; i <= pageEnd ; i++){
				pageOn = (param.page == i)? "class='on'" : "";
				result += "<li "+ pageOn +"><a href="+ pageFunction.replace("@page", i) +">"+ i +"</a></li>";
			}
		}

		if(pageAfter	!= "")	result += "<li><a href="+ pageFunction.replace("@page", pageAfter)	+">&gt;</a></li>";
		if(pageLast		!= "")	result += "<li><a href="+ pageFunction.replace("@page", pageLast)		+">&gt;&gt;</a></li>";
		
		if(result != ""){
			result = "<ul>"+ result +"</ul>";
		}else{
			if(recordCount == "0"){
				result = "&nbsp;";
			}else{
				result = "<ul><li class='on'><a href="+ pageFunction.replace("@page","1") +">1</li></ul>";
			}
		}
		$("#"+ pageId).html(result);
	};

	//기본값 설정
	globalInquiryDefault.count = $(xml).find("result").find("list").length;

	//리스트 설정
	$(xml).find("result").find("list").each(function(i){
		var no									= "";
		var num									= $("num",this).text().unescape().trim();
		var idx									= $("idx",this).text().unescape().trim();
		var type								= $("type",this).text().unescape().trim();
		var division						= $("division",this).text().unescape().trim();
		var name								= $("name",this).text().unescape().trim();
		var phone								= $("phone",this).text().unescape().trim();
		var email								= $("email",this).text().unescape().trim();
		var address							= $("address",this).text().unescape().trim();
		var title								= $("title",this).text().unescape().trim();
		var state								= $("state",this).text().unescape().trim();
		var regdate							= $("regdate",this).text().unescape().trim();
				regdate							= regdate.replaceAll('-','.').right(regdate.length-2);
		var listCheck						= "<input type='checkbox' name='"+ checkName +"' value='"+ idx +"'/>";
		var listClass						= "";
		var listNum							= num;

		switch(state){
			case "대기": listClass = "stateW"; break;
			case "진행": listClass = "stateR"; break;
			case "완료": listClass = "stateC"; break;
		}

		result +="<tr id='"+ listId +"_tr"+ idx +"' num='"	+ num +"'>";
		result +="	<td class='list_item_1 "+ listClass +"'>"+ listCheck		+"</td>";
		result +="	<td class='list_item_2 "+ listClass +"'>"+ listNum			+"</td>";
		result +="	<td class='list_item_3 "+ listClass +"'>"+ type					+"</td>";
		result +="	<td class='list_item_4 "+ listClass +"'>"+ name					+"</td>";
		result +="	<td class='list_item_5 "+ listClass +"'>"+ phone				+"</td>";
		result +="	<td class='list_item_6 "+ listClass +"'>"+ email				+"</td>";
		result +="	<td class='list_item_7 "+ listClass +"'>"+ regdate			+"</td>";
		result +="	<td class='list_item_8 "+ listClass +"'>"+ state				+"</td>";
		result +="</tr>";

		globalInquiryDefault.first	= (i == 0)? idx : globalInquiryDefault.first;

		if(globalInquiryDefault.idx == ""){
			if(i == 0){
				globalInquiryDefault.idx	= idx;
				check				= true;
			}
		}else{
			if(globalInquiryDefault.idx == idx){
				check				= true;
			}
		}
	});

	$("#"+listId).html("<table>"+ result +"</table>");

	setEvent();
	setPage();

	if(globalInquiryDefault.count == 0){
		getInquiryDefaultDetail("");
	}else{
		if(check){
			setStyle(globalInquiryDefault.idx);
		}else{
			setStyle(globalInquiryDefault.first);
		}
	}

}



/*-------------------------------------------------------------------------------------------------------------------------------*/