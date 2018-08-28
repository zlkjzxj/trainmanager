<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>车辆出场信息编辑</title>
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
				
				//车辆类型选择下拉框事件
				$(function (){
					$("#ywlx").html(formateYwlx('${obj.ywlx}'));
					$("#ywyy").html(formateYwYy('${obj.ywyy}','${obj.ywlx}'));
					$("#glbm").html(formateGlbm_jc('${obj.glbm}'));
					$("#sqrq").html(formateShortDate('${obj.sqrq}'));
					$("#kssj").html(formateLongDate('${obj.kssj}'));
					$("#jssj").html(formateLongDate('${obj.jssj}'));
					if('${obj.ywlx}'=="A"){
						$("#car-cllx1").html(formateCllx('${obj.cllx}'));
					}else{
						$("#car-cllx2").html(formateCllx('${obj.cllx}'));
					}
				})
				
				$('#car-save').on('click', function() {
					saveflow();
				});
				$('#car-close').on('click', function() {
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭
				});
		        function saveflow(){
					if($('#car-save').attr('disabled')=="disabled"){
						return;
					}
					var ywlx = $('#ywlxh').val()
					var gnid="";
					if('A'==ywlx){
						gnid="02010501";
					}else{
						gnid="02010502";
					}
					if($("#car-sxsj").val()==""){
						$("#car-sxsjs").val($("#sxsjs").val())
					}else{
						$("#car-sxsjs").val($("#car-sxsj").val())
					}
					$(mainForm).ajaxSubmit({
						type:'POST',
						url:'govStart.do',
						data:{
							method:'saveGovStart',
							//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
							cxdh:'020105',
							gnid:gnid
						},
						dataType:'json',
						success:function(rlt){
							if(rlt.code=='1'){
								$('#car-save').css({ background: "#F2F2F2",color:"gray"});
								$('#car-save').attr('disabled',true);
								layer.alert(rlt.mess, {icon: 6});
								parent.refreshBackList();
							}else{
								layer.alert(rlt.mess, {icon: 5});
							}
							
						}
					});
				}
			});
		</script>
	</head>

	<body style="overflow: auto">
		<form id="mainForm" name="mainForm" method="post" class="layui-form">
			<input type="hidden" value="${obj.lsh }" id="lshh" name="lsh">
			<input type="hidden" value="${obj.hpzl }" id="hpzlh" name="hpzl">
			<input type="hidden" value="${obj.hphm }" id="hphmh" name="hphm">
			<input type="hidden" value="${obj.jsry }" id="jsryh" name="jsry">
			<input type="hidden" value="${obj.jsryzjhm }" id="jsryzjhmh" name="jsryzjhm">
			<input type="hidden" value="${obj.ywlx }" id="ywlxh" name="ywlx">
			<input type="hidden" value="${obj.ywyy }" id="ywyyh" name="ywyy">
			<input type="hidden" value="${obj.glbm }" id="glbmh" name="glbm">
			<input type="hidden" value="${obj.sqry }" id="sqryh" name="sqry">
			<input type="hidden" value="${obj.syry }" id="syryh" name="syry">
			<input type="hidden" value="${obj.syrs }" id="syrsh" name="syrs">
			<input type="hidden" value="${obj.rwnr }" id="rwnrh" name="rwnr">
			<input type="hidden" value="${obj.ksdz }" id="ksdzh" name="ksdz">
			<input type="hidden" value="${obj.dddz }" id="dddzh" name="dddz">
			<input type="hidden" value="${obj.tjdz }" id="tjdzh" name="tjdz">
			<input type="hidden" value="${obj.sxsj }" id="sxsjs">
			<input type="hidden" value="${obj.kssj }" id="kssjh" name="kssj">
			<input type="hidden" value="${obj.jssj }" id="jssjh" name="jssj">
			<input type="hidden" value="${obj.wxdwbh }" id="wxdwbhh" name="wxdwbh">
			<input type="hidden" value="${obj.wxdwmc }" id="wxdwmch" name="wxdwmc">
			<input type="hidden" value="${obj.xgfy }" id="xgfyh" name="xgfy">
			<div style="margin-top: 10px;color: #3C8DBC;border-bottom: 1px solid #3C8DBC;line-height: 10px;height: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;业务信息</div>
			<div class="frm-row" style="margin-top: 10px;">
				<label class="frm-label frm-col-3 colmr">流水号</label>
				<div class="frm-col-5 frm-text">${obj.lsh }</div>
				<label class="frm-label frm-col-3 colmr">业务类型</label>
				<div class="frm-col-5 frm-text" id="ywlx">
				</div>
				<label class="frm-label frm-col-3 colmr">业务原因</label>
				<div class="frm-col-4 frm-text" id="ywyy">
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-3 colmr">申请单位</label>
				<div class="frm-col-5 frm-text" id="glbm">
				</div>
				<label class="frm-label frm-col-3 colmr">申请人</label>
				<div class="frm-col-5 frm-text">${obj.sqry }</div>
				<label class="frm-label frm-col-3 colmr">申请日期</label>
				<div class="frm-col-4 frm-text" id="sqrq">
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-3 colmr">开始时间</label>
				<div class="frm-col-5 frm-text" id="kssj">
				</div>
				<label class="frm-label frm-col-3 colmr">结束时间</label>
				<div class="frm-col-5 frm-text" id="jssj"></div>
				<label class="frm-label frm-col-3 colmr">需要用时</label>
				<div class="frm-col-4 frm-text">${obj.sxsj }小时</div>
			</div>
			<c:if test="${obj.ywlx=='A' }">
				<div class="frm-row">
					<label class="frm-label frm-col-3 colmr">出发地</label>
					<div class="frm-col-5 frm-text">${obj.ksdz }</div>
					<label class="frm-label frm-col-3 colmr">途径地</label>
					<div class="frm-col-5 frm-text">${obj.tjdz }</div>
					<label class="frm-label frm-col-3 colmr">到达地</label>
					<div class="frm-col-4 frm-text">${obj.dddz }</div>
				</div>
				
				<div class="frm-row" style="margin-top: 10px;">
					<label class="frm-label  frm-col-3 colmr">使用人数</label>
					<div class="frm-col-5 frm-text">${obj.syrs }人</div>
					<label class="frm-label frm-col-3">车辆类型</label>
					<div class="frm-col-5 frm-text" id="car-cllx1"></div>
					<label class="frm-label frm-col-3">号牌号码</label>
					<div class="frm-col-4 frm-text">${obj.hphm }</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3">驾驶员证件号码</label>
					<div class="frm-col-5 frm-text">${obj.jsryzjhm }</div>
					<label class="frm-label frm-col-3">驾驶员姓名</label>
					<div class="frm-col-5 frm-text">${obj.jsry }</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3 colmr">使用人员</label>
					<div class="frm-col-20 frm-text">${obj.syry }</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3 colmr">任务内容</label>
					<div class="frm-col-20 frm-textS">${obj.rwnr }</div>
				</div>
			</c:if>
			<c:if test="${obj.ywlx=='B' }">
				<div class="frm-row">
					<label class="frm-label frm-col-3">驾驶员证件号码</label>
					<div class="frm-col-5 frm-text">${obj.jsryzjhm }</div>
					<label class="frm-label frm-col-3">驾驶员姓名</label>
					<div class="frm-col-5 frm-text">${obj.jsry }</div>
<!-- 					<label class="frm-label frm-col-3">相关费用</label> -->
<!-- 					<div class="frm-col-4 frm-text">${obj.xgfy }元</div> -->
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3">车辆类型</label>
					<div class="frm-col-5 frm-text" id="car-cllx2"></div>
					<label class="frm-label frm-col-3">号牌号码</label>
					<div class="frm-col-5 frm-text">${obj.hphm }</div>
				</div>
				<c:if test="${obj.ywyy=='B'|| obj.ywyy=='A'}">
					<div class="frm-row">
						<label class="frm-label frm-col-3">维修单位编号</label>
						<div class="frm-col-5 frm-text">${obj.wxdwbh }
						</div>
						<label class="frm-label frm-col-3">维修单位名称</label>
						<div class="frm-col-5 frm-text">${obj.wxdwmc }</div>
					</div>
				</c:if>
				<div class="frm-row">
					<label class="frm-label frm-col-3 colmr">原因说明</label>
					<div class="frm-col-20 frm-textS">${obj.rwnr }</div>
				</div>
			</c:if>
			<div class="frm-row">
				<div class="frm-col-23" style="text-align: right">
				     <a href="javascript:;" class="layui-btn layui-btn-small" id="car-save" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#xe605;</i> 车辆出场</a>
					 <a href="javascript:;" class="layui-btn layui-btn-small" id="car-close" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#x1006;</i> 关闭</a>
				</div>
			</div>
		</form>
	</body>
</html>
