//변수 초기화		
var uploadImages = {
	obj						: null,
	idForFlash		: "flashUploadImages",
	idForForm			: "theForm",
	idForField		: "hidFileName",
	urlForProcess	: "/process/admin/contents/images_proc.asp",
	urlForResult	: "/process/admin/contents/images_result.asp",
	sizeForWidth	: 600,
	sizeForHeight	: 90
	
};

//업로드 초기화
function setUploadForm(){
	/*------------------------------------------------------------------------------------------
	-Flash 업로더 객체를 생성하는 자바 스크립트 입니다.
	-이 스크립트는 Form 태그내에 들어가게 되면 오류가 발생하기 때문에 
	-반드시 Form 태그 밖에서 사용해야 합니다.
	*------------------------------------------------------------------------------------------*/
	document.getElementById(uploadImages.idForField).value	= "";

	uploadImages.obj = new NFUpload({
		nf_upload_id								: uploadImages.idForFlash,
		nf_width										: uploadImages.sizeForWidth,																// 업로드 컴포넌트 넓이
		nf_height										: uploadImages.sizeForHeight,																// 업로드 컴포넌트 폭	
		nf_max_file_size						: 81920,																										// 업로드 제한 용량 (기본값: 10,240 Kb) (단위는 Kb)                                                        
		nf_max_file_count						: 3000,																											// 업로드 파일 제한 갯수 (기본값: 10)                                                                     
		nf_field_name1							: "파일명",																									// 컴포넌트에 출력되는 파일명 제목			(기본값: File Name)	
		nf_field_name2							: "용량",																										// 컴포넌트에 출력되는 용량 제목				(기본값: File Size)
		nf_upload_url								: uploadImages.urlForProcess,																// 업로드 소스파일 경로 (반드시 입력해야함)                                                                 
		nf_file_filter							: "이미지(*.jpg)|:|*.jpg;*.gif;",													  // 파일 필터링 값 ("이미지(*.jpg)|:|*.jpg;*.gif;*.png;*.bmp"); // 기본값 모든파일                           
		nf_data_field_name					: "DataFieldName",																					// 업로드 폼에 사용되는 값 (기본값(UploadData))                                                            
		nf_flash_url								: "/lib/flash/nfupload.swf",																// 업로드 컴포넌트 플래쉬 파일명                                                                           
		nf_file_overwrite						: false,																										// 업로드시 파일명 처리방법(true : 원본파일명 유지, 덮어씌우기 모드 / false : 유니크파일명으로 변환, 중복방지)    
		nf_limit_ext								: "asp;php;aspx;jsp;cs;html;htm;js;xls;xlsx;txt;doc;",			// 파일 제한 확장자                                                                                      
		nf_font_family							: "돋움",																										// 컴포넌트에서 사용되는 폰트						(기본값: Times New Roman)    
		nf_font_size								: "11",																											// 컴포넌트에서 사용되는 폰트 크기			(기본값: 11)                 
		nf_img_file_browse					: "images/btn_file_browse.gif",															// 파일찾기 이미지                 	
		nf_img_file_browse_width		: "59",																											// 파일찾기 이미지 넓이 (기본값 59) 
		nf_img_file_browse_height		: "22",																											// 파일찾기 이미지 폭 (기본값 22)   
		nf_img_file_delete					: "images/btn_file_delete.gif",															// 파일삭제 이미지                 
		nf_img_file_delete_width		: "59",																											// 파일삭제 이미지 넓이 (기본값 59) 
		nf_img_file_delete_height		: "22",																											// 파일삭제 이미지 폭 (기본값 22)   
		nf_total_size_text					: "전체용량",																									// 파일용량 텍스트                 
		nf_total_size_font_family		: "돋움",																										// 파일용량 텍스트 폰트            
		nf_total_size_font_size			: "12"																											// 파일용량 텍스트 폰트 크기        
	});
}

// 업로드완료 후 실행
function NFU_Complete(value){

	var files			= document.getElementById(uploadImages.idForField).value;
	var fileCount = 0;

	if (value == null){
		alert("업로드할 파일을 선택해 주세요.");
		return;
	}

	fileCount = value.length;
	for (var i = 0; i < fileCount; i++){
		var fileName = value[i].name;
		var realName = value[i].realName;
		var fileSize = value[i].size;
				files		+= fileName + "/" + realName + "|:|";						// 분리자(|:|)는 다른 문자로 변경할 수 있다.
	}

	if (files.substring(files.length - 3, files.length) == "|:|"){
		files = files.substring(0, files.length - 3);
	}

	$.ajax({
		url				: uploadImages.urlForResult,
		type			: "POST",
		data			: {
									"target"					: detail.contentsNum,
									"type"						: detail.imagesType,
									"division"				: ""
								},
		dataType	: "xml",
		async			: false,
		success		: function(xml,textStatus){
			var answer	= $(xml).find("result").find("answer").text().unescape().trim();
			var message = $(xml).find("result").find("message").text().unescape().trim();
			if(answer == "ok"){
				getContentsList();
			}else{
				alert("error!\n"+message);
			}
		},
		error					:	function(xhr,textStatus){alert('error:관리자에게 문의하세요.');}
		//beforeSend	:	function(xhr){alert('데이터보내기전');},
		//complete		:	function(xhr,textStatus){alert('응답완료.');}
	});	
}

function getFileSizeFormat(fileSize) {
  var strSize = "";
  if (fileSize > (1024*1024*1024)){											// GB 단위 계산		
		fileSize /= (1024 * 1024 * 1024);
		strSize = Math.round(fileSize) + " GB";
	}else if (fileSize > (1024*1024)){										// MB 단위 계산
		fileSize /= (1024*1024);
		strSize = Math.round(fileSize) + " MB";
	}else if (fileSize > 1024){														// KB 단위 계산
		fileSize /= 1024;
		strSize = Math.round(fileSize) + " KB";
	}else{
		strSize = fileSize.toString() + " Byte";
	}
	return strSize;
}

function NF_ShowUploadSize(value){											// value값에 실제 업로드된 용량이 넘어온다.	
// alert(value);	
}

function NFUpload_Debug(value){
	Debug("업로드 오류!!!\r\n\r\n" + value);
}

function cancelImagesUpload(){													// 초기화 할때는 첨부파일 리스트도 같이 초기화 시켜 준다.
	uploadImages.obj.AllFileDelete(uploadImages.idForFlash);
	document.getElementById(uploadImages.idForForm).reset();
}

