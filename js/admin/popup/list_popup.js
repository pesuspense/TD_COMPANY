/*--------------------------------------------------------------------------------------------------------------------------------
||List
--------------------------------------------------------------------------------------------------------------------------------*/
function getPopupListData(param,url){
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
			error				:	function(xhr,textStatus)	{alert('error:getPopupListData();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)							{alert('데이터보내기전');},
			//complete	:	function(xhr,textStatus)	{alert('응답완료.');}
	});			
	return result;
}

function getPopupList(){
	var xml						= getPopupListData(param,"/process/admin/popup/list_popup.asp");
	var check					= false;
	var result				= "";
	var dResult				= "";
	var sResult				= "";
	var listId				= "list_popup";
	var pageId				= "list_page";
	var checkName			= "list_checkbox_popupNum";

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

	var setStyle			= function(target){
		var checkTarget = false;

			$(xml).find("result").find("list").each(function(i){
				var seq = $("seq",this).text().unescape().trim();

				if(target == seq){
					checkTarget = true;
				}
			});

			if(checkTarget){
				getPopupDetail(target);
				$(xml).find("result").find("list").each(function(i){
					var str				= "";
					var seq				= $("seq",this).text().unescape().trim();
					if(target == seq){
							str +="document.getElementById('"+ listId +"_tr"+ seq +"').style.background = 'yellow';";
					}else{
						if($("#"+listId +"_tr"+ seq).attr("num") % 2 == 0){
							str +="document.getElementById('"+ listId +"_tr"+ seq +"').style.background = '#f0f0f0';";
						}else{
							str +="document.getElementById('"+ listId +"_tr"+ seq +"').style.background = 'white';";
						}
					}
					try{
						eval(str);	
					}catch(e){
						//console.log(str);
					}
					
				});
			}

	};

	var setEvent			= function(){

		$(xml).find("result").find("list").each(function(i){
			var str				= "";
			var seq				= $("seq",this).text().unescape().trim();
			str					 += "document.getElementById('"+ listId +"_tr"+ seq +"').onclick= function(){";
			str					 += "	setTimeout(function(){";
			str					 += "		setStyle('"+ seq +"');";
			str					 += "	},0);";
			str					 += "};";
			eval(str);
		});
	};

	var setSort				= function(){
		setTimeout(function(){
			$("#"+ listId +" .list_sort").sortable({
        update:function(){
					var maxNum	= "0";
					var target	= "";
					$("input[name='"+ checkName +"']").each(function(i) {
						maxNum = (maxNum < $(this).attr("orderNum"))? $(this).attr("orderNum") : maxNum;
						target += ((target == "")? "" : ",") + $(this).val();
					});

					console.log(maxNum);
					console.log(target);
					updatePopupOrderNum(maxNum,target);
        }
			});
		},500);
	};

	//페이지 설정
	var setPage			= function(){
		var result			= "";
		var pageOn			= "class='on'"
		var pageFunction= "javascript:search('search_page','@page')";
		
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
	globalPopup.count			= $(xml).find("result").find("list").length;

	//리스트 설정
	var listNum							= recordCount -((param.page - 1) * param.pageSize); 
	$(xml).find("result").find("list").each(function(i){
		var no									= "";
		var num									= $("num",this).text().unescape().trim();
		var seq									= $("seq",this).text().unescape().trim();
		var popup_no						= $("popup_no",this).text().unescape().trim();
		var name								= $("name",this).text().unescape().trim();
		var summary							= $("summary",this).text().unescape().trim();
		var contents						= $("contents",this).text().unescape().trim();
		var view_depth					= $("view_depth",this).text().unescape().trim();
		var view_device					= $("view_device",this).text().unescape().trim();
		var pc_size							= $("pc_size",this).text().unescape().trim();
		var pc_position					= $("pc_position",this).text().unescape().trim();
		var mo_size							= $("mo_size",this).text().unescape().trim();
		var mo_position					= $("mo_position",this).text().unescape().trim();
		var exposed_time				= $("exposed_time",this).text().unescape().trim();
		var start_date					= $("start_date",this).text().unescape().trim();
		var end_date						= $("end_date",this).text().unescape().trim();
		var use_yn							= $("use_yn",this).text().unescape().trim();
		var order_num						= $("order_num",this).text().unescape().trim();
		var state								= $("state",this).text().unescape().trim();
		var register_date				= $("register_date",this).text().unescape().trim();
		var modified_date				= $("modified_date",this).text().unescape().trim();
		var thumbnail						= $("thumbnail",this).text().unescape().trim();
		var stateStr						= $("stateStr",this).text().unescape().trim();

		var listCheck						= "<input type='checkbox' name='"+ checkName +"' value='"+ seq +"' orderNum='"+ order_num +"' />";
		var listName						= name;
		var listThumbnail				= (thumbnail == "")? "<div class='noImage'>미등록</div>" : "<img class='thumbnail' src='"+ thumbnail +"'/>";
		var listState						= stateStr;
		var listPeriod					= start_date +" ~ "+ end_date;
		var listFunction				= "<a href=javascript:deletePopup('"+ popup_no +"');>삭제</a>";

		result +="<li>";
		result +="	<table>";
		result +="	<tr id='"+ listId +"_tr"+ seq +"' num='"	+ num +"'>";
		result +="		<td class='list_item_1'>"+ listCheck			+"</td>";
		result +="		<td class='list_item_2'>"+ listNum +"</td>";
		result +="		<td class='list_item_3'>";
		result +="			"+ listThumbnail;
		result +="			<div class='information'>";
		result +="			 <span class='name'>"+ listName +"</span>";
		result +="			 <span class='period'>"+ listPeriod +"</span>";
		result +="			 <span class='state'>"+ listState +"</span>";
		result +="			</div>";
		result +="		</td>";
		result +="		<td class='list_item_4'>"+ listFunction		+"</td>";
		result +="	</tr>";
		result +="	</table>";
		result +="</li>";

		listNum--;

		globalPopup.first	= (i == 0)? seq : globalPopup.first;

		if(globalPopup.seq == ""){
			if(i == 0){
				globalPopup.seq	= seq;
				check = true;
			}
		}else{
			if(globalPopup.seq == seq){
				check	 = true;
			}
		}
	});

	$("#"+listId).html("<ul class='list_sort'>"+ result +"</ul>");

	setEvent();
	setPage();

	if(globalPopup.count == 0){
		getPopupDetail("");
	}else{
		if(check){
			setStyle(globalPopup.seq);
		}else{
			setTimeout(function(){
				setStyle(globalPopup.first);
			},100);

		}
	}
	setSort();

}



/*-------------------------------------------------------------------------------------------------------------------------------*/