/*--------------------------------------------------------------------------------------------------------------------------------
||List
--------------------------------------------------------------------------------------------------------------------------------*/
function getPageItemListData(param,url){
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
			error			:	function(xhr,textStatus){alert('error:getPageItemListData();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			
	return result;
}

function getPageItemList(){
	var xml						= getPageItemListData({"target": ""},"/process/admin/page/list_pageItem.asp");
	var check					= false;
	var result				= "";
	var listId				= "list_pageItem";
	var checkName			= "list_checkbox_pageNum";

	var setFocus			= function(target){
		$("input[name='"+ checkName +"']").each(function(i){
			if($(this).val() == target){
				if(globalPageItem.load != 0){
					$("#"+listId).animate({scrollTop: $(this).position().top -100}, 500);
				}
				globalPageItem.load++;
			}
		});
	};

	var setStyle			= function(target){
		globalPageItem.idx = target;
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
			str					 += "		getPageMetaDetail('"+ idx +"');";
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
					$("input[name='"+ checkName +"']").each(function(i) {
						value += ((value == "")? "" : ",") + $(this).val();
					});
					updatePageItem("-","step",value);
        }
			});
		},500);
	};

	//기본값 설정
	globalPageItem.count			= $(xml).find("result").find("list").length;

	//리스트 설정
	$(xml).find("result").find("list").each(function(i){

		var num										= $("num",this).text().unescape().trim();
		var idx										=	$("idx",this).text().unescape().trim();
		var pageNum								=	$("pageNum",this).text().unescape().trim();
		var pageNumParent					=	$("pageNumParent",this).text().unescape().trim();
		var entity								=	$("entity",this).text().unescape().trim();
		var type									=	$("type",this).text().unescape().trim();
		var division							=	$("division",this).text().unescape().trim();
		var title									=	$("title",this).text().unescape().trim();
		var url										=	$("url",this).text().unescape().trim();
		var location							=	$("location",this).text().unescape().trim();
		var step									=	$("step",this).text().unescape().trim();
		var state									=	$("state",this).text().unescape().trim();
		var regdate								=	$("regdate",this).text().unescape().trim();
		var parentTitle						=	$("parentTitle",this).text().unescape().trim();

				globalPageItem.first	= (i == 0)? idx : globalPageItem.first;

		var list_checkbox					= "<input type='checkbox' name='"+ checkName +"' value='"+ idx +"'/>";
		var list_num							= num;
		var list_pageNum					= pageNum;

		var list_navigation				= "";
				list_navigation			 += (parentTitle == "")? "" : "<span style='dispaly:blcok;padding:0 0 0 5px;'>"+parentTitle.replaceAll(","," > ") + " > </span>";
				list_navigation			 += "<input type='text' value='"+ title			+"' title='Navigation'	placeholder='Navigation'	onblur=updatePageItem('"+ idx +"','title',this.value);				style='width:150px;padding:0 0 0 5px;border:0;border-right:0px solid #cccccc;background:transparent;'/>";

		var list_directory				= "<input type='text' value='"+ location	+"' title='Directory'		placeholder='Directory'		onblur=updatePageItem('"+ idx +"','location',this.value);		style='width:100%;padding:0 0 0 5px;border:0;border-right:0px solid #cccccc;background:transparent;'/>";
		var list_function					= ((pageNumParent == "")? "<a href=javascript:insertPageItem('"+ pageNum +"');>추가+</a>" : "");



		if(globalPageItem.idx == ""){
			if(i == 0){
				globalPageItem.idx	= idx;
				check								= true;
			}
		}else{
			if(globalPageItem.idx == idx){
				check								= true;
			}
		}

		result +="<li>";
		result +="	<table>";
		result +="		<tr id='"+ listId +"_tr"+ idx +"' num='"+ num +"'>";
		result +="			<td class='list_item_1'>"+ list_checkbox		+"</td>";
		result +="			<td class='list_item_2'>"+ list_num					+"</td>";
		result +="			<td class='list_item_3'>"+ list_pageNum			+"</td>";
		result +="			<td class='list_item_4'>"+ list_navigation	+"</td>";
		result +="			<td class='list_item_5'>"+ list_directory		+"</td>";
		result +="			<td class='list_item_6'>"+ list_function		+"</td>";
		result +="		</tr>";
		result +="	</table>";
		result +="</li>";

	});

	if(result != ""){
		result = "<ul class='list_sort'>"+ result +"</ul>";
	}


	$("#"+listId).html(result);
	setEvent();
	setSort();

	if(globalPageItem.count == 0){
		getPageMetaDetail("");
	}else{
		if(check){
			setStyle(globalPageItem.idx);
			setFocus(globalPageItem.idx);
			getPageMetaDetail(globalPageItem.idx);
		}else{
			setStyle(globalPageItem.first);
			setFocus(globalPageItem.first);
			getPageMetaDetail(globalPageItem.first);
		}
	}
}

/*-------------------------------------------------------------------------------------------------------------------------------*/