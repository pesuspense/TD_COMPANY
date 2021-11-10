/*--------------------------------------------------------------------------------------------------------------------------------
||Popup
--------------------------------------------------------------------------------------------------------------------------------*/
function openPopup(target){
	var arr = target.split(",");
	for(var i = 0; i < arr.length; i++){
		$("#"+arr[i]).show();
	}

	initPopup(target);
}

function closePopup(target){
	var arr = target.split(",");
	for(var i = 0; i < arr.length; i++){
		$("#"+arr[i]).hide();
	}
}

function initPopup(target){
	var arr			= target.split(",");
	var getSize = function(target){
		var result = new Array(2);
		result[0] = $("#"+target).css("width").replaceAll("px","");
		result[1] = $("#"+target).css("height").replaceAll("px","");
		return result;		
	};

	for(var i = 0; i < arr.length; i++){

		/*임시방편 - bg_popup(가로사이즈 1920 넘는현상) */
		if(arr[i] != "bg_popup"){ 
			var obj			= document.getElementById(arr[i]);
			var size		= getSize(arr[i]);
			var width		= size[0] * 1;
			var height	= size[1] * 1;
			obj.style.left	= (((window.innerWidth	|| document.documentElement.clientWidth)	- width)	/2) + 'px';
			obj.style.top		= (((window.innerHeight || document.documentElement.clientHeight) - height)	/3) + 'px';
		}
	}	
}
