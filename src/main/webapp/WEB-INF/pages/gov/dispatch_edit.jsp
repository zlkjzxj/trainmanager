<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>智能派车编辑</title>
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
				ajaxTools.loadCodeForRadio($('#ywyy-div'),'ywyy',{gldmmc:'ywlx',gldm:$('#ywlx').val()},false,'A','');
				form.render('radio');
				$('#main_ywlxstr').val(formateYwlx($('#ywlx').val()));
				
				//车辆类型选择下拉框事件
				ajaxTools.loadCodeDataKK($('#car-cllx'),{dmmc:'cllx'},false,'','code.do?method=selectListCode','请选择车辆类型');
				form.render('select')
				$(function (){
					$("#ywlx").html(formateYwlx('${obj.ywlx}'));
					$("#ywyy").html(formateYwYy('${obj.ywyy}','${obj.ywlx}'));
					$("#glbm").html(formateGlbm_jc('${obj.glbm}'));
					$("#sqrq").html(formateShortDate('${obj.sqrq}'));
					$("#kssj").html(formateLongDate('${obj.kssj}'));
					$("#jssj").html(formateLongDate('${obj.jssj}'));
					$("#hm").val('${obj.hphm}'.substring(2));
					if('${obj.cllx}'!=""){
						$("#car-cllx").val('${obj.cllx}');
						form.render('select');
					}
				})
				var fzjg = '<%=Constant.SYS_PARAM.get("bdfzjg") %>';
				document.getElementById("veh-bdfzjg").value=fzjg;
				
				$('#hphmbd').on('click',function(){
					var lsh=$('#lsh').val();
					var cllx=$('#car-cllx').val();
					var condition = "&bj=7&glbm="+lsh+"&cllx="+cllx;
					title="机动车信息";
					tjymtz(condition,title);
				});
				$('#jsrybd').on('click',function(){
					var lsh=$('#lsh').val();
					var condition = "&bj=6&glbm="+lsh;
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
						//offset: ['30px', '15%'],
						area: ['950px', '500px'],
						zIndex: 10000000,
						moveOut: true,
						maxmin: false,
						btn: 0 	//['新增','保存', '取消']
					});
				}
				window.setZs = function(zs1,zs2,bj,zs3){
					if(bj=="6"){
						document.getElementById("car-jsry").value=zs2;
						document.getElementById("car-jsryzjhm").value=zs1;
					}else{
	 					zs1=zs1.substring(2);
						document.getElementById("hm").value=zs1;
						document.getElementById("car-hpzl").value=zs2;
						document.getElementById("car-cllx").value=zs3;
						form.render('select')
					}
				}
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
// 					alert($('#car-cllx').text());
					var cllxtext=$("select option:selected").text();
// 					return
					if(form.verifyForm(mainForm)){//form.verifyForm返回true表示表单验证成功
						var hphm = $('#veh-bdfzjg').val()+$('#hm').val();
						$('#hphm').val(hphm);
						$(mainForm).ajaxSubmit({
							type:'POST',
							url:'dispatch.do',
							data:{
								method:'saveGovDispatch',
								cllxtext:cllxtext,
								//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
								cxdh:'020104',
								gnid:'02010401'
							},
							dataType:'json',
							success:function(rlt){
								if(rlt.code=='1'){
									$('#car-save').css({ background: "#F2F2F2",color:"gray"});
									$('#car-save').attr('disabled',true);
									layer.alert(rlt.mess, {icon: 6});
									parent.refreshDispatchList();
								}else{
									layer.alert(rlt.mess, {icon: 5});
								}
								
							}
						});
					}
				}
			});
		</script>
	</head>

	<body style="overflow: auto">
		<form id="mainForm" name="mainForm" method="post" class="layui-form">
				<div style="margin-top: 10px;color: #3C8DBC;border-bottom: 1px solid #3C8DBC;line-height: 10px;height: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;业务信息</div>
			<div class="frm-row" style="margin-top: 10px;">
				<label class="frm-label frm-col-3 colmr">流水号</label>
				<div class="frm-col-5 frm-text">${obj.lsh }</div>
				<input type="hidden" value="${obj.lsh }" id="lsh" name="lsh">
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
			<div class="frm-row">
				<label class="frm-label frm-col-3 colmr">出发地</label>
				<div class="frm-col-5 frm-text">${obj.ksdz }</div>
				<label class="frm-label frm-col-3 colmr">途径地</label>
				<div class="frm-col-5 frm-text">${obj.tjdz }</div>
				<label class="frm-label frm-col-3 colmr">到达地</label>
				<div class="frm-col-4 frm-text">${obj.dddz }</div>
			</div>
			<div class="frm-row">
			<label class="frm-label frm-col-3 colmr">任务内容</label>
			<div class="frm-col-20 frm-textS">${obj.rwnr }</div>
		</div>
			<div class="frm-row">
				<label class="frm-label  frm-col-3 colmr">使用人数</label>
				<div class="frm-col-5 frm-text">${obj.syrs }人</div>
				<label class="frm-label frm-col-3 colmr">使用人员</label>
				<div class="frm-col-12 frm-text">${obj.syry }</div>
			</div>
			<div style="color: #3C8DBC;border-bottom: 1px solid #3C8DBC;line-height: 10px;height: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;推荐信息</div>
			<div class="frm-row" style="margin-top: 10px;">
				<label class="frm-label frm-col-3">车辆类型</label>
				<div class="frm-col-5">
					<select id="car-cllx" name="cllx" lay-verify="required">
					        <option value="">请选择</option>
					</select>
				</div>
				<label class="frm-label frm-col-3">号牌号码</label>
				<div class="frm-col-5">
					<input type="hidden" id="hphm" name="hphm" value="">
					<input type="hidden"  name="ksdate" value="${obj.kssj }">
					<input type="hidden"  name="sqry" value="${obj.sqry }">
					<input type="hidden"  name="glbm" value="${obj.glbm }">
					<input type="hidden" id="car-hpzl" value="" name="hpzl"  class="layui-input cle">
					<input type="text" id="veh-bdfzjg" value="" readonly  class="layui-input" style="width: 20%;float:left;">
					<input type="text" id="hm" value=""  maxlength="5" onkeyup="this.value=this.value.toUpperCase()"   lay-verify="required" style="width: 53%;float:left;" placeholder="请输入号牌号码" class="layui-input cle">
					<a href="javascript:;" class="layui-btn layui-btn-small" id="hphmbd" style="width:27%;float:left;margin-top: 1px;"><i class="layui-icon" >&#xe615;</i> 推荐</a>
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-3">驾驶员证件号码</label>
				<div class="frm-col-5">
					<input type="text" id="car-jsryzjhm" name="jsryzjhm"  maxlength="18" lay-verify="identity"   value="${obj.jsryzjhm }" placeholder="请输入驾驶员证件号码"  class="frm-input cle">
				</div>
				<label class="frm-label frm-col-3">驾驶员姓名</label>
				<div class="frm-col-5">
					<input type="text" id="car-jsry" name="jsry" lay-verify="required" value="${obj.jsry}"  maxlength="10"  placeholder="请输入驾驶员姓名" class="layui-input cle" style="width:73%;float:left;">
					<a href="javascript:;" class="layui-btn layui-btn-small" id="jsrybd" style="width:27%;float:left;margin-top: 1px;"><i class="layui-icon" >&#xe615;</i> 推荐</a>
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
