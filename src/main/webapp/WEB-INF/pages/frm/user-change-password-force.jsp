<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="frm/css/global.css" media="all">
<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="frm/css/frmColors.css" type="text/css">
<style type="text/css">
	#content{
		width: 600px;
		margin: auto;
		border:1px solid #3C8DBC;
		border-radius:4px;
		margin-top: 10px;
	}
	form#mainUserChangePasswordForm{
		padding: 20px;
	}
	.my-pwd-level{
    	margin-left: 5px;
	}
	.my-pwd-level li{
		float: left;
	    margin-right: 5px;
	    width: 60px;
	    text-align: center;	
	    border-top: 5px solid;
	}
	.my-pwd-level li.weak{
		border-color: #E63A12;
	}
	.my-pwd-level li.medium{
		border-color: #2C8581;
	}
	.my-pwd-level li.strong{
		border-color: #0B5E06;
	}
	.my-pwd-level li.init{
		border-color: #D7D7D7;
	}
	.my-pwd-level:after{
		content:"."; 
		display:block; 
		height:0; 
		visibility:hidden; 
		clear:both; 
	}
</style>
</head>
<body>
	<div id="content">
		<div>
			<div class="layui-layer-title">修改初始密码</div>
		</div>
		<form id="mainUserChangePasswordForm" name="mainUserChangePasswordForm" class="layui-form" method="post">
			<div class="frm-row">
				<label class="frm-label frm-col-7">原密码</label>
				<div class="frm-col-17">
					<input type="password" id="ucp-pwd" name="pwd" lay-verify="required" class="frm-input" placeholder="请输入原密码">
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-7">新密码</label>
				<div class="frm-col-17">
					<input type="password" id="ucp-npwd1" name="npwd1" lay-verify="required" data-ul="newpwd1" class="frm-input newpwd" placeholder="请输入新密码">
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-7"></label>
				<div class="frm-col-17">
					<ul class="my-pwd-level newpwd1">
						<li class="weak init">弱</li>
						<li class="medium init">中</li>
						<li class="strong init">强</li>
					</ul>
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-7">确认新密码</label>
				<div class="frm-col-17">
					<input type="password" id="ucp-npwd2" name="npwd2" lay-verify="required" data-ul="newpwd2" class="frm-input newpwd" placeholder="请再次输入新密码确认">
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-7"></label>
				<div class="frm-col-17">
					<ul class="my-pwd-level newpwd2">
						<li class="weak init">弱</li>
						<li class="medium init">中</li>
						<li class="strong init">强</li>
					</ul>
				</div>
			</div>
			<!-- <div class="frm-row">
				<label class="frm-label frm-col-7">上次修改时间</label>
				<div id="last-change-pwd-time" class="frm-col-17 pwd-info">
					
				</div>
			</div>
			<div class="frm-row" style="margin-bottom: 0;">
				<label class="frm-label frm-col-7">密码过期</label>
				<div id="pwd-past-due" class="frm-col-17 pwd-info">
					
				</div>
			</div> -->
			<div class="frm-row" >
				<div class="frm-col-24" style="text-align: right;">
					<a id="ucp-save" class="layui-btn " style="border-color: #4898d5;background-color: #2e8ded;color: #fff;">
						<i class="layui-icon"></i> 保存
					</a>
				</div>
			</div>
		</form>
	</div>

	<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
	<script type="text/javascript" src="common/js/translation.js"></script>
	<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
	<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
	<script type="text/javascript">
		layui.config({
			base: ''
				
		}).extend({
			ajaxTools:	'common/js/ajaxTools',
			domTools:	'common/js/domTools',
			hrefTools:	'common/js/hrefTools',
			jqueryform:	'common/js/jquery.form'
				
		}).use(['element','form','laydate','ajaxTools','domTools','hrefTools','jqueryform'],function(){
			
			var $ = jquery = layui.jquery,
				element = layui.element(),
				ajaxTools  = layui.ajaxTools,
				domTools = layui.domTools,
				hrefTools = layui.hrefTools,
				form = layui.form();
			
			
			//$('#last-change-pwd-time').load('logs.do?method=getLastLogTime',{gnid:'01010305',yhdh:'${userSession.user.yhdh}'});
			//$('#pwd-past-due').text($('#userLoginInfo span.loginUMMYXQ',top.document).text().replace('密码有效期: ',''));
			

			var checkPwd = function(v){
				var modes = 0;

				if(v.length<6){
			    	return '1';
			    }
			    
			    if (/\d/.test(v)) modes++; //数字
			    if (/[a-z]/.test(v)) modes++; //小写
			    if (/[A-Z]/.test(v)) modes++; //大写
			    if (/\W/.test(v)) modes++; //特殊字符
			    
			    switch (modes) {
			    	case 0:
			        case 1:
			            return 1;
			        case 2:
			            return 2;
			        case 3:
			        case 4:
			        	if(v.length>=8){
				            return 3;
			        	}else{
			        		return 2;
			        	}
			        default:
			        	return 1;
			    }
			}
			$('input.newpwd[type=password]').on('keyup onfocus onblur',function(){
				var tip = $('ul.'+$(this).data('ul')+' li');
				var v = $(this).val()+'';
				if(!v){
					tip.addClass('init');
					return;
				}
				var plevel = checkPwd(v);
				if(plevel==1){
					tip.eq(0).removeClass('init').nextAll().addClass('init');
				}else if(plevel==2){
					tip.eq(1).removeClass('init').prevAll().removeClass('init');
					tip.eq(1).nextAll().addClass('init');
				}else if(plevel==3){
					tip.removeClass('init');
				}else{
					tip.addClass('init');
				}
			});
		
			var submitChangeUserPwdForm = function(){
				if(form.verifyForm(mainUserChangePasswordForm)){
					var pwd = $('#ucp-pwd').val();
					var npwd1 = $('#ucp-npwd1').val();
					var npwd2 = $('#ucp-npwd2').val();
					var sfgly = ('${userSession.user.sfgly }'=='1'?true:false);
					var vlevel = checkPwd(npwd1);
					if(sfgly&&(parseInt(vlevel)<3)){
						layer.msg('管理员密码必须达到三级强度，数字、小写、大写和特殊字符任意组合三种，不得少于8位', {icon: 5,shift: 6});
						return;
					}
					if(parseInt(vlevel)<2){
						layer.msg('用户密码必须达到二级强度，数字、小写、大写和特殊字符任意组合二种，不得少于6位', {icon: 5,shift: 6});
						return;
					}
					if(npwd1!=npwd2){
						layer.msg('确认密码不相同!', {icon: 5,shift: 6});
						return;
					}
					
					 $(mainUserChangePasswordForm).ajaxSubmit({
					 	type:'POST',
						url:'user.do',
						data:{
							method:'processingUser',
							yhdh:'${userSession.user.yhdh}',
							mm:pwd,
							mm1:npwd1,
							cxid:'010103',
							gnid:'01010305',
						},
						dataType:'json',
						success:function(rlt){
							if(rlt.code=='1'){
								layer.alert(rlt.mess, {icon: 6} ,function(){
									location.href = 'login.do?method=loginOut';
								});
							}else{
								layer.alert(rlt.mess, {icon: 5});
							}
						}
					 });
				}
			}
			$('#ucp-save').off('click',submitChangeUserPwdForm).on('click',submitChangeUserPwdForm);
		});
	</script>
</body>
</html>
