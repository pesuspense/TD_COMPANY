/*------------------------------------------------------------------------------------------------------------------------------------------------
||Define
------------------------------------------------------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------------------------------------------------------
||Function
------------------------------------------------------------------------------------------------------------------------------------------------*/
function showPopup(target){
	var viewDevice = $("#popup #"+target +" #view_device").val();

	switch (viewDevice){
	case "all":
		$("#popup #"+target).show();
		break;	
	case "pc":
		if(getDeviceType() == "pc"){
			$("#popup #"+target).show();
		}
		break;	
	case "mo":
		if(getDeviceType() == "mobile"){
			$("#popup #"+target).show();
		}
		break;	
	}
}

function closePopup(target){
	$("#popup #"+target).hide();
}

function closeTodayPopup(target){
	var time		= $("#popup #"+target +" #exposed_time").val();
			time		= (time == "")? 0 : time;
	var nextDay = new Date();
			nextDay.setHours(nextDay.getHours() + time);

	$.cookie(target,"x",{
		"expires:"	: nextDay.toGMTString(),
		"secure"		:	false
	});
	$("#popup #"+target).hide();
}

function initPopup(){
	$("#popup .item").each(function(idx){
		var targetId		= $(this).attr("id")
		var targetValue = getCookie(targetId);
		if(targetValue != "x"){
			showPopup(targetId);
			$(this).find(".close").click(function(){
				closePopup(targetId);
			});
			$(this).find(".closeToday").click(function(){
				closeTodayPopup(targetId);
			});
		}
		//console.log(targetId);
		//console.log(targetValue);
	});
}

/*------------------------------------------------------------------------------------------------------------------------------------------------
||Load
------------------------------------------------------------------------------------------------------------------------------------------------*/
$(document).ready(function(){
	initPopup();
});
