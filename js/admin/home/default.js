/*--------------------------------------------------------------------------------------------------------------------------------
||Define
--------------------------------------------------------------------------------------------------------------------------------*/
var interval	= null;
var iframes		= new Array();
var menu			= {
	main	: "",
	sub		: ""
};


/*--------------------------------------------------------------------------------------------------------------------------------
||Process
--------------------------------------------------------------------------------------------------------------------------------*/
function setMenu(){
	var arg = arguments;
	if(arg.length == 1){
		menu.main		= arg[0];
		menu.sub		= "";
	}else{
		menu.main		= arg[0];
		menu.sub		= arg[1];
	}

	if(arg[0] == "config"){
		$("#headerBot").show();
	}else{
		$("#headerBot").hide();
	}

	$(".menu").each(function() {
		if(this.id.indexOf("_") == -1){
			if(this.id == menu.main){
				this.style.color = "red";
			}else{
				this.style.color = "#cccccc";
			}
		}else{
			if(this.id == menu.main +"_"+ menu.sub){
				this.style.color = "red";
			}else{
				this.style.color = "#787878";
			}
		}
	});

	setFrame();
}

function setFrame(){
	var iframe;	
	
	var getID		= function(){
		return (menu.sub == "")? menu.main : menu.main +"_"+ menu.sub;
	};

	var getURL	= function(){
		return (menu.sub == "")? "/"+ menu.main : "/"+ menu.main +"/"+ menu.sub;
	};

	var getHeight		= function(){
		return ($(window).height() - ((menu.sub == "")? 40 : 70 )) + "px";
	};

	var create	= function(){
		var iframe = document.createElement("iframe");
		iframe.id									= getID();
		iframe.src				 				= getURL();
		iframe.frameBorder 				= "none";
		iframe.scrolling	 				= "no";
		iframe.style.height				= getHeight();
		iframes.push(iframe);
		document.getElementById("body").appendChild(iframe);
	};

	var display = function(){
		for(var i = 0; i < iframes.length; i++){
			if(iframes[i].id == getID()){
				iframes[i].style.display = "block";
			}else{
				iframes[i].style.display = "none";
			}
		}
	};

	var check		= function(){
		var result		= true;
		for(var i = 0; i < iframes.length; i++){
			if(iframes[i].id == getID()){
				result = false;
				break;
			}
		}
		return result;
	};

	if(check()){
		create();
	}

	display();
}

/*--------------------------------------------------------------------------------------------------------------------------------
||Load
--------------------------------------------------------------------------------------------------------------------------------*/
$(document).ready(function(){
	setMenu("admin/page","");
});
/*------------------------------------------------------------------------------------------------------------------------------*/