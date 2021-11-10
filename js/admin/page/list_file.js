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
		$("#list_images").html("");
		return;
	}

	var xml						= getImagesListData({"target" : target},"/process/admin/page/list_file.asp");
	var check					= false;
	var result				= "";

	var setSort				= function(){
		setTimeout(function(){
			$("#list_images .list_sort").sortable({
        update:function(){
					var value = "";
					$(".step_images").each(function(i) {
						value += ((value == "")? "" : ",") + $(this).val();
					});

					updateImages("-","step",value);
        }
			});
		},500);
	};

	$(xml).find("result").find("list").each(function(i){

		var num										= i+1;
		var idx										= $("idx",this).text().unescape().trim();
		var comNumProduct					= $("comNumProduct",this).text().unescape().trim();
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

		var listForm							= "<input type='hidden' class='step_images' value='"+ idx +"'/>";
		var listImg								= "<img src='"+ fileDirectory +""+ fileNameNew +"'>";

		var listArticle						= "";
				listArticle					 += ""		+	fileCapacity										+ " | ";	
				listArticle					 += ""		+ fileSize												+ "px<br/>";	
				listArticle					 += ""		+ fileDirectory +""+ fileNameNew	+ "";	

		var listFunction					= "";
				listFunction				 += "<ul>";	
				listFunction				 += "	<li><a href=javascript:checkUpdateImages('"+ idx +"','state','d');>삭제</a></li>";	
				listFunction				 += "</ul>";	

				result +="<li>";
				result +="	<table>";
				result +="	<tr>";
				result +="		<td style='padding:5px;'>"+ listForm + listImg				+"</td>";
				result +="		<td>"+ listFunction	+"</td>";
				result +="	</tr>";
				result +="	<tr>";
				result +="		<td colspan='2' style='border-top:1px dashed #cccccc;padding:5px;text-align:left;background:#eeeeee;line-height:16px;'>"+ listArticle		+"</td>";				
				result +="	</tr>";
				result +="	</table>";
				result +="</li>";		

	});

	$("#list_images").html("<ul class='list_sort'>"+ result +"</ul>");


	setSort();

}



/*-------------------------------------------------------------------------------------------------------------------------------*/