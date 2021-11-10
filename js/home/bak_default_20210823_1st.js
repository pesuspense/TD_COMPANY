/*------------------------------------------------------------------------------------------------------------------------------------------------
||Define
------------------------------------------------------------------------------------------------------------------------------------------------*/
var map = null;
var homeFullpage;

/*------------------------------------------------------------------------------------------------------------------------------------------------
||Movie
------------------------------------------------------------------------------------------------------------------------------------------------*/
var done							= false;
var loadCount				= 0;
var	tag								= document.createElement('script');
			tag.src						= "http://www.youtube.com/iframe_api";
var	firstScriptTag	= document.getElementsByTagName('script')[0];
			firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
var	YTPlayers;

function onYouTubeIframeAPIReady() {
	YTPlayers = new YT.Player('YTPlayers', {
		width: '1000',
		height: '562',
		videoId: '8479ICWMtUo',
		playerVars:{rel:0},																		//관련영상 표시하지 않기.*/
		events: {
			'onReady'						: onPlayerReady,
			'onStateChange'		: onPlayerStateChange
		}
	});
}

function onPlayerReady(event) {
	//console.log(event);
	//event.target.playVideo();
}

function onPlayerStateChange(event) {
	//console.log(event);
	if (event.data == 0) {
		startVideo();
	}
	/*
	//console.log(event.data);
		if (event.data == YT.PlayerState.PLAYING && !done) {
			setTimeout(stopVideo, 6000);
			done = true;
		}
	*/
}

function startVideo() {
	YTPlayers.playVideo();
}

function stopVideo() {
	YTPlayers.stopVideo();
}

function pauseVideo() {
	YTPlayers.pauseVideo();
}

function playMovie(src){
	YTPlayers.loadVideoById(src, 0, 'large');
	setTimeout(function(){
		$("#movie").show(); 
		YTPlayers.playVideo();
	},300);
}

function closeMovie(){
	$("#movie").hide(); 
	stopVideo();
}

/*------------------------------------------------------------------------------------------------------------------------------------------------
||Display
------------------------------------------------------------------------------------------------------------------------------------------------*/

function setEvent(){
	var section5LogoArr = new Array(6);
	section5LogoArr[0] = ["maestro3d.png",		"maestro3d_off.png"];
	section5LogoArr[1] = ["autolign.png",				"autolign_off.png"];
	section5LogoArr[2] = ["suresmile.png",			"suresmile_off.png"];
	section5LogoArr[3] = ["dionavi.png",				"dionavi_off.png"];
	section5LogoArr[4] = ["3shape.png",				"3shape_off.png"];
	section5LogoArr[5] = ["inlab.png",						"inlab_off.png"];

	$("#section3  .slide_division li").each(function(idx){
		$(this).click(function(){
			$("#section3 .slide_group").slick('goTo', idx);    
		});
	});

	$("#section3 .slide_group").on("afterChange", function(event, slick, currentSlide){ 
		$("#section3  .slide_division li").each(function(idx){
			$(this).removeClass("on");
		});
		$("#section3  .slide_division li:nth-child("+ (currentSlide+1) +")").addClass("on");
		//console.log(currentSlide+1); 
    //console.log(section5LogoArr[currentSlide]); 
	}); 

	$("#section5  .logos li").each(function(idx){
		$(this).click(function(){
			$("#section5 .slide_box .slide_group").slick('goTo', idx);    
		});
	});
	$("#section5 .slide_box .slide_group").on("afterChange", function(event, slick, currentSlide){ 
		$("#section5  .logos li").each(function(idx){
			$(this).removeClass("on");
			$(this).find("img").attr("src", "/resource/image/home/section5/logo/"+section5LogoArr[idx][1]);
		});
		$("#section5 .logos li:nth-child("+ (currentSlide+1) +")").addClass("on");
		$("#section5 .logos li:nth-child("+ (currentSlide+1) +") img").attr("src", "/resource/image/home/section5/logo/"+section5LogoArr[currentSlide][0]);
		//console.log(currentSlide+1); 
    //console.log(section5LogoArr[currentSlide]); 
	}); 

	if(getBrowserWidth() < 768){
	}else{

		var setSection8OnTitle   = 	["01.데스크 및 대기실","02.데스크 및 대기실","03.데스크 및 대기실","04.교정 상담실","05.교정 상담실","06.교정 상담실","07.진료실","08.1인 진료실"];
		var setSection8OnImage = function(target){
			var img,src;
			target = target + 1;
			//alert(target);
			$("#section8 .slide_sGroup .slide_item").each(function(idx){
					img = $(this).find("img");
					src = img.attr("src").replace("_on","_off");
					img.attr("src", src);
			});
			img = $("#section8 .slide_sGroup .slide_item"+ target +" img");
			src = img.attr("src").replace("_off","_on");
			img.attr("src", src);
		};

		$("#section8 .slide_sGroup .slide_items").on("afterChange", function(event, slick, currentSlide){ 
				setSection8OnImage(currentSlide);
				$("#section8 .slide_mGroup .slide_items").slick('goTo', currentSlide);    
		}); 

		$("#section8 .slide_mGroup .slide_items").on("afterChange", function(event, slick, currentSlide){ 
				$("#section8 .slide_mGroup .slide_interface .slide_display").html(setSection8OnTitle[currentSlide]);
				$("#section8 .slide_sGroup .slide_items").slick('goTo', currentSlide);    
		}); 

		$("#section8 .slide_sGroup .slide_items img").on("click", function(){ 
				var target = $(this).attr("src").replace(".jpg","").right(1);
						 target = (target * 1) - 1;
				$("#section8 .slide_mGroup .slide_items").slick('goTo', target);    
		}); 
	}
	
 $("#inquiry .form .num").on("keyup", function() {
		$(this).val($(this).val().replace(/[^0-9]/g,""));
 });

}

function setMenu(target){
		target = (target*1) + 1;
		switch (target){
		case 1 :
			$("#gnb").removeClass("color2");
			$("#gnb").addClass("color1");
		break;
		case 2 :
			$("#gnb").removeClass("color1");
			$("#gnb").addClass("color2");
		break;
		case 3 :
			$("#gnb").removeClass("color1");
			$("#gnb").addClass("color2");
		break;
		case 4 :
			$("#gnb").removeClass("color2");
			$("#gnb").addClass("color1");
		break;
		case 5 :
			$("#gnb").removeClass("color1");
			$("#gnb").addClass("color2");
		break;
		case 6 :
			$("#gnb").removeClass("color2");
			$("#gnb").addClass("color1");
		break;
		case 7 :
			$("#gnb").removeClass("color2");
			$("#gnb").addClass("color1");
		break;
		case 8 :
			$("#gnb").removeClass("color1");
			$("#gnb").addClass("color2");
		break;
		case 9 :
			$("#gnb").removeClass("color1");
			$("#gnb").addClass("color2");
		break;
		case 10 :
			$("#gnb").removeClass("color1");
			$("#gnb").addClass("color2");
		break;
		}

		$("#header #gnb .menu").each(function(){
			$(this).removeClass("linkOn");
		});

		if(",2,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu1").addClass("linkOn");
		}else if (",3,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu2").addClass("linkOn");
		}else if (",4,5,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu3").addClass("linkOn");
		}else if (",6,7,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu4").addClass("linkOn");
		}else if (",9,10,11,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu5").addClass("linkOn");
		}

}

function setSection3Slide(){

	if(getBrowserWidth() < 768){

	}else{

	}

	$("#section3 .slide_group").slick({
		dots: false,
		infinite: true,
		autoplay: true,
		autoplaySpeed : 7000,
		draggable : true, 
		pauseOnHover:true,
		nextArrow: $("#section3 .slide_function .next"),
		prevArrow: $("#section3 .slide_function .prev")
	});		
}

function setSection4Slide(){
	if(getBrowserWidth() < 768){
		$("#section4 .slide_group").slick({
			dots: false,
			infinite: true,
			autoplay: true,
			autoplaySpeed : 7000,
			draggable : true, 
			pauseOnHover:true
		});		
	}else{
	}
}

function setSection5Slide(){
	$("#section5 .slide_box .slide_group").slick({
		dots: false,
		infinite: true,
		autoplay: true,
		autoplaySpeed : 7000,
		draggable : true, 
		pauseOnHover:true,
		nextArrow: $("#section5 .slide_function .next"),
		prevArrow: $("#section5 .slide_function .prev")
	});		
}

function setSection5Movie(){
	if(getBrowserWidth() > 768){
		$("#section5 .slide_area .slide_item .slide_image").each(function(){
			$(this).click(function(e){
				playMovie($(this).find("a").attr("src"));
				e.preventDefault();
			});
		});
	}
}

function setSection8Slide(){
	$("#section8 .slide_mGroup .slide_items").slick({
		dots: false,
		infinite: true,
		autoplay: false,
		autoplaySpeed : 3000,
		draggable : true, 
		pauseOnHover:true,
		nextArrow: $("#section8 .slide_mGroup .next"),
		prevArrow: $("#section8  .slide_mGroup  .prev")
	});		

	$("#section8 .slide_sGroup .slide_items").slick({
		vertical: true,
		dots: false,
		infinite: true,
		autoplay: true,
		autoplaySpeed : 5000,
		draggable : true, 
		pauseOnHover:true,
		slidesToShow: 4,
		slidesToScroll: 1,
		nextArrow: $("#section8 .slide_sGroup .next"),
		prevArrow: $("#section8 .slide_sGroup .prev")
	});		
}


function setScroll(){
	/*
		if(getBrowserWidth() < 768){
			$(window).scroll(function(){	
				var windowHeight					= $("html,body").height();
				var windowInnerHeight	= window.innerHeight;
				var inquiryHeight						= $("#inquiry").css("height").replaceAll("px","");
				var inquiryTop								= windowInnerHeight - inquiryHeight;

				if($(this).scrollTop() < windowInnerHeight){
					$("#gnb").css({"opacity":"0"}).stop(true).animate({"opacity":"1"},1000).show();				
					$("#inquiry").hide();
				}else{
					$("#gnb").css({"opacity":"0"}).stop(true).animate({"opacity":"1"},1000).show();	
					$("#inquiry").css({"margin-top":inquiryTop + "px","opacity":"0"}).stop(true).animate({"opacity":"1"},1000).show();				
					//$("#msg").html(windowHeight +"<br>"+ windowInnerHeight + "<br>"+ inquiryHeight+ "<br>"+ inquiryTop);
				}
			});
		}
	*/
}

function setDevice(){
	/*
	if(getBrowserWidth() > 768){
		$("#section8").removeClass("fp-auto-height");
	}else{
		$("#section8").addClass("fp-auto-height");
	}
	*/
}

function openInquiry(){
	$("#inquiry").show();
}

function closeInquiry(){
	$("#inquiry").hide();
}

function setInquiry(){
/*
	var phoneRule					= /^\d{3,4}-\d{3,4}-\d{4}$/;
	var name									= $("#inquiry #name");
	var phone								= $("#inquiry #phone");
	var checkPrivacy			= $("#inquiry #privacy");
	var contents							= $("#inquiry #contents");

	$(document).on("keyup", "#inquiry #phone", function() {$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );});
	$(document).on("change", "#inquiry #type", function() {phone.focus();});
	$(document).on("change", "#inquiry #quantity", function() {window.focus();});

		var check = function(){
			var result = true;
			if((result == true) && (name.val().trim().length < 2)){
				alert("이름을 2자 이상 입력하세요!");
				name.focus();
				result = false;
			}
			if((result == true) && (phoneRule.test(phone.val().trim()) == false)){
				alert("연락처를 정확히 입력해주세요!\n예)010-0000-0000");
				phone.focus();
				result = false;
			}
			if((result == true) && (checkPrivacy.is(":checked") == false)){
				alert("개인 정보처리 방침 동의 후 상담 신청이 가능합니다!");
				checkPrivacy.focus();
				result = false;
			}
			return result;
		};

		var process = function(){
			var reset = function(){
				name.val("");       
				phone.val("");
				contents.val("");
			};
			$.ajax({
					url				: "/process/inquiry/process.asp",
					type			: "POST",
					data			: {
												"name"			: name.val().trim(),
												"phone"			: phone.val().trim(),
												"contents"	: contents.val().trim()
											},
					dataType	: "xml",
					async			: true,
					success		: function(xml,textStatus){
						var answer	= $(xml).find("result").find("answer").text().unescape().trim();
						var message = $(xml).find("result").find("message").text().unescape().trim();
						if(answer == "ok"){
							reset();
							alert("무료 상담 신청이 완료되었습니다.\n\n담당자 확인 후 연락드리겠습니다.");	
							location.href = "/#0";
							return;
						}else{
							alert(message);
							return;
						}
					},
					error			:	function(xhr,textStatus)	{alert('error:관리자에게 문의하세요.'+textStatus);}
					//beforeSend:	function(xhr)						{alert('데이터보내기전');},
					//complete:		function(xhr,textStatus){alert('응답완료.');}
			});		
		};

		$("#inquiry .form .submit").click(function(){
			if(check()){
				process();
			}
		});
*/
		$("#inquiry .form input, #inquiry .form textarea, #inquiry .form button").click(function(){
			alert("준비 중입니다!");
			window.focus();
			return;
		});

}

function setPartItem(target, action){
	/*
	switch (target){
	case "gnb" : 
		if(action == "on"){
			$("#gnb").stop(true).fadeIn(500);
		}else{
			$("#gnb").stop(true).fadeOut(500);
		}
	break;
	}
	*/
}																																																																																																								

function firstEffect(){
	if(getBrowserWidth() > 768){
		$("#quick .link").stop(true).delay(1000).animate({"opacity":"1", "margin-right":"0"}, 700);
	}else{
		$("#quick .link ul > li:nth-child(1) .icon").stop(true).delay(2000).animate({"opacity":"1", "margin-left":"0"}, 700);
		$("#quick .link ul > li:nth-child(2) .icon").stop(true).delay(2400).animate({"opacity":"1", "margin-left":"0"}, 600);
		$("#quick .link ul > li:nth-child(3) .icon").stop(true).delay(2800).animate({"opacity":"1", "margin-left":"0"}, 400);
		$("#quick .link ul > li:nth-child(4) .icon").stop(true).delay(3200).animate({"opacity":"1", "margin-left":"0"}, 100);
	}
}

function reSetEffect(origin,destination,direction){
	if(getBrowserWidth() > 768){	
		$("#section1 .element .introduce dl > dt .line2").removeClass("focus-in-expand-fwd");
		$("#section2 .element .card").removeClass("focus-in-expand-fwd");
		$("#section3 .element .title .line1").removeClass("focus-in-expand-fwd");
		$("#section4 .element .title .line1").removeClass("focus-in-expand-fwd");
		$("#section5 .element .title .line2").removeClass("focus-in-expand-fwd");
		$("#section6 .element .title .line2").removeClass("focus-in-expand-fwd");
		$("#section8 .element .title .line2").removeClass("focus-in-expand-fwd");
		$("#section9 .element .title .line1").removeClass("focus-in-expand-fwd");

		$("#section1	.element .introduce dl > dd .box .title .slogan")	.removeClass("bounce-top");
		
		$("#section2  .visual .visual1 img").stop(true).delay(0).animate({"opacity":"0", "left":"100px"}, 300);
		$("#section2  .visual .visual2 img").stop(true).delay(0).animate({"opacity":"0"}, 300);
		$("#section2	 .element .introduce .box .feature").stop(true).delay(0).animate({"opacity":"0", "width":"0"}, 300);

	}else{
		$("#section1 .element .introduce dl > dt .line2").removeClass("focus-in-expand-fwd");
		$("#section2 .element .card").removeClass("focus-in-expand-fwd");
		$("#section3 .element .title .line1").removeClass("focus-in-expand-fwd");
		$("#section4 .element .title .line1").removeClass("focus-in-expand-fwd");
		$("#section5 .element .title .line2").removeClass("focus-in-expand-fwd");
		$("#section6 .element .title .line2").removeClass("focus-in-expand-fwd");
		$("#section8 .element .title .line2").removeClass("focus-in-expand-fwd");
		$("#section9 .element .title .line1").removeClass("focus-in-expand-fwd");

	}
	setEffectInit();
}

function setEffectInit(){
	//alert("setEffectInit");
	if(getBrowserWidth() > 768){		
		/*
			$("#section1 .visual .visual1 img").css({"opacity":"0.85"});
		*/
	}else{													
	}
}

function setEffect(origin,destination,direction){
	//console.log("origin:"+origin.index +" | "+ "destination:"+destination.index );
	if(destination.index == 0){
		//setPartItem("gnb", "on");
	}else{
		//setPartItem("gnb", "off");
	}
	switch(destination.index+1){
	case 1	: setSection1();	break;	
	case 2	:	setSection2();	break;	
	case 3	:	setSection3();	break;	
	case 4	:	setSection4();	break;
	case 5	:	setSection5();  break;	
	case 6	:	setSection6();  break;
	case 7	:	setSection7();	break;
	case 8	:	setSection8();	break;
	case 9	:	setSection9();	break;
	case 10	:	setSection10();	break;
	case 11	:	setSection11();	break;
	case 12	:	setSection12();	break;
	case 13	:	setSection13();	break;
	}
	setMenu(destination.index);
}

function setSection1(){
	var ascItem		= $("#section1 .bg ul > li img");
	var descItem		= ascItem.get().reverse() ;
	var arrItem			= new Array(10);
	arrItem[0]  = [1];
	arrItem[1]  = [2,11];
	arrItem[2]  = [3,12,21];
	arrItem[3]  = [4,13,22,31];
	arrItem[4]  = [5,14,23,32,41];
	arrItem[5]  = [6,15,24,33,42,51];
	arrItem[6]  = [7,16,25,34,43,52,61];
	arrItem[7]  = [8,17,26,35,44,53,62,71];
	arrItem[8]  = [9,18,27,36,45,54,63,72];
	arrItem[9]  = [10,19,28,37,46,55,64,73];
	arrItem[10] = [20,29,38,47,56,65,74];
	arrItem[11] = [30,39,48,57,66,75];
	arrItem[12] = [40,49,58,67,76];
	arrItem[13] = [50,59,68,77];
	arrItem[14] = [60,69,78];
	arrItem[15] = [70,79];
	arrItem[16] = [80];
	var getDelayCount = function(target){
		var result = 0;
		for(var i = 0; i < arrItem.length; i++){
			for(var j = 0; j < arrItem[i].length; j++){
				if(target == arrItem[i][j]){
					result = i;
					break;
				}
			}
		}
		return result;
	};
	setTimeout(function(){
		ascItem.each(function(i){
			var d = getDelayCount(i+1);
			//console.log(i +":"+ d);
			$(this).css({"opacity":"0.3"}).stop(true).delay(d * 100).animate({"opacity":"1"}, 300);
		});
	},1500);

	setTimeout(function(){
		$(descItem).each(function(i){
			var d = getDelayCount(i+1);
			//console.log(i +":"+ d);
			$(this).attr("src", $(this).attr("src").replace("color_n.","n")) ;
			$(this).css({"opacity":"0.3"}).stop(true).delay(d * 100).animate({"opacity":"1"}, 300);
		});
	},4000);

	$("#section1	.element .introduce dl > dt .line2")	.addClass("focus-in-expand-fwd");
	setTimeout(function(){
		$("#section1	.element .introduce dl > dd .box .title .slogan").addClass("bounce-top");
	},2000);

	setTimeout(function(){
		//$("#section1	.element .introduce dl > dd .box .title .slogan img").animate({"position":"absolute","margin-top":"-7px"}, 300);
	},3000);
}
function setSection2(){
	if(getBrowserWidth() > 768){
		$("#section2  .visual .visual1 img").stop(true).delay(0).animate({"opacity":"1", "left":"245px"}, 1500);
		$("#section2  .visual .visual2 img").stop(true).delay(1000).animate({"opacity":"0.5"}, 700);
		$("#section2	 .element .introduce .box .feature").stop(true).delay(100).animate({"opacity":"1", "width":"570px"}, 700);

		$("#section2 .element .card").addClass("focus-in-expand-fwd");

	}else{
	}
}
function setSection3(){
	if(getBrowserWidth() > 768){
		$("#section3 .element .title .line1").addClass("focus-in-expand-fwd");
	}else{
		$("#section3 .element .title .line1").addClass("focus-in-expand-fwd");
	}
}
function setSection4(){
	if(getBrowserWidth() > 768){
		$("#section4 .element .title .line1").addClass("focus-in-expand-fwd");
	}else{
		$("#section4 .element .title .line1").addClass("focus-in-expand-fwd");
	}
}
function setSection5(){
	if(getBrowserWidth() > 768){
		$("#section5 .element .title .line2").addClass("focus-in-expand-fwd");
	}else{
		$("#section5 .element .title .line2").addClass("focus-in-expand-fwd");
	}
}
function setSection6(){
	if(getBrowserWidth() > 768){
		$("#section6 .element .title .line2").addClass("focus-in-expand-fwd");
	}else{
		$("#section6 .element .title .line2").addClass("focus-in-expand-fwd");
	}
}
function setSection7(){
	if(getBrowserWidth() > 768){
	}else{
	}
}
function setSection8(){
	if(getBrowserWidth() > 768){
		$("#section8 .element .title .line2").addClass("focus-in-expand-fwd");
	}else{
		$("#section8 .element .title .line2").addClass("focus-in-expand-fwd");
	}
}
function setSection9(){
	if(getBrowserWidth() > 768){
		$("#section9 .element .title .line1").addClass("focus-in-expand-fwd");
	}else{
		$("#section9 .element .title .line1").addClass("focus-in-expand-fwd");
	}
}
function setSection10(){
	if(getBrowserWidth() > 768){
	}else{
	}
}
function setSection11(){
	if(getBrowserWidth() > 768){
	}else{
	}
}
function setSection12(){
	if(getBrowserWidth() > 768){
	}else{
	}
}
function setSection13(){
	if(getBrowserWidth() > 768){
	}else{
	}
}

function setFullpage(useAutoScrolling){
	homeFullpage = new fullpage('#fullpage', {
			fitToSection: false,
			autoScrolling: useAutoScrolling,
			scrollingSpeed: 300,
			anchors: ['1', '2', '3', '4', '5', '6', '7', '8','9', '10', '11','12','13'],
			slidesNavigation: true,
			lazyLoading: true,
			afterRender: function(){
				/*
				if(getDeviceType() == "mobile"){
					return;
				}
				*/
			},
			onLeave: function(origin,destination,direction){
				reSetEffect(origin,destination,direction);
			},
			afterLoad: function(origin,destination,direction){
				setEffect(origin,destination,direction);
			},
			afterRender : function(){
				setEffectInit();
				//console.log("afterRender();");
			},
			licenseKey: 'F14AA2A7-EFEA4E34-959D0626-C0FC9732'
	});
}

/*------------------------------------------------------------------------------------------------------------------------------------------------
||Load
-----------------------------------------------------------------------------------------------------------------------------------------------*/


$(document).ready(function(){

	firstEffect();
	setEvent();
	setInquiry();
	setSection3Slide();
	setSection4Slide();
	setSection5Slide();
	setSection5Movie();
	setSection8Slide();

	if(getBrowserWidth() > 768){
		setFullpage(true);
	}else{
		setFullpage(false);
		$("#header #gnb .menu").click(function(){
			var gnbHeight = $("#gnb").css("height").replaceAll("px","");
			var menuHeight = $("#gnb .menu_area").css("height").replaceAll("px","");
			var minHeight = Math.floor(gnbHeight*1) + Math.floor(menuHeight*1) ;
			var winHeight	= $("html,body").height();
			var secHeight = $("#section"+ $(this).find("a").attr("href").replaceAll("#","")).offset();
			$("html, body").scrollTop(secHeight.top - minHeight);
		});
	}

	/*
		setEffectInit();
		setEvent();
		setScroll();
		setDevice();
		setSection5Slide();
		setSection6Slide();
		setInquiry();

		if(getBrowserWidth() > 768){
			setFullpage(true);
		}else{
			setFullpage(false);
			$("#header #gnb .menu").click(function(){
				var gnbHeight = $("#gnb").css("height").replaceAll("px","");
				var winHeight	= $("html,body").height();
				var secHeight = $("#section"+ $(this).find("a").attr("href").replaceAll("#","")).offset();
				$('html, body').scrollTop(secHeight.top - gnbHeight);
			});
		}
	*/
});

$(window).on('load', function () {

	if(getBrowserWidth() > 768){
		$("#section6 .slide_item_image").twentytwenty({default_offset_pct :0.5});
		$("#section7 .slide_item_image").twentytwenty({default_offset_pct :0.5});
	}else{
		$("#section6 .slide_item_image").twentytwenty({default_offset_pct :0.55});
		$("#section7 .slide_item_image").twentytwenty({default_offset_pct :0.55});
	}
	setTimeout(function(){
		$("#section6 .slide_item").each(function(i){
			//$(this).find(".twentytwenty-handle").css({"opacity":"1", "left":"0"}).stop(true).delay(i * 700).animate({"opacity":"1","left":"200px"}, 1000);
		});
	},1000);


});

$(window).resize(function(){
	//setDevice();
});
