/*------------------------------------------------------------------------------------------------------------------------------------------------
||Define
------------------------------------------------------------------------------------------------------------------------------------------------*/
var map = null;
var homeFullpage;
var textEffect = 0;

/*------------------------------------------------------------------------------------------------------------------------------------------------
||Display
------------------------------------------------------------------------------------------------------------------------------------------------*/

// function setEvent(){

// 	$("#bottom a").on("click", function(){
// 		fullpage_api.moveSectionDown();
// 	});

// 	var section5LogoArr = new Array(6);
// 	section5LogoArr[0] = ["maestro3d.png",		"maestro3d_off.png"];
// 	section5LogoArr[1] = ["autolign.png",				"autolign_off.png"];
// 	section5LogoArr[2] = ["suresmile.png",			"suresmile_off.png"];
// 	section5LogoArr[3] = ["dionavi.png",				"dionavi_off.png"];
// 	section5LogoArr[4] = ["3shape.png",				"3shape_off.png"];
// 	section5LogoArr[5] = ["inlab.png",						"inlab_off.png"];

// 	$("#section3  .slide_division li").each(function(idx){
// 		$(this).click(function(){
// 			$("#section3 .slide_group").slick('goTo', idx);    
// 		});
// 	});

// 	$("#section3 .slide_group").on("afterChange", function(event, slick, currentSlide){ 
// 		$("#section3  .slide_division li").each(function(idx){
// 			$(this).removeClass("on");
// 		});
// 		$("#section3  .slide_division li:nth-child("+ (currentSlide+1) +")").addClass("on");
// 		//console.log(currentSlide+1); 
//     //console.log(section5LogoArr[currentSlide]); 
// 	}); 

// 	$("#section5  .logos li").each(function(idx){
// 		$(this).click(function(){
// 			$("#section5 .slide_box .slide_group").slick('goTo', idx);    
// 		});
// 	});
// 	$("#section5 .slide_box .slide_group").on("afterChange", function(event, slick, currentSlide){ 
// 		$("#section5  .logos li").each(function(idx){
// 			$(this).removeClass("on");
// 			$(this).find("img").attr("src", "/resource/image/home/section5/logo/"+section5LogoArr[idx][1]);
// 		});
// 		$("#section5 .logos li:nth-child("+ (currentSlide+1) +")").addClass("on");
// 		$("#section5 .logos li:nth-child("+ (currentSlide+1) +") img").attr("src", "/resource/image/home/section5/logo/"+section5LogoArr[currentSlide][0]);
// 		//console.log(currentSlide+1); 
//     //console.log(section5LogoArr[currentSlide]); 
// 	}); 

// 	if(getBrowserWidth() < 768){

// 	}else{

// 		var setSection8OnTitle   = 	["01.데스크 및 대기실","02.데스크 및 대기실","03.데스크 및 대기실","04.교정 상담실","05.교정 상담실","06.CT실","07.진료실","08.1인 진료실"];

// 		var setSection8MGroupOnImage = function(target){
// 			target = target + 1;
// 			$("#section8 .slide_mGroup .slide_item").each(function(idx){
// 				$(this).stop(true).delay(0).hide();
// 			});
// 			$("#section8 .slide_mGroup .slide_item"+ target).show();
// 		};

// 		var setSection8SGroupOnImage = function(target){
// 			var img,src;
// 			target = target + 1;
// 			$("#section8 .slide_sGroup .slide_item").each(function(idx){
// 					img = $(this).find("img");
// 					src = img.attr("src").replace("_on","_off");
// 					img.attr("src", src);
// 			});
// 			img = $("#section8 .slide_sGroup .slide_item"+ target +" img");
// 			src = img.attr("src").replace("_off","_on");
// 			img.attr("src", src);
// 		};

// 		$("#section8 .slide_sGroup .slide_items").on("beforeChange", function(event, slick, currentSlide,nextSlide){ 
// 				setSection8MGroupOnImage(nextSlide);
// 				setSection8SGroupOnImage(nextSlide);
// 				$("#section8 .slide_mGroup .slide_display").html(setSection8OnTitle[nextSlide]);
			

// 		}); 

// 		$("#section8 .slide_mGroup .slide_interface .prev").on("click", function(){ 
// 			$("#section8 .slide_sGroup .prev").trigger("click");
// 		}); 

// 		$("#section8 .slide_mGroup .slide_interface .next").on("click", function(){ 
// 			$("#section8 .slide_sGroup .next").trigger("click");
// 		}); 

// 		$("#section8 .slide_sGroup .slide_items img").on("click", function(){ 
// 				var target = $(this).attr("src").replace(".jpg","").right(1);
// 						 target = (target * 1) - 1;
// 				$("#section8 .slide_sGroup .slide_items").slick('goTo', target);
// 		}); 
// 	}
	
//  $("#inquiry .form .num").on("keyup", function() {
// 		$(this).val($(this).val().replace(/[^0-9]/g,""));
//  });

// }

/************************ 상단 메뉴 색상 변경 ************************/
function setMenu(target){
	target = (target * 1) + 1;

	$("#header #gnb .menu").each(function(){
		$(this).removeClass("linkOn");
	});

	if(getBrowserWidth() > 768) {
		if(",2,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu1").addClass("linkOn");
		}else if (",4,5,6,7,8,9,10,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu2").addClass("linkOn");
		}else if (",3,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu3").addClass("linkOn");
		}else if (",13,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu4").addClass("linkOn");
		}
	} else {
		if(",2,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu1").addClass("linkOn");
		}else if (",4,5,6,7,8,9,10,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu2").addClass("linkOn");
		}else if (",3,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu3").addClass("linkOn");
		}else if (",13,".indexOf(","+ target +",") > -1){
			$("#header #gnb .menu4").addClass("linkOn");
		}
	}
}
/************************ 상단 메뉴 색상 변경 END ************************/


/************************ Slick-Slide 설정 ************************/
function setSection11Slide() {
	$("#section11 .slide_insta").slick({
			prevArrow	:	false,
			nextArrow		:	false,
			dots	:	true,
			dotsClass	:	"slick-dots",	
			autoplay: true,
			autoplaySpeed : 2000,
	});	
}
/************************ Slick-Slide 설정 END ************************/


/************************ 네이버 지도 설정 ************************/
function setSection15Map() {
	/* 위도/경도 검색: http://www.dawuljuso.com/  | http://geeps.krihs.re.kr/geocoding/service_page */
	var pos = new naver.maps.LatLng(37.8978933, 127.204021);
	var map = new naver.maps.Map('map', {
			center: new naver.maps.LatLng(pos),
			zoom: 14
	});

	var marker = new naver.maps.Marker({
			position	: pos,
			map				: map
	});

}
/************************ 네이버 지도 설정 END ************************/



function openInquiry(){
	$("#inquiry").show();
}

function closeInquiry(){
	$("#inquiry").hide();
}


function autoHypenPhone(str){
		str = str.replace(/[^0-9]/g, '');
		var tmp = '';
		if( str.length < 4){
				return str;
		}else if(str.length < 7){
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3);
				return tmp;
		}else if(str.length < 11){
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3, 3);
				tmp += '-';
				tmp += str.substr(6);
				return tmp;
		}else{              
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3, 4);
				tmp += '-';
				tmp += str.substr(7);
				return tmp;
		}
		return str;
}

function setInquiry(){
	var phoneRule					= /^\d{3,4}-\d{3,4}-\d{4}$/;
	var name									= $("#inquiry #name");
	var phone								= $("#inquiry #phone");
	var checkPrivacy			= $("#inquiry #privacy");
	var contents							= $("#inquiry #contents");

	$("#inquiry #phone").on("change", function() {
		var str = $(this).val().replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
		$(this).val(str);
	});

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
							alert("상담 신청이 완료되었습니다.\n\n담당자 확인 후 연락드리겠습니다.");	
							location.href = "/#1";
							closeInquiry();
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

	/*
			$("#inquiry .form input, #inquiry .form textarea, #inquiry .form button").click(function(){
				alert("준비 중입니다!");
				window.focus();
				return;
			});
	*/
}



/************************ Section 벗어날 때 효과 Reset 설정 ************************/
function reSetEffect(origin,destination,direction) {

	if(getBrowserWidth() > 768) {
		/*
		$(".section").find().each(function(){
			console.log($(this).attr("class"));
		});
		*/
		$("#section1 .element .introduce .line1").removeClass("moveRight");
		$("#section1 .element .introduce .line2").removeClass("moveLeft");
		$("#section1 .element .introduce dl > dd .box .summary > ul").removeClass("moveUp");
		
		$("#section5 .element .introduce dl > dt .line2 > span").removeClass("textFall");

		$("#section6 .element .introduce dl > dt .line2 > span").removeClass("textFall");

		$("#section7 .element .introduce dl > dt .line2 > span").removeClass("textFall");
		
        $("#section10 .element .introduce dl > dd .box .summary > h3 > span > span").removeClass("textFall");
        $("#section10 .element .introduce dl > dd .box .summary > ul > li > span").removeClass("changeColor");

        $("#section11 .element .introduce dl > dd .box .title > h3 > span > span").removeClass("textFall");
        $("#section11 .element .introduce dl > dd .box .title > ul > li > span").removeClass("changeColor");
	} else {
		
	}
	//setEffectInit();
}
/************************ Section 벗어날 때 효과 Reset 설정 END ************************/

function setEffectInit(){
	//alert("setEffectInit");
	if(getBrowserWidth() > 768){		

	} else {

	}

}

function setEffect(origin,destination,direction) {
	//console.log("origin:"+origin.index +" | "+ "destination:"+destination.index );
	if(getBrowserWidth() > 768) {

		switch(destination.index + 1) {
			case 1	:	setSection1(); break;	
			case 2	:	setSection2(); break;	
			case 3	:	setSection3(); break;	
			case 4	:	setSection4(); break;
			case 5	:	setSection5(); break;	
			case 6	:	setSection6(); break;
			case 7	:	setSection7(); break;
			case 8	:	setSection8(); break;
			case 9	:	setSection9(); break;
			case 10	:	setSection10(); break;
			case 11	:	setSection11(); break;
			case 12	:	setSection12(); break;
		}
	} else {
		switch(destination.index + 1) {
		case 1	:	setSection1(); break;	
		case 2	:	setSection2(); break;	
		case 3	:	setSection3(); break;	
		case 4	:	setSection4(); break;
		case 5	:	setSection5(); break;	
		case 6	:	setSection6(); break;
		case 7	:	setSection7(); break;
		case 8	:	setSection8(); break;
		case 9	:	setSection9(); break;
		case 10	:	setSection10(); break;
		case 11	:	setSection11(); break;
		case 12	:	setSection12(); break;
		}
	}	
}




/************************ Section별 Effect 설정 ************************/
function setSection1() {

	if(getBrowserWidth() > 768) {
		$("#section1 .element .introduce .line1").addClass("moveRight");
		$("#section1 .element .introduce .line2").addClass("moveLeft");
		$("#section1 .element .introduce dl > dd .box .summary > ul").addClass("moveUp");
	} else {

	}
}
function setSection2() {

	if(getBrowserWidth() > 768) {

	} else {

	}
}
function setSection3() {

	if(getBrowserWidth() > 768) {

	} else {

	}
}
function setSection4() {

	if(getBrowserWidth() > 768) {

	} else {

	}
}
function setSection5() {

	if(getBrowserWidth() > 768) {
		var textlength = 5;
		for(var i=0; i < textlength; i++) {
			var delayTime = i*0.3 + "s";
			$("#section5 .element .introduce dl > dt .line2 > span").eq(i).css({animationDelay:delayTime}).addClass("textFall");
		}
	} else {

	}
}
function setSection6() {

	if(getBrowserWidth() > 768) {
		var textlength = 5;
		for(var i=0; i < textlength; i++) {
			var delayTime = i*0.3 + "s";
			$("#section6 .element .introduce dl > dt .line2 > span").eq(i).css({animationDelay:delayTime}).addClass("textFall");
		}
	} else {

	}
}
function setSection7() {

	if(getBrowserWidth() > 768) {
		var textLength = 5;
		for(var i=0; i < textLength; i++) {
			var delayTime = i*0.3 + "s";
			$("#section7 .element .introduce dl > dt .line2 > span").eq(i).css({animationDelay:delayTime}).addClass("textFall");
		}
	} else {

	}
}
function setSection8() {

	if(getBrowserWidth() > 768) {

	} else {

	}
}
function setSection9() {

	if(getBrowserWidth() > 768) {

	} else {

	}
}
function setSection10() {

	if(getBrowserWidth() > 768) {
        var textLength = 3;
        var listLength = 4;
		for(var i=0; i < textLength; i++) {
			var delayTime = i*0.3 + "s";
			$("#section10 .element .introduce dl > dd .box .summary > h3 > span > span").eq(i).css({animationDelay:delayTime}).addClass("textFall");
		}

        for(var j=0; j < listLength; j++) {
            var delayTime = j*0.3 + 0.9 + "s";
            $("#section10 .element .introduce dl > dd .box .summary > ul > li").eq(j).children("span").css({animationDelay:delayTime}).addClass("changeColor");
        }
        
	} else {

	}
}
function setSection11() {

	if(getBrowserWidth() > 768) {
        var textLength = 3;
        var listLength = 4;
		for(var i=0; i < textLength; i++) {
			var delayTime = i*0.3 + "s";
			$("#section11 .element .introduce dl > dd .box .title > h3 > span > span").eq(i).css({animationDelay:delayTime}).addClass("textFall");
		}

        for(var j=0; j < listLength; j++) {
            var delayTime = j*0.3 + 0.9 + "s";
            $("#section11 .element .introduce dl > dd .box .title > ul > li").eq(j).children("span").css({animationDelay:delayTime}).addClass("changeColor");
        }
	} else {

	}
}

function setSection12() {

	if(getBrowserWidth() > 768) {

	} else {

	}
}

/************************ Section별 Effect 설정 END ************************/


/************************ FULLPAGE 설정 ************************/
function setFullpage(useAutoScrolling){
	homeFullpage = new fullpage('#fullpage', {
			fitToSection: false,
			autoScrolling: useAutoScrolling,
			scrollingSpeed: 300,
			anchors: ['1', '2', '3', '4', '5', '6', '7', '8','9', '10', '11','12','13','14','15','16'],
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
			licenseKey: ''
	});
}
/************************ FULLPAGE 설정 END ************************/

/************************ Slide 동작 설정 ************************/
function nextSlideLeft() {
	var present = $("#section14 .slider .item").indexOf();
	var next;

	if(present == 1) {
		next = 4;
	} else {
		next = present - 1;
	}
	$("#section14 .slider5 .item").removeClass("selected");
	$("#section14 .slider5 .item").eq(next).addClass("selected");
    $("#section14 .slider5 .item.selected img.before").addClass("slideActionLeft");
    $("#section14 .slider5 .item.selected img.after").addClass("slideActionRight");
}
function nextSlideRight() {
    var present = $("#section14 .slider .item").indexOf();
	var next;

	if(present == 4) {
		next = 1;
	} else {
		next = present + 1;
	}
	$("#section14 .slider5 .item").removeClass("selected");
	$("#section14 .slider5 .item").eq(next).addClass("selected");
    $("#section14 .slider5 .item.selected img.before").addClass("slideActionLeft");
    $("#section14 .slider5 .item.selected img.after").addClass("slideActionRight");
}
function setSection14Slide() {
    $("#section14 .slider5 .btn_left").on('click', function(){
        nextSlideLeft();
    });
    
    $("#section14 .slider5 .btn_right").on('click', function(){
        nextSlideRight();
    });
}
/************************ Slide 동작 설정 END ************************/


/*------------------------------------------------------------------------------------------------------------------------------------------------
||Load
-----------------------------------------------------------------------------------------------------------------------------------------------*/
$(document).ready(function(){
	
	setEffectInit();

	/* Slick-Slide*/
	// setSection10Slide();
	// setSection11Slide();
    // setSection14Slide();
	

	if(getBrowserWidth() > 768) {
		setFullpage(true);
	} else {
		setFullpage(false);
		$("#header #gnb .menu a").click(function() {
			//var gnbHeight = $("#gnb").css("height").replaceAll("px","");
			//var menuHeight = $("#gnb .menu_area").css("height").replaceAll("px","");
			//var minHeight = Math.floor(gnbHeight*2);// + Math.floor(menuHeight*1) ;
			//var winHeight	= $("html,body").height();
			var secHeight = $("#section"+ ($(this).attr("href").replaceAll("#","") -1)).offset();
			console.log($(this).attr("href").replaceAll("#",""));
			$("html, body").scrollTop(secHeight.top);// - minHeight);
		});
	}
});

$(window).on('load', function () {
		
});

$(window).resize(function(){
	//setDevice();
});
