<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>用车评价信息编辑</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		
		<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="frm/css/global.css" media="all">
		<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
		<style type="text/css">
			html,body{
				height: 100%;
			}
			.layui-form-select dl{
				max-height:80px;
			}
			.colmr{
				/* color: #C6B1A9; */
			}
			.frm-textS{
			    line-height: 28px;
			    color: #C6B1A9;
			    border-bottom: 1px solid #c6b1a9;
			}
			.layui-form-switch{
			width:80px;
			}
			.layui-form-switch EM{
			width:50px;
			}
			.layui-form-onswitch I{
			left:60px;
			}
			.frm-row{
				margin:0px 0px 10px;
			}
		</style>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript">
			var length=5;
			layui.config({
				base: '',
				version: new Date().getTime()
			}).extend({
				ajaxTools:	'common/js/ajaxTools',
				glbmSelect:	'common/js/glbmSelect',
				domTools:	'common/js/domTools',
				hrefTools:	'common/js/hrefTools',
				Tools:	'common/js/Tools',
				jqueryform:	'common/js/jquery.form'
			}).use(['element','form','laydate','ajaxTools','glbmSelect','domTools','hrefTools','jqueryform','Tools'],function(){
				var $ = jquery = layui.jquery,
				element = layui.element(),
				ajaxTools  = layui.ajaxTools,
				domTools = layui.domTools,
				hrefTools = layui.hrefTools,
				Tools = layui.Tools,
				form = layui.form();
				
				for(var i=1;i<=length;i++){
					var divs = "<div id=\"clk"+i+"\" class=\"stars\" onclick=\"clk('"+i+"','v')\" style=\"cursor:pointer;margin:0px;padding:0px;width:10%;float:left;\"><i id=\"starv"+i+"\" class=\"layui-icon\" style=\"font-size: 30px;\" >&#xe600;</i></div>"
					$("#vehpf").append(divs);
				}
				for(var i=1;i<=length;i++){
					var divs = "<div id=\"dclk"+i+"\" class=\"stars\" onclick=\"clk('"+i+"','d')\" style=\"cursor:pointer;margin:0px;padding:0px;width:10%;float:left;\"><i id=\"stard"+i+"\" class=\"layui-icon\" style=\"font-size: 30px;\" >&#xe600;</i></div>"
					$("#drvpf").append(divs);
				}
				var pfs = $("#pfv").val();
				var dpfs = $("#pfd").val();
				clk(pfs,"v");//加载机动车评分
				clk(dpfs,"d");//加载驾驶员评分
				
				var opr = $('#opr').val();	//e:编辑  a:新增
				if(opr=='e'){
					//较为特殊的字段无法直接el表达式赋值，js处理下
					$('#lshh').val('${obj.lsh }');
					$("#hpzlh").val('${obj.hpzl}');
					$("#hphmh").val('${obj.hphm}');
					$("#ywlxh").val('${obj.ywlx}');
					$("#ywyyh").val('${obj.ywyy}');
					$("#hpzl").html(formateHpzl('${obj.hpzl}'));
					$("#ywlx").html(formateYwlx('${obj.ywlx}'));
					$("#ywyy").html(formateYwYy('${obj.ywyy}','${obj.ywlx}'));
					$("#jsyxms").html('${obj.jsyxm }');
					$("#jsyzjhms").html('${obj.jsyzjhm }');
					$('#car-save').hide();
					$('#pjnr').attr('readonly','readonly')
					$('.stars').removeAttr('onclick');
				}else if(opr=='a'){
					$('#lshh').val('${flow.lsh }');
					$("#hpzlh").val('${flow.hpzl}');
					$("#hphmh").val('${flow.hphm}');
					$("#ywlxh").val('${flow.ywlx}');
					$("#ywyyh").val('${flow.ywyy}');
					$('#lsh').html('${flow.lsh }');
					$("#hpzl").html(formateHpzl('${flow.hpzl}'));
					$("#hphm").html('${flow.hphm}');
					$("#ywlx").html(formateYwlx('${flow.ywlx}'));
					$("#ywyy").html(formateYwYy('${flow.ywyy}','${flow.ywlx}'));
					$("#jsyxms").html('${flow.jsry }');
					$("#jsyzjhms").html('${flow.jsryzjhm }');
				}
					$("#kssj").html(formateShortDate('${flow.kssj}'));
					$("#jssj").html(formateShortDate('${flow.jssj}'));
				
				$('#car-save').on('click', function() {
					saveflow();
				});
				$('#car-close').on('click', function() {
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭
				});
				
		        function saveflow(){
		        	var oprs = $('#opr').val()
					var gnid = oprs==='e'?'02080102':'02080101';
					if($('#car-save').attr('disabled')=="disabled"){
						return;
					}
					if(form.verifyForm(mainForm)){
						$(mainForm).ajaxSubmit({
							type:'POST',
							url:'appraise.do',
							data:{
								method:'processingAppraise',
								//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
								cxdh:'020801',
								gnid:gnid
							},
							dataType:'json',
							success:function(rlt){
								if(rlt.code=='1'){
									$('#opr').val('e');
									$('#car-save').css({ background: "#F2F2F2",color:"gray"});
									$('#car-save').attr('disabled',true);
									layer.alert(rlt.mess, {icon: 6});
									parent.refreshVehList();
								}else{
									layer.alert(rlt.mess, {icon: 5});
								}
								
								
								try {
									//刷新父页面列表
									if(opr=='e'){
										parent.refreshVehList();
									}else{
										parent.reQueryVehList();
									}
								} catch (e) {}
							}
						});
					}
				}
			});
			//用车评价打分
			function clk(tt,lx){
				if(tt==1){
					var tp=document.getElementById("star"+lx+1).style.color;
					if(tp==""){
						document.getElementById("star"+lx+1).style.color="#fee866";
						document.getElementById("pf"+lx).value=tt;
					}else if(tp=="#fee866"){
						for(var ss=1;ss<=length;ss++){
							document.getElementById("star"+lx+ss).style.color="";
							document.getElementById("pf"+lx).value="";
						}
					}else if(tp=="rgb(254, 232, 102)"){
						for(var ss=1;ss<=length;ss++){
							document.getElementById("star"+lx+ss).style.color="";
							document.getElementById("pf"+lx).value="";
						}
					}
				}else{
					//清除所有星星的样式
					for(var a=1;a<=length;a++){
						document.getElementById("star"+lx+a).style.color="";
						document.getElementById("pf"+lx).value="";
					}
					//循环设置星星样式
					for(var j=1;j<=tt;j++){
						document.getElementById("star"+lx+j).style.color="#fee866";
						document.getElementById("pf"+lx).value=tt;
					}
				}
			}
		</script>
	</head>

	<body style="overflow: hidden;">
		<form id="mainForm" name="mainForm" method="post" class="layui-form">
			<input type="hidden" id="opr" name="opr" value="${opr }"/>
			<input type="hidden" id="pjr" name="pjr" value="${userSession.user.xm }">
			<input type="hidden" value="${obj.vehpj }" id="pfv" name="vehpj">
			<input type="hidden" value="${obj.drvpj }" id="pfd" name="drvpj">
			<input type="hidden" value="" id="lshh" name="lsh">
			<input type="hidden" value="" id="hpzlh" name="hpzl">
			<input type="hidden" value="" id="hphmh" name="hphm">
			<input type="hidden" value="" id="ywlxh" name="ywlx">
			<input type="hidden" value="" id="ywyyh" name="ywyy">
			
			<input type="hidden" value="${obj.jsyxm }" id="jsyxm" name="jsyxm">
			<input type="hidden" value="${obj.jsyzjhm }" id="jsyzjhm" name="jsyzjhm">
			<div style="padding-left:15px;padding-right:15px;">
				<div style="margin-top: 10px;color: #3C8DBC;border-bottom: 1px solid #3C8DBC;line-height: 10px;height: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;业务信息</div>
				<div class="frm-row" style="margin-top: 10px;">
					<label class="frm-label frm-col-4 colmr">流水号</label>
					<div class="frm-col-8 frm-text" id="lsh">${obj.lsh }</div>
					<label class="frm-label frm-col-4 colmr">业务原因</label>
					<div class="frm-col-8 frm-text" id="ywyy"></div>
				</div>
				<div class="frm-row" style="margin-top: 10px;">
					<label class="frm-label frm-col-4">开始时间</label>
					<div class="frm-col-8 frm-text" id="kssj"></div>
					<label class="frm-label frm-col-4">结束时间</label>
					<div class="frm-col-8 frm-text" id="jssj"></div>
				</div>
				<div class="frm-row" style="margin-top: 10px;">
					<label class="frm-label frm-col-4">开始地址</label>
					<div class="frm-col-8 frm-text" id="ksdz">${flow.ksdz }</div>
					<label class="frm-label frm-col-4">到达地址</label>
					<div class="frm-col-8 frm-text" id="dddz">${flow.dddz }</div>
				</div>
				<div class="frm-row" style="margin-top: 10px;">
					<label class="frm-label frm-col-4">号牌种类</label>
					<div class="frm-col-8 frm-text" id="hpzl"></div>
					<label class="frm-label frm-col-4">号牌号码</label>
					<div class="frm-col-8 frm-text" id="hphm">${obj.hphm }</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-4">驾驶员姓名</label>
					<div class="frm-col-8 frm-text" id="jsyxms">${obj.jsyxm }</div>
					<label class="frm-label frm-col-4">驾驶员证件号码</label>
					<div class="frm-col-8 frm-text" id="jsyzjhms">${obj.jsyzjhm }</div>
				</div>
				<div style="color: #3C8DBC;border-bottom: 1px solid #3C8DBC;line-height: 10px;height: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;用户评价</div>
				<div class="frm-row" style="margin-top: 10px;">
					<label class="frm-label frm-col-4">车辆评价</label>
					<div class="frm-col-8" style="height:32px;line-height:32px;">
						<div id="vehpf">
						</div>
					</div>
					<label class="frm-label frm-col-4">驾驶员评价</label>
					<div class="frm-col-8" style="height:32px;line-height:32px;">
						<div id="drvpf">
						</div>
					</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-4">评价内容</label>
					<div class="frm-col-20">
						<input type="text" id="pjnr" name="pjnr" value="${obj.pjnr }" maxlength="256" placeholder="请输入评价内容" class="layui-input">
					</div>
				</div>
					
				<div class="frm-row">
					<div class="frm-col-23" style="text-align: right">
							<a href="javascript:;" class="layui-btn layui-btn-small" id="car-save" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#xe605;</i> 保存</a>
							<a href="javascript:;" class="layui-btn layui-btn-small" id="car-close" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					</div>
				</div>
			</div>
		</form>
	</body>
</html>
