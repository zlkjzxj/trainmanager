<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>机动车处置申请</title>
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
				
				//初始换管理部门下拉选择框
// 				var glbmSelect = layui.glbmSelect({bgColor:'#F9FAFC',area:['200px','100px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
// 				$('#us-glbm').on('click',function(){
// 					glbmSelect.show($('#us-glbm'),function(node){
// 						$('#us-glbm').val(node.name);
// 						$('#hidden-us-glbm').val(node.tags.glbm);
// 					},$('#hidden-us-glbm').val());
// 				});
				//车辆类型选择下拉框事件
				ajaxTools.loadCodeDataKK($('#car-cllx'),{dmmc:'cllx'},false,'','code.do?method=selectListCode','请选择车辆类型');
				form.render('select')
				
				var fzjg = '<%=Constant.SYS_PARAM.get("bdfzjg") %>';
				document.getElementById("veh-bdfzjg").value=fzjg;
				
				$('#hphmbd').on('click',function(){
					var glbm=$('#hidden-us-glbm').val();
					var cllx=$('#car-cllx').val();
					if(glbm==""||cllx==""){
						layer.alert("请选择申请单位,车辆类型", {icon: 5});
						return;
					}
					var condition = "&bj=5&glbm="+glbm+"&cllx="+cllx;
					title="机动车信息";
					tjymtz(condition,title);
				});
				function tjymtz(condition,title){
					layer.open({
						type: 2,
						id:'ReqEdit',
						content:['flow.do?method=forwardReqPageForTj'+condition],
						title: title, /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
						shade: 0.2,
						offset: ['30px', '15%'],
						area: ['1000px', '500px'],
						zIndex: 10000000,
						moveOut: true,
						maxmin: false,
						btn: 0 	//['新增','保存', '取消']
					});
				}
				
// 				$('#car-sxsj').on('click',function(){
// 					Tools.getsjc($('#car-kssj').val(),$('#car-jssj').val(),'car-sxsj');
// 				});
				$('#car-save').on('click', function() {
					saveflow();
				});
				$('#car-clear').on('click', function() {
					$('.cle').val(""); 
					$('input:radio[name="ywyy"][value="A"]').prop('checked', true);
					form.render('radio');
					$('#car-save').css({ background: "#4F98C2",color:"#FEFEFE"});
					$('#car-save').attr('disabled',false); 
				});
				
				function saveflow(){
					if($('#car-save').attr('disabled')=="disabled"){
						return;
					}
					if(form.verifyForm(mainForm)){//form.verifyForm返回true表示表单验证成功
						var hphm = $('#veh-bdfzjg').val()+$('#hm').val();
						$('#hphm').val(hphm);
						$('#car-save').css({ background: "#F2F2F2",color:"gray"});
						$('#car-save').attr('disabled',true);
						$(mainForm).ajaxSubmit({
							type:'POST',
							url:'flow.do',
							data:{
								method:'saveGovFlow',
								//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
								cxdh:'020101',
								gnid:'02010104'
							},
							dataType:'json',
							success:function(rlt){
								if(rlt.code=='1'){
// 									$('#car-save').css({ background: "#F2F2F2",color:"gray"});
// 									$('#car-save').attr('disabled',true);
									layer.alert(rlt.mess, {icon: 6});
								}else{
									$('#car-save').css({ background: "#4F98C2",color:"#FEFEFE"});
									$('#car-save').attr('disabled',false);
									layer.alert(rlt.mess, {icon: 5});
								}
								
							}
						});
					}
				}
// 				$('#car-kssj').blur(function(){$('#car-sxsj').val("")})
// 				$('#car-jssj').blur(function(){$('#car-sxsj').val("")})
			});
		</script>
		<script type="text/javascript">
			function setZs(zs1,zs2,bj,zs3){
 					zs1=zs1.substring(2)
					document.getElementById("hm").value=zs1;
					document.getElementById("car-hpzl").value=zs2;
			}
		</script>	
	</head>

	<body>
		<form id="mainForm" name="mainForm" method="post" class="layui-form">
			<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
			<input type="hidden" id="yhdh" name="yhdh" value="${userSession.user.yhdh }">
			<input type="hidden" id="ywlx" name="ywlx" value="${ywlx }">
			<input type="hidden" id="sjly" name="sjly" value="1">
			<input type="hidden" id="hphm" name="hphm" value="">
			<input type="hidden" id="hidden-us-glbm" name="sqbm" value="${userSession.dep.glbm }">
			<div class="frm-row">
				<label class="frm-label frm-col-3">业务类型</label>
				<div class="frm-col-5">
					<input type="text" id="main_ywlxstr" name="ywlxstr" disabled value="${ywlx }"  class="frm-input">
				</div>
				<label class="frm-label frm-col-3">业务原因</label>
				<div class="frm-col-13">
					<div id="ywyy-div">
					</div>
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-3">申请单位</label>
				<div class="frm-col-5">
					<input type="text" id="us-glbm" name="glbm" value="${userSession.dep.bmjc }" readonly  lay-verify="required" placeholder="请选择管理部门" class="layui-input" >
				</div>
				<label class="frm-label frm-col-3">申请人</label>
				<div class="frm-col-11"> 
					<input type="text" id="car-sqry" readonly name="sqry" lay-verify="required" maxlength="15" value="${userSession.user.xm }" placeholder="请输入申请人"  class="frm-input">
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-3">车辆类型</label>
				<div class="frm-col-5">
					<select id="car-cllx" name="cllx"  lay-verify="required">
					        <option value="">请选择</option>
					</select>
				</div>
				<label class="frm-label frm-col-3">号牌号码</label>
				<div class="frm-col-11">
					<input type="hidden" id="car-hpzl" value="" name="hpzl"  class="layui-input cle">
					<input type="text" id="veh-bdfzjg" value="" readonly  class="layui-input" style="width: 12%;float:left;">
					<input type="text" id="hm" value="" onkeyup="this.value=this.value.toUpperCase()" maxlength="5"  lay-verify="required" style="width: 76%;float:left;" placeholder="请输入号牌号码" class="layui-input cle">
					<a href="javascript:;" class="layui-btn layui-btn-small" id="hphmbd" style="width:12%;float:left;margin-top: 1px;"><i class="layui-icon" >&#xe615;</i>选择</a>
				</div>
			</div>
<!-- 			<div class="frm-row"> -->
<!-- 				<label class="frm-label frm-col-3">开始时间</label> -->
<!-- 				<div class="frm-col-5"> -->
<!-- 					<input type="text" id="car-kssj" name="kssj" lay-verify="required" class="layui-input cle" placeholder="请编写如1990/11/11 12:12:12" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY/MM/DD hh:mm:ss'})"> -->
<!-- 				</div> -->
<!-- 				<label class="frm-label frm-col-3">结束时间</label> -->
<!-- 				<div class="frm-col-4"> -->
<!-- 					<input type="text" id="car-jssj" name="jssj" lay-verify="required"  placeholder="请编写如1990/11/11 12:12:12"  class="layui-input cle" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY/MM/DD hh:mm:ss'})"> -->
<!-- 				</div> -->
<!-- 				<label class="frm-label frm-col-3">需要用时</label> -->
<!-- 				<div class="frm-col-4"> -->
<!-- 					<input type="text" id="car-sxsj" name="sxsj" readonly class="layui-input cle" value="" lay-verify="required" placeholder="请输入需要时间 " style="width: 75%;float:left;"> -->
<!-- 					<input type="text"  value="小时" readonly style="width: 25%;float:left;" class="layui-input"> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="frm-row">
				<label class="frm-label frm-col-3">任务内容</label>
				<div class="frm-col-19">
					<input type="text" id="car-rwnr" name="rwnr" lay-verify="required" maxlength="248" placeholder="请输入处置原因" value=""  class="layui-input cle" >
				</div>
			</div>
			<div class="frm-row">
				<div class="frm-col-22" style="text-align: right">
						<a href="javascript:;" class="layui-btn layui-btn-small" id="car-clear" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#xe654;</i> 新增</a>
						<a href="javascript:;" class="layui-btn layui-btn-small" id="car-save" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#xe605;</i> 保存</a>
				</div>
			</div>
		</form>
	</body>
</html>
