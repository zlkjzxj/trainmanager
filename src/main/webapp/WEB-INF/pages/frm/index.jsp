<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="renderer" content="webkit" /> 
    <title><%-- <%=Constant.TITLE%> --%></title>
 	<link rel="icon" href="login/pictures/faviconjh.ico" type="image/x-icon">
  	<link rel="stylesheet" href="login/css/buttons.css" type="text/css">
  	<link rel="stylesheet" href="login/css/hr.css">
	<link rel="stylesheet" href="login/css/magic-check.css">
<script type="text/javascript" src="login/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
CAPICOM_CURRENT_USER_STORE = 2;
CAPICOM_STORE_OPEN_READ_WRITE = 1;
if(top!=self)
{          
	if(top.location != self.location)              
		top.location=self.location;      
}
function getCookie(c_name){
	if(document.cookie.length>0){
		c_start=document.cookie.indexOf(c_name + "=");
 		if (c_start!=-1){ 
	    	c_start=c_start + c_name.length+1;
	    	c_end=document.cookie.indexOf(";",c_start);
	    	if (c_end==-1) 
	    		c_end=document.cookie.length;
	    	return unescape(document.cookie.substring(c_start,c_end));
   		}
	}
	return "";
}
function setCookie(c_name,value,expiredays,mmjb){
	var exdate=new Date();
	exdate.setDate(exdate.getDate()+expiredays);
	document.cookie=c_name+ "=" +escape(value)+	((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
	document.cookie="mmcook=" +escape(mmjb)+	((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
}
function login(){
	$('#dlms').val("1");
    if(checkForm()){
	   loginform.submit();
	}
}
function k_submit(e) 
{ 
  	var keynum
	if(window.event) { // IE
		keynum = e.keyCode
	}else if(e.which) { // Netscape/Firefox/Opera
		keynum = e.which
	}
	
	if(keynum==13) { 
  		login();
  	}
}
function checkForm(){
	yhdh=$('#yhdh').val();
	mm=$('#mm').val();
	yzm=$('#yzm').val();
	if(yhdh==""){
		//alert('用户名不能为空！');
		$('#mess').text("用户名不能为空！");
		return false;
	}
	if(mm==""){
		//alert('密码不能为空！');
		$('#mess').text("密码不能为空！");
		return false;
	}
    if(yzm==""){
		//alert('验证码不能为空！');
		$('#mess').text("验证码不能为空！");
		return false;
	} 
	if($("#c1").attr("checked")=="checked"){
		setCookie('visitname',yhdh,365,mm);
	}else{
		setCookie('visitname',yhdh,365,"");
	}
  	return true;
}
function pkilogin(){
	
}
function reset(yzm){
	//$("#loginform")[0].reset();
}
$(document).ready(function(){
	var visitname=getCookie('visitname');
	var mmcook=getCookie('mmcook');
	if( visitname != "" && mmcook!=""){
		document.loginform.yhdh.value = visitname;
		document.loginform.mm.value = mmcook;
		document.loginform.yzm.focus();
	}else if(visitname != ""){
		document.loginform.yhdh.value = visitname;
		document.loginform.mm.focus();
	}else{
		document.loginform.yhdh.focus();
	}    
	$('#shaxinImage').click(function () {//生成验证码  
	    $('#kaptchaImage').hide().attr('src', 'login.do?method=printRandImg&' + Math.floor(Math.random()*100) ).fadeIn(); 
	});    
});
</script>
</head>
<body onkeydown="k_submit(event);">
<form action="login.do?method=login" style="margin: 0px;" method="post" name="loginform" id="loginform">
<input type="hidden" id="dlms" name="dlms">
<div class="container">
	<div class="loginimg"><div class="version"><span><%=Constant.SOFTINFO.getSoftver().toUpperCase()%></span></div></div>
    <div class="guanggao">
    	<div class="loginA">&nbsp;</div>
        <div class="loginB">
        	<div class="kouhao"></div>
            <div class="hrfrom">
            	<ul>
                	<li>
                    <input class="hrinputA" type="text"  placeholder="账号" name="yhdh" id="yhdh" value="${yhdh}" maxlength="10"/>
                    </li>
                    <li>
                    <input class="hrinputA" type="password"  placeholder="密码" name="mm" value="" id="mm" maxlength="20" />
                    </li>
                    <li>
                    <input class="hrinputB" type="text"  placeholder="请输入验证码" value="" name="yzm" id="yzm" maxlength="4" />
                    <img src="login.do?method=printRandImg" class="yzmimg" id="kaptchaImage"/>
                    <img src="login/pictures/shaxin.png" class="shaxin" id="shaxinImage"/>
                    </li>
                    <li>
                    	<img src="login/pictures/dl.png" width="156px" height="43px" onClick="login();"/>
                   		<img src="login/pictures/zsdl.png" width="156px" height="43px" onClick="pkilogin();"/>
                    </li>
                    <li>
                    	<input type="checkbox" name="layout" id="c1">
						<label for="c1" class="c1">记住密码</label>
                    </li>
                    <li>
						<font color="red" id="mess">${mess}</font>
					</li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="footer">在线客服 | 技术支持 | 关于我们<p>兰州中林智能科技有限公司 ©版权所有</div>
</form>
</body>
</html>
