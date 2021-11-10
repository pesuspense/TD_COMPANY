/*--------------------------------------------------------------------------------------------------------------------------------
||List
--------------------------------------------------------------------------------------------------------------------------------*/
function getContentsListData(param,url){
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
			error			:	function(xhr,textStatus)	{alert('error:getContentsListData();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
	return result;
}

function getContentsList(){
	var xml						= getContentsListData(param,"/process/admin/contents/list_contents.asp");
	var check					= false;
	var result				= "";
	var dResult				= "";
	var sResult				= "";
	var listId				= "list_contents";
	var pageId				= "page_contents";
	var checkName			= "list_checkbox_contentsNum";
	var topNo					= 1;

	var setStyle			= function(target){
		globalContents.idx = target;
		getContentsDetail(target);
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

	var setSort				= function(){
		setTimeout(function(){
			$("#"+ listId +" .list_sort").sortable({
        update:function(){
					var value = "";
					$("input[name='step_contents']").each(function(i) {
						value += ((value == "")? "" : ",") + $(this).val();
					});

					updateContents("-","step",value);
        }
			});
		},500);
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
	globalContents.count			= $(xml).find("result").find("list").length;

	//리스트 설정
	$(xml).find("result").find("list").each(function(i){
		var no									= "";

		var num									= $("num",this).text().unescape().trim();
		var idx									= $("idx",this).text().unescape().trim();
		var contentsNum					= $("contentsNum",this).text().unescape().trim();
		var memberNum						= $("memberNum",this).text().unescape().trim();
		var type								= $("type",this).text().unescape().trim();
		var division						= $("division",this).text().unescape().trim();
		var secruit							= $("secruit",this).text().unescape().trim();
		var title								= $("title",this).text().unescape().trim();
		var keyword							= $("keyword",this).text().unescape().trim();
		var hit									= $("hit",this).text().unescape().trim();
		var step								= $("step",this).text().unescape().trim();
		var state								= $("state",this).text().unescape().trim();
		var regdate							= $("regdate",this).text().unescape().trim().replace(/-/gi,'.').substr(2,8);
		var thumbnail						= $("thumbnail",this).text().unescape().trim();

		var listCheck						= "<input type='checkbox' name='"+ checkName +"' value='"+ idx +"'/>";

		var listNum							= num;
		//	listNum						 += (division == "top")? "<input type='hidden' name='step_contents' value='"+ idx +"' />" : "";

		var listType						= "";
		switch (type){
		case "news"			: listType = "라이마소식";	break;
		case "reference": listType = "자료실";			break;
		}

		var listThumbnail				= (thumbnail == "")? "<div style='padding:28px 0 28px 0;width:70px;background:white;border:1px solid #cccccc;text-align:center;'>미등록</div>" : "<img src='"+ thumbnail +"'/>";

		var listArticle					= "";
		//	listArticle					 += (division == "")? title : "<b>Top "+ topNo +"</b> | " + title;
				listArticle					 += (division == "")? title : title;

		var listHit							= hit;
		var listState						= state;
		var listDate						= regdate;

		/*
		//no = recordCount - ((param.p_page-1) * param.p_pSize);
		if(division == "top"){
			sResult +="<li>";
			sResult +="	<table>";
			sResult +="	<tr id='"+ listId +"_tr"+ idx +"' num='"	+ num +"'>";
			sResult +="		<td class='item1'>"+ listCheck			+"</td>";
			sResult +="		<td class='item2'>"+ listNum				+"</td>";
			sResult +="		<td class='item3'>"+ listType				+"</td>";
			sResult +="		<td class='item4'>"+ listArticle		+"</td>";
			sResult +="		<td class='item5'>"+ listHit				+"</td>";
			sResult +="		<td class='item6'>"+ listState			+"</td>";
			sResult +="		<td class='item7'>"+ listDate				+"</td>";
			sResult +="	</tr>";
			sResult +="	</table>";
			sResult +="</li>";
		}else{
			dResult +="<li>";
			dResult +="	<table>";
			dResult +="	<tr id='"+ listId +"_tr"+ idx +"' num='"	+ num +"'>";
			dResult +="		<td class='item1'>"+ listCheck			+"</td>";
			dResult +="		<td class='item2'>"+ listNum				+"</td>";
			dResult +="		<td class='item3'>"+ listType				+"</td>";
			dResult +="		<td class='item4'>"+ listArticle		+"</td>";
			dResult +="		<td class='item5'>"+ listHit				+"</td>";
			dResult +="		<td class='item6'>"+ listState			+"</td>";
			dResult +="		<td class='item7'>"+ listDate				+"</td>";
			dResult +="	</tr>";
			dResult +="	</table>";
			dResult +="</li>";
		}
		*/

		dResult +="<li>";
		dResult +="	<table>";
		dResult +="	<tr id='"+ listId +"_tr"+ idx +"' num='"	+ num +"'>";
		dResult +="		<td class='item1'>"+ listCheck			+"</td>";
		dResult +="		<td class='item2'>"+ listNum				+"</td>";
		dResult +="		<td class='item3'>"+ listType				+"</td>";
		dResult +="		<td class='item4'>"+ listArticle		+"</td>";
		dResult +="		<td class='item5'>"+ listHit				+"</td>";
		dResult +="		<td class='item6'>"+ listState			+"</td>";
		dResult +="		<td class='item7'>"+ listDate				+"</td>";
		dResult +="	</tr>";
		dResult +="	</table>";
		dResult +="</li>";

		globalContents.first	= (i == 0)? idx : globalContents.first;

		if(globalContents.idx == ""){
			if(i == 0){
				globalContents.idx	= idx;
				check				= true;
			}
		}else{
			if(globalContents.idx == idx){
				check				= true;
			}
		}

		if(division == "top"){
			++topNo;
		}

	});

	result += "<ul class='list_sort'>"+ sResult +"</ul>";
	result += "<ul>"+ dResult +"</ul>";
	
	$("#"+listId).html(result);

	setEvent();
	setPage();

	if(globalContents.count == 0){
		getContentsDetail("");
	}else{
		if(check){
			setStyle(globalContents.idx);
		}else{
			setStyle(globalContents.first);
		}
	}

	setSort();

}



/*-------------------------------------------------------------------------------------------------------------------------------*/