<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>公务用车编辑</title>
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
				Tools:	'common/js/Tools',
				hrefTools:	'common/js/hrefTools',
				jqueryform:	'common/js/jquery.form'
			}).use(['element','form','laydate','ajaxTools','glbmSelect','domTools','hrefTools','jqueryform','Tools'],function(){
				var $ = jquery = layui.jquery,
				element = layui.element(),
				ajaxTools  = layui.ajaxTools,
				domTools = layui.domTools,
				hrefTools = layui.hrefTools,
				Tools = layui.Tools,
				form = layui.form();
				
				$(function(){
					$('#div-ywlx').html(formateYwlx('${ft.ywlx}'));
					$('#div-ywyy').html(formateYwYy('${ft.ywyy}','${ft.ywlx}'));
					$('#div-glbm').html(formateGlbm_jc('${ft.glbm}'));
					$('#car-kssj').val(formateLongDate('${ft.kssj}'));
					$('#car-jssj').val(formateLongDate('${ft.jssj}'));
					var hphm='${ft.hphm}';
					if(hphm!=''){
						$('#hm').val(hphm.substring(2));
					}
				})
				//车辆类型选择下拉框事件
				ajaxTools.loadCodeDataKK($('#car-cllx'),{dmmc:'cllx'},false,'${ft.cllx}','code.do?method=selectListCode','请选择车辆类型');
				form.render('select')
				
				var fzjg = '<%=Constant.SYS_PARAM.get("bdfzjg") %>';
				document.getElementById("veh-bdfzjg").value=fzjg;
					//获取时间差
				$('#car-sxsj').on('click',function(){
					Tools.getsjc($('#car-kssj').val(),$('#car-jssj').val(),'car-sxsj');
				});
				$('#car-save').on('click', function() {
					saveflow();
				});
				$('#car-close').on('click', function() {
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭
				});
				$('#hphmbd').on('click',function(){
				 if($('#hphmbd').attr('disabled')=="disabled"){
						return;
					}
					var glbm=$('#glbm').val();
					var syrs=$('#car-syrs').val();
					var cllx=$('#car-cllx').val();
					var syrq=$('#car-kssj').val();
					if(glbm==""||syrs==""||cllx==""||syrq==""){
						layer.alert("请选择申请单位,车辆类型，填写使用人数及使用日期", {icon: 5});
						return;
					}
					var condition = "&bj=2&glbm="+glbm+"&syrs="+syrs+"&cllx="+cllx+"&syrq="+syrq;
					title="机动车信息";
					tjymtz(condition,title);
				});
				$('#jsrybd').on('click',function(){
				if($('#jsrybd').attr('disabled')=="disabled"){
						return;
					}
				
					var glbm=$('#glbm').val();
					if(glbm==""){
						layer.alert("请选择申请单位", {icon: 5});
						return;
					}
					var condition = "&bj=1&glbm="+glbm;
					title="驾驶员信息"
					tjymtz(condition,title);
				});
				function tjymtz(condition,title){
					layer.open({
						type: 2,
						id:'ReqEdit',
						content:['flow.do?method=forwardReqPageForTj'+condition],
						title: title, /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
						shade: 0.2,
// 						offset: ['30px', '15%'],
						area: ['950px', '500px'],
						zIndex: 10000000,
						moveOut: true,
						maxmin: false,
						btn: 0 	//['新增','保存', '取消']
					});
				}
					
				form.on('radio(jdcradio)', function(data){
				  if(data.value=="0"){
				  	$('#car-cllx').attr("disabled",true);
				  	ajaxTools.loadCodeDataKK($('#car-cllx'),{dmmc:'cllx'},false,'','code.do?method=selectListCode','请选择车辆类型');
					form.render('select');
					$('#hm').val("");
				  	$('#hm').attr("disabled",true);
				  	$('#hphmbd').attr("disabled",true);
				  }else{
				  	$('#hm').attr("disabled",false);
				  	$('#car-cllx').attr("disabled",false);
				  	ajaxTools.loadCodeDataKK($('#car-cllx'),{dmmc:'cllx'},false,'','code.do?method=selectListCode','请选择车辆类型');
					form.render('select');
				  	$('#hphmbd').attr("disabled",false);
				  }
				});
				
			     
			form.on('radio(jsyradio)', function(data){
				  if(data.value=="0"){
				  	$('#car-jsryzjhm').val("");
				  	$('#car-jsryzjhm').attr("disabled",true);
				  	$('#car-jsry').val("");
				  	$('#car-jsry').attr("disabled",true);
				  	$('#jsrybd').attr('disabled',true);
				  }else{
				  	$('#car-jsryzjhm').attr("disabled",false);
				  	$('#car-jsry').attr("disabled",false);
				  	$('#jsrybd').attr('disabled',false);
				  }
				});
				
				
 				function sfzdz(){
 					var jdcval=$('input:radio[name="sfzdjdc"]:checked').val();
 					var jsyval=$('input:radio[name="sfzdjsy"]:checked').val();
 					if(jdcval=='1'){
 						if($('#car-cllx').val()==""||""==$('#hm').val()){
 							layer.alert("请编写车辆类型及号牌号码", {icon: 5});
 							return true;
 						}
 					}
 					if(jsyval=='1'){
 						if($('#car-jsryzjhm').val()==""||""==$('#car-jsry').val()){
 							layer.alert("请编写驾驶员姓名及证件号码", {icon: 5});
 							return true;
 						}
 					}
 				}
				function saveflow(){
					if(sfzdz()){
						return;
					}
					if(form.verifyForm(mainForm)){//form.verifyForm返回true表示表单验证成功
						var hphm = $('#veh-bdfzjg').val()+$('#hm').val();
						if(hphm.length>3){
						$('#hphm').val(hphm);
						}
						$(mainForm).ajaxSubmit({
							type:'POST',
							url:'flow.do',
							data:{
								method:'updateGovFlowTemp',
								//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
								cxdh:'020108',
								gnid:'02010801'
							},
							dataType:'json',
							success:function(rlt){
								if(rlt.code=='1'){
									layer.alert(rlt.mess, {icon: 6});
								}else{
									layer.alert(rlt.mess, {icon: 5});
								}
								
							}
						});
					}
				}
				$('#car-kssj').blur(function(){$('#car-sxsj').val("")})
				$('#car-jssj').blur(function(){$('#car-sxsj').val("")})
			});
		</script>
		<script type="text/javascript">
			function setZs(zs1,zs2,bj,zs3){
				if(bj=="1"){
					document.getElementById("car-jsry").value=zs2;
					document.getElementById("car-jsryzjhm").value=zs1;
				}else{
 					zs1=zs1.substring(2)
					document.getElementById("hm").value=zs1;
					document.getElementById("car-hpzl").value=zs2;
				}
			}
		</script>
	</head>

	<body>
		<form id="mainForm" name="mainForm" method="post" class="layui-form">
		<input type="hidden" id="hphm" name="hphm" value="">
		<input type="hidden" id="glbm" name="glbm" value="${ft.glbm }">
		<input type="hidden" id="lsh" name="lsh" value="${ft.lsh }">
		<input type="hidden" id="ywlx" name="ywlx" value="${ft.ywlx }">
		<input type="hidden" id="ywyy" name="ywyy" value="${ft.ywyy }">
		<input type="hidden" id="bz" name="bz" value="${ywgw}">
		<input type="hidden" id="jbr" name="jbr" value="${userSession.user.xm }">
		<div class="frm-row">
			<label class="frm-label frm-col-4">业务类型</label>
			<div class="frm-col-5 frm-text" id="div-ywlx">${ft.ywlx }</div>
			<label class="frm-label frm-col-3">业务原因</label>
			<div class="frm-col-11 frm-text" id="div-ywyy">${ft.ywyy }</div>
		</div>
		<div class="frm-row">
			<label class="frm-label frm-col-4">申请单位</label>
			<div class="frm-col-5 frm-text" id="div-glbm">${ft.glbm }</div>
			<label class="frm-label frm-col-3">申请人</label>
			<div class="frm-col-11 frm-text" id="div-sqry">${ft.sqry }</div>
		</div>
		<div class="frm-row">
			<label class="frm-label frm-col-4">使用人数</label>
			<div class="frm-col-5">
				<input type="text" id="car-syrs" name="syrs"  value="${ft.syrs }" placeholder="请输入使用人数"  lay-verify="number" maxlength="4"  class="frm-input cle" style="width: 82%;float:left;">
				<input type="text"  value="人" readonly style="width: 18%;float:left;" class="layui-input">
			</div>
			<label class="frm-label frm-col-3">使用人员</label>
			<div class="frm-col-11">
				<input type="text" id="car-syry" name="syry" value="${ft.syry }" lay-verify="required" placeholder="多个人员用英文,隔开" maxlength="60"   class="layui-input cle" >
			</div>
		</div>
		<div class="frm-row">
			<label class="frm-label frm-col-4">使用人员联系电话</label>
			<div class="frm-col-5">
				<input type="text" id="car-syrylxdh" name="syrylxdh"   value="${ft.syrylxdh }" maxlength="120" placeholder="多个人员用英文,隔开" class="layui-input cle" >
			</div>
			<label class="frm-label frm-col-3">使用人员证件号码</label>
			<div class="frm-col-11">
				<input type="text" id="car-syryzjhm" name="syryzjhm"  value="${ft.syryzjhm }" maxlength="120" placeholder="多个人员用英文,隔开"   class="frm-input cle">
			</div>
		</div>
		
		<div class="frm-row">
			<label class="frm-label frm-col-4">开始时间</label>
			<div class="frm-col-5">
				<input type="text" id="car-kssj" name="kssj" lay-verify="required" class="layui-input cle" value="" placeholder="请编写如1990/11/11 12:12:12"  onclick="layui.laydate({elem: this, istime: true, format: 'YYYY/MM/DD hh:mm:ss'})">
			</div>
			<label class="frm-label frm-col-3">结束时间</label>
			<div class="frm-col-4">
				<input type="text" id="car-jssj" name="jssj" lay-verify="required"  placeholder="请编写如1990/11/11 12:12:12" value="" class="layui-input cle" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY/MM/DD hh:mm:ss'})">
			</div>
			<label class="frm-label frm-col-3">需要用时</label>
			<div class="frm-col-4">
				<input type="text" id="car-sxsj" name="sxsj" readonly  class="layui-input cle" value="${ft.sxsj }" lay-verify="required" placeholder="请输入需要时间 " style="width: 75%;float:left;">
				<input type="text"  value="小时" readonly style="width: 25%;float:left;" class="layui-input">
			</div>
		</div>
		<div class="frm-row">
			<label class="frm-label frm-col-4">出发地点</label>
			<div class="frm-col-5">
				<input type="text" id="car-ksdz" name="ksdz" lay-verify="required" maxlength="60"  class="frm-input cle" value="${ft.ksdz }" placeholder="请输入出发 地点">
			</div>
			<label class="frm-label frm-col-3">途径地点</label>
			<div class="frm-col-4">
				<input type="text" id="car-tjdd" name="tjdz"  maxlength="60"  class="layui-input cle" value="${ft.tjdz }" placeholder="请输入途径地点">
			</div>
			<label class="frm-label frm-col-3">到达地点</label>
			<div class="frm-col-4">
				<input type="text" id="car-dddz" name="dddz" maxlength="60" value="${ft.dddz }" lay-verify="required" placeholder="请输入到达地点"  class="frm-input cle">
			</div>
		</div>
		<div class="frm-row">
			<label class="frm-label frm-col-4">任务内容</label>
			<div class="frm-col-19">
				<input type="text" id="car-rwnr" name="rwnr" lay-verify="required" maxlength="248" placeholder="请输入任务内容" value="${ft.rwnr }"  class="layui-input cle" >
			</div>
		</div>
		<div class="frm-row">
			<label class="frm-label frm-col-4">是否指定机动车</label>
			<div class="frm-col-5">
				<input name="sfzdjdc"  value="1" title="是" type="radio" ${ft.sfzdjdc==1?'checked':'' } lay-filter="jdcradio">
				<input name="sfzdjdc"  value="0" title="否" type="radio"  ${ft.sfzdjdc==0?'checked':'' } checked lay-filter="jdcradio">
			</div>
			<label class="frm-label frm-col-3">车辆类型</label>
			<div class="frm-col-4">
				<select id="car-cllx" name="cllx"  disabled>
				        <option value="">请选择</option>
				</select>
			</div>
			<label class="frm-label frm-col-3">号牌号码</label>
			<div class="frm-col-4">
				<input type="hidden" id="car-hpzl" value="" name="hpzl"  class="layui-input cle">
				<input type="text" id="veh-bdfzjg" value="" readonly  class="layui-input" style="width: 21%;float:left;">
				<input type="text" id="hm" value="" onkeyup="this.value=this.value.toUpperCase()" maxlength="5"   style="width:49%;float:left;" placeholder="请输入号牌号码" class="layui-input cle">
				<a href="javascript:;" class="layui-btn layui-btn-small" id="hphmbd" style="width:30%;float:left;margin-top: 1px;" disabled><i class="layui-icon" >&#xe615;</i> 推荐</a>
			</div>
		</div>
		<div class="frm-row">
			<label class="frm-label frm-col-4">是否指定驾驶员</label>
			<div class="frm-col-5">
				<input name="sfzdjsy"  value="1" title="是" type="radio" ${ft.sfzdjsy==1?'checked':'' } lay-filter="jsyradio" >
				<input name="sfzdjsy"  value="0" title="否" type="radio" ${ft.sfzdjsy==0?'checked':'' } checked lay-filter="jsyradio" >
			</div>
			<label class="frm-label frm-col-3">驾驶员证件号码</label>
			<div class="frm-col-4">
				<input type="text" id="car-jsryzjhm" name="jsryzjhm" disabled maxlength="18"   value="${ft.jsryzjhm }" placeholder="请输入驾驶员证件号码"  class="frm-input cle">
			</div>
			<label class="frm-label frm-col-3">驾驶员姓名</label>
			<div class="frm-col-4">
				<input type="text" id="car-jsry" name="jsry" value="${ft.jsry }"   maxlength="15"  placeholder="请输入驾驶员姓名" class="layui-input cle" style="width:70%;float:left;">
				
				<a href="javascript:;" class="layui-btn layui-btn-small" id="jsrybd" style="width:30%;float:left;margin-top: 1px;" disabled><i class="layui-icon" >&#xe615;</i> 推荐</a>
			</div>
		</div>
		<div class="frm-row">
			<div class="frm-col-23" style="text-align: right">
					<a href="javascript:;" class="layui-btn layui-btn-small" id="car-save" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#xe605;</i> 保存</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="car-close" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#x1006;</i> 关闭</a>
			</div>
		</div>
		</form>
	</body>
</html>
