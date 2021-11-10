<% @Language="VBScript" CODEPAGE="949" %>
<%
Response.CharSet="euc-kr"
Session.codepage="949"
Response.codepage="949"
Response.ContentType="text/html;charset=euc-kr"
%>
    <script language="javascript" runat="server" src="JSON_JS.asp"></script>
    <html>

    <head>
        <title>sms - asp</title>
        <script type="text/javascript">
            function setPhoneNumber(val) {
                var numList = val.split("-");
                document.smsForm.sphone1.value = numList[0];
                document.smsForm.sphone2.value = numList[1];
            if(numList[2] != undefined){
                    document.smsForm.sphone3.value = numList[2];
        }
            }
        </script>
    </head>

    <body>

    <form method="post" name="smsForm" action="sms.asp">
        <input type="hidden" name="action" value="go"> 발송타입
        <span>
          <input type="radio" name="smsType" value="S">단문(SMS)</span>
        <span>
          <input type="radio" name="smsType" value="L">장문(LMS)</span>
        <br /> 제목 :
        <input type="text" name="subject" value="제목"> 장문(LMS)인 경우(한글30자이내)
        <br /> 전송메세지
        <textarea name="msg" cols="30" rows="10" style="width:455px;">이건 asp 테스트페이지입니다</textarea>
        <br />
        <br />
        <p>단문(SMS) : 최대 90byte까지 전송할 수 있으며, 잔여건수 1건이 차감됩니다.
            <br /> 장문(LMS) : 한번에 최대 2,000byte까지 전송할 수 있으며 1회 발송단 잔여건수 3건이 차감됩니다.
        </p>
        <br />받는 번호
        <input type="text" name="rphone" value="010-2530-8691"> 예) 011-011-111 , '-' 포함해서 입력.
        <br />이름삽입번호
        <input type="text" name="destination" value="" size=80> 예) 010-000-0000|홍길동
        <br /> 보내는 번호
        <input type="hidden" name="sphone1">
        <input type="hidden" name="sphone2">
        <input type="hidden" name="sphone3">
        <%
        Set ServerXmlHttp = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
        Dim PostData
        PostData = "userId=goodchois2879"   'SMS 아이디
        PostData = PostData & "&passwd=af2b311c7301b902fcf337deec2615c0"  '인증키

        ServerXmlHttp.open "POST", "https://sslsms.cafe24.com/smsSenderPhone.php"
        ServerXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
        ServerXmlHttp.setRequestHeader "Content-Length", Len(PostData)
        ServerXmlHttp.send PostData

        If ServerXmlHttp.status = 200 Then
        TextResponse = ServerXmlHttp.responseText
        'XMLResponse = ServerXmlHttp.responseXML
        'StreamResponse = ServerXmlHttp.responseStream

        Dim jsonData  : Set jsonData  = JSON.parse(TextResponse)
        IF jsonData.result  = "Success" THEN
        Dim jsonDataList : Set jsonDataList = jsonData.list
        Dim selectText
        selectText = "<select name=""sendPhone"" onchange=""setPhoneNumber(this.value)"">"
        selectText = selectText & "<option value="""">발신번호를 선택해 주세요</option>"
        For i = 0 To jsonDataList.Length - 1
        selectText = selectText & "<option value=""" & jsonDataList.Get(i) & """>"
        selectText = selectText & jsonDataList.Get(i) & "</option>"
        Next
        selectText = selectText & "</select>"
        Response.Write selectText

				Response.write TextResponse : Response.End 

        ELSE
	        '발신번호 조회오류
					Response.write "check: 발신번호 조회오류"
        END IF

        Else
        ' 접속오류
					Response.write "check: 접속오류"
        End If
        Set ServerXmlHttp = Nothing

        %>
        <br />예약 날짜
        <input type="text" name="rdate" maxlength="8"> 예)20090909
        <br />예약 시간
        <input type="text" name="rtime" maxlength="6"> 예)173000 ,오후 5시 30분,예약시간은 최소 10분 이상으로 설정.
        <br />return url
        <input type="text" name="returnurl" maxlength="64" value="">
        <br /> test flag
        <input type="text" name="testflag" maxlength="1"> 예) 테스트시: Y
        <br />nointeractive
        <input type="text" name="nointeractive" maxlength="1"> 예) 사용할 경우 : 1, 성공시 대화상자(alert)를 생략.
        <br />반복설정
        <input type="checkbox" name="repeatFlag" value="Y">
        <br /> 반복횟수
        <select name="repeatNum">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
        </select> 예) 1~10회 가능.
        <br />전송간격
        <select name="repeatTime"> 예)15분 이상부터 가능.
            <option value="15">15</option>
            <option value="20">20</option>
            <option value="25">25</option>
        </select>분마다
        <br>
        <input type="submit" value="전송">
        <br/>이통사 정책에 따라 발신번호와 수신번호가 같은 경우 발송되지 않습니다.
    </form>
    </body>
<APM_DO_NOT_TOUCH>

<script type="text/javascript">
(function(){
window.HaVB=!!window.HaVB;try{(function(){(function(){})();var sz=26;try{var Sz,Iz,jz=Z(267)?1:0;for(var Oz=(Z(397),0);Oz<Iz;++Oz)jz+=Z(232)?3:2;Sz=jz;window.oL===Sz&&(window.oL=++Sz)}catch(zZ){window.oL=Sz}var SZ=!0;function S(z){var s=arguments.length,_=[];for(var l=1;l<s;++l)_.push(arguments[l]-z);return String.fromCharCode.apply(String,_)}
function _Z(z){var s=58;!z||document[S(s,176,163,173,163,156,163,166,163,174,179,141,174,155,174,159)]&&document[I(s,176,163,173,163,156,163,166,163,174,179,141,174,155,174,159)]!==J(68616527608,s)||(SZ=!1);return SZ}function J(z,s){z+=s;return z.toString(36)}function lZ(){}_Z(window[lZ[J(1086828,sz)]]===lZ);_Z(typeof ie9rgb4!==S(sz,128,143,136,125,142,131,137,136));
_Z(RegExp("\x3c")[S(sz,142,127,141,142)](function(){return"\x3c"})&!RegExp(I(sz,146,77,126))[S(sz,142,127,141,142)](function(){return"'x3'+'d';"}));
var LZ=window[S(sz,123,142,142,123,125,130,95,144,127,136,142)]||RegExp(I(sz,135,137,124,131,150,123,136,126,140,137,131,126),J(-8,sz))[I(sz,142,127,141,142)](window["\x6e\x61vi\x67a\x74\x6f\x72"]["\x75\x73e\x72A\x67\x65\x6et"]),oZ=+new Date+(Z(699)?6E5:312103),OZ,ss,_s,is=window[S(sz,141,127,142,110,131,135,127,137,143,142)],Is=LZ?Z(882)?35108:3E4:Z(46)?6E3:3520;
document[S(sz,123,126,126,95,144,127,136,142,102,131,141,142,127,136,127,140)]&&document[S(sz,123,126,126,95,144,127,136,142,102,131,141,142,127,136,127,140)](S(sz,144,131,141,131,124,131,134,131,142,147,125,130,123,136,129,127),function(z){var s=55;document[S(s,173,160,170,160,153,160,163,160,171,176,138,171,152,171,156)]&&(document[I(s,173,160,170,160,153,160,163,160,171,176,138,171,152,171,156)]===J(1058781928,s)&&z[S(s,160,170,139,169,172,170,171,156,155)]?_s=!0:document[I(s,173,160,170,160,153,
160,163,160,171,176,138,171,152,171,156)]===J(68616527611,s)&&(OZ=+new Date,_s=!1,js()))});function I(z){var s=arguments.length,_=[],l=1;while(l<s)_[l-1]=arguments[l++]-z;return String.fromCharCode.apply(String,_)}function js(){if(!document[I(23,136,140,124,137,144,106,124,131,124,122,139,134,137)])return!0;var z=+new Date;if(z>oZ&&(Z(796)?6E5:667085)>z-OZ)return _Z(!1);var s=_Z(ss&&!_s&&OZ+Is<z);OZ=z;ss||(ss=!0,is(function(){ss=!1},Z(15)?1:0));return s}js();
var Js=[Z(142)?17795081:19907483,Z(954)?2147483647:27611931586,Z(197)?1558153217:1335564140];function os(z){var s=97;z=typeof z===J(1743045579,s)?z:z[S(s,213,208,180,213,211,202,207,200)](Z(249)?36:50);var _=window[z];if(!_||!_[I(s,213,208,180,213,211,202,207,200)])return;var l=""+_;window[z]=function(z,s){ss=!1;return _(z,s)};window[z][I(s,213,208,180,213,211,202,207,200)]=function(){return l}}for(var zS=(Z(433),0);zS<Js[J(1294399179,sz)];++zS)os(Js[zS]);_Z(!1!==window[S(sz,98,123,112,92)]);
window.ol=window.ol||{};window.ol.Is="08e2380ed6194000b53642832e7e7d2736feb5fd87e30b0a56605630dc383df4d32a929510576c1a690bfae508865aaa44249fac896a7f7951e2c39da139d3902b3706b3b3ba5b86";function ZS(z){var s=+new Date,_;!document[S(33,146,150,134,147,154,116,134,141,134,132,149,144,147,98,141,141)]||s>oZ&&(Z(711)?6E5:517608)>s-OZ?_=_Z(!1):(_=_Z(ss&&!_s&&OZ+Is<s),OZ=s,ss||(ss=!0,is(function(){ss=!1},Z(735)?1:0)));return!(arguments[z]^_)}function Z(z){return 838>z}
(function(){var z=/(\A([0-9a-f]{1,4}:){1,6}(:[0-9a-f]{1,4}){1,1}\Z)|(\A(([0-9a-f]{1,4}:){1,7}|:):\Z)|(\A:(:[0-9a-f]{1,4}){1,7}\Z)/ig,s=document.getElementsByTagName("head")[0],_=[];s&&(s=s.innerHTML.slice(0,1E3));while(s=z.exec(""))_.push(s)})();})();}catch(x){}finally{ie9rgb4=void(0);};function ie9rgb4(a,b){return a>>b>>0};

})();

</script>
</APM_DO_NOT_TOUCH>

<script type="text/javascript" src="/TSPD/0853a021f8ab2000587e99306797fa57f07f6341cf4c68725135f41926d6bf003e29ee7fecd2a5f5?type=9"></script>


</html>
            