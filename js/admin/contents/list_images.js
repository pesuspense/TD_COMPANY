/*--------------------------------------------------------------------------------------------------------------------------------
||List
--------------------------------------------------------------------------------------------------------------------------------*/
function getImagesListData(param,url){
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
			error			:	function(xhr,textStatus)	{alert('error:getImagesListData();\n\n관리자에게 문의하세요.'+textStatus);}
			//beforeSend:	function(xhr)						{alert('데이터보내기전');},
			//complete:		function(xhr,textStatus){alert('응답완료.');}
	});			

	return result;

}

function getImagesList(target){
	
	if(target == ""){
		//$("#list_images_og"		).html("");
		$("#list_images_list"		).html("");
		$("#list_images_detail"	).html("");
		$("#list_images_form"		).html("");

		return;
	}

	var xml						= getImagesListData({"target" : target},"/process/admin/contents/list_images.asp");
	var check					= false;
	var resultL				= "";
	var resultD				= "";
	var resultO				= "";
	var resultF				= "";

	var setSort				= function(type){
		setTimeout(function(){
			$("#list_images_"+ type +" .list_sort_"+type).sortable({
        update:function(){
					var value = "";
					$("input[name='step_"+ type +"']").each(function(i) {
						value += ((value == "")? "" : ",") + $(this).val();
					});

					updateImages(type,"step",value);
        }
			});
		},500);
	};

	//리스트 설정
	var noL										= 1;
	var noD										= 1;
	var noO										= 1;

	$(xml).find("result").find("list").each(function(i){

		var num										= i+1;
		var idx										= $("idx",this).text().unescape().trim();
		var contentsNum						= $("contentsNum",this).text().unescape().trim();
		var type									= $("type",this).text().unescape().trim();
		var division							= $("division",this).text().unescape().trim();
		var fileDirectory					= $("fileDirectory",this).text().unescape().trim();
		var fileNameNew						= $("fileNameNew",this).text().unescape().trim();
		var fileNameOld						= $("fileNameOld",this).text().unescape().trim();
		var fileNameView					= $("fileNameView",this).text().unescape().trim();
		var fileSize							= $("fileSize",this).text().unescape().trim();
		var fileCapacity					= $("fileCapacity",this).text().unescape().trim();
		var step									= $("step",this).text().unescape().trim();
		var state									= $("state",this).text().unescape().trim();
		var regdate								= $("regdate",this).text().unescape().trim();
				fileSize							= fileSize.replace("*"," * ");
				fileCapacity					= $.number(fileCapacity / 1024);
				fileCapacity					= fileCapacity + " kb";

		var listForm							= "<input type='hidden' name='step_"+ type +"' value='"+ idx +"' />";

		var listImg								= "<img src='"+ fileDirectory +"/"+ fileNameNew +"'>";

		var listArticle						= "";
				listArticle					 += "구분: "		+ type														+ "<br/>";	
				listArticle					 += "용량: "		+	fileCapacity										+ "<br/>";	
				listArticle					 += "크기: "		+ fileSize												+ "px<br/>";	
				listArticle					 += "경로: "		+ fileDirectory +""+ fileNameNew	+ "";	

		var listFunction					= "<a href=javascript:checkUpdateImages('"+ idx +"','state','d');>삭제</a>";


		if			(type == "list"		){
			resultL +="<li>";
			resultL +="	<table>";
			resultL +="	<tr>";
			resultL +="		<td class='imgItem1'>"+ noL + listForm+"</td>";
			resultL +="		<td class='imgItem2'>"+ listImg				+"</td>";
			resultL +="		<td class='imgItem3'>"+ listArticle		+"</td>";
			resultL +="		<td class='imgItem4'>"+ listFunction	+"</td>";
			resultL +="	</tr>";
			resultL +="	</table>";
			resultL +="</li>";
			noL++;
		}else if(type == "detail"	){
			resultD +="<li>";
			resultD +="	<table>";
			resultD +="	<tr id='list_images_detail_"+ idx +"' num='"	+ num +"'>";
			resultD +="		<td class='imgItem1'>"+ noD	+ listForm+"</td>";
			resultD +="		<td class='imgItem2'>"+ listImg				+"</td>";
			resultD +="		<td class='imgItem3'>"+ listArticle		+"</td>";
			resultD +="		<td class='imgItem4'>"+ listFunction	+"</td>";
			resultD +="	</tr>";
			resultD +="	</table>";
			resultD +="</li>";

			resultF +="<li>";
			resultF +="	<table>";
			resultF +="	<tr id='list_images_detail_"+ idx +"' num='"	+ num +"'>";
			resultF +="		<td class='imgItem1'>"+ noD	+ listForm+"</td>";
			resultF +="		<td class='imgItem2'>"+ listImg				+"</td>";
			resultF +="		<td class='imgItem3'>"+ listArticle		+"</td>";
			resultF +="		<td class='imgItem4'>";
			resultF +="		<a href=javascript:insertContentsImages('"+ fileDirectory +""+ fileNameNew +"');>본문<br>삽입</a><br/><br/>";

			resultF +="		</td>";
			resultF +="	</tr>";
			resultF +="	</table>";
			resultF +="</li>";

			noD++;

		}else if(type == "og"			){
			resultO +="<li>";
			resultO +="	<table>";
			resultO +="	<tr id='list_images_detail_"+ idx +"' num='"	+ num +"'>";
			resultO +="		<td class='imgItem1'>"+ noO	+ listForm+"</td>";
			resultO +="		<td class='imgItem2'>"+ listImg				+"</td>";
			resultO +="		<td class='imgItem3'>"+ listArticle		+"</td>";
			resultO +="		<td class='imgItem4'>"+ listFunction	+"</td>";
			resultO +="	</tr>";
			resultO +="	</table>";
			resultO +="</li>";
			noO++;
		}

	});

	if(resultL != ""){resultL = "<ul class='list_sort_list'			>"+ resultL +"</ul>";}
	if(resultD != ""){resultD = "<ul class='list_sort_detail'		>"+ resultD +"</ul>";}
	if(resultO != ""){resultO = "<ul class='list_sort_og'				>"+ resultO +"</ul>";}

	$("#list_images_list"			).html(resultL);
	$("#list_images_detail"		).html(resultD);
	//$("#list_images_og"			).html(resultO);
	$("#list_images_form"			).html(resultF);

	setSort("og");
	setSort("list");
	setSort("detail");



}



/*-------------------------------------------------------------------------------------------------------------------------------*/