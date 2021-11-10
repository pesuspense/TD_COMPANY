/*------------------------------------------------------------------------------------------------------------------
||Config
------------------------------------------------------------------------------------------------------------------*/
var str_popup_fileExtension = "jpg,png,gif";
var arr_popup_device = [	{"code":"all",	"value":"PC+Mobile"},
							{"code":"pc",	"value":"PC"},
							{"code":"mo",	"value":"Mobile"}
					   ];

/*------------------------------------------------------------------------------------------------------------------
||Util
------------------------------------------------------------------------------------------------------------------*/
function getBrowserWidth(){
	return Math.max(document.documentElement.clientWidth	|| 0, window.innerWidth || 0);
}

function getDeviceType(){
	var filter = "win16|win32|win64|mac|macintel";
	var result = "";
	if (filter.indexOf(navigator.platform.toLowerCase()) < 0){
		result = "mobile";
	}else{
		result = "pc";
	}
	return result;
}

function setCookie(name,value){
	$.cookie(name,value,{
		"expires:"	: 365,
		"domain"		:	document.domain,
		"path"			:	location.href.replace("http://"+document.domain,""),
		"secure"		:	false
	});
}

function getCookie(name){
	return ($.cookie(name) == null)? "" : $.cookie(name);
}

String.prototype.alert = function(){
	alert(this);
}

String.prototype.escape = function(){
	return escape(this);
}

String.prototype.unescape = function(){
	return unescape(this);
}

String.prototype.trim = function(){
	return this.replace(/(^\s*)|(\s*$)/g, "");
}

String.prototype.left = function(range){
	if				(range <= 0){
		return "";
	}else if	(range > this.length){
		return this;
	}else{
		return this.substring(0,range);
	}
}

String.prototype.right = function(range){
	if				(range <= 0){
		return "";
	}else if	(range > this.length){
		return this;
	}else{
		return this.substring(this.length, this.length -range);
	}
}

String.prototype.formatNumber = function(type){
	var str				= this.replace(/,/gi,"");

	if(str != ""){
		if(type != "clear"){

			if(isNaN(str) == false){
				str	= parseInt(str) + "";
			}

			var objRegExp = new RegExp('(-?[0-9]+)([0-9]{3})');  
			while(objRegExp.test(str)){
				str = str.replace(objRegExp, '$1,$2'); 
			}
		}
	}
	return str;
}

String.prototype.gAt = function(element, division){
	var result = this.split(division)[element];
	return (typeof result == 'undefined')? -1 : result;
}

String.prototype.gAtIs = function(division){
	return (this.split(division).length > 1)? true : false;
}

String.prototype.gAtCount = function(division){
	return this.split(division).length -1;
}

String.prototype.gAtStep = function(value, division){
	var array,result;
	array = this.split(division);

	for(var i=0; i<array.length; i++){
		if(array[i] == value){
			result = i;
			break;
		}
	}
	return result;
}

String.prototype.replaceAll = function(str1, str2){
	return this.trim().replace(eval("/" + str1 + "/gi"), str2);
}


/*------------------------------------------------------------------------------------------------------------------------------------------------
||Load
------------------------------------------------------------------------------------------------------------------------------------------------*/
$(document).ready(function(){
});