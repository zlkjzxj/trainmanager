<%@page import="com.zlkj.frm.bean.FrmSyspara"%>
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
	form#mainParamEditForm{
		padding: 20px 20px 0 0;
	}
	#cszDiv>input,#cszDiv .layui-form-select{
		width:40%;
	}
</style>
</head>
<body>
	<div id="content"><!-- 页面所有内容都要放到这个div中，方便后面调方法创建layer底部按钮 -->
		<form id="mainParamEditForm" name="mainParamEditForm" class="layui-form" method="post">
			<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
			<input type="hidden" id="hidden-pe-glbm" name="glbm" value="${glbm }">
			<input type="hidden" id="hidden-pe-gjz" name="gjz" value="${bean.gjz }">
			<input type="hidden" id="hidden-pe-xtlb" name="xtlb" value="${bean.xtlb }">
			<input type="hidden" id="hidden-pe-csz" value="${bean.csz }">
			<input type="hidden" id="hidden-pe-xsxs" value="${bean.xsxs }">
			<input type="hidden" id="hidden-pe-dmlb" value="${bean.dmlb }">
			
			<div class="frm-row">
				<label class="frm-label frm-col-4">关键字</label>
				<div class="frm-col-8">
					<input type="text" id="pe-gjz" disabled class="frm-input" value="${bean.gjz }">
				</div>
				<label class="frm-label frm-col-4">参数类型</label>
				<div class="frm-col-8">
					<input type="text" id="pe-cslx" disabled class="frm-input" value="${bean.cslx }">
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-4">参数名称</label>
				<div class="frm-col-8">
					<input type="text" id="pe-csmc" disabled class="frm-input" value="${bean.csmc }">
				</div>
				<label class="frm-label frm-col-4">管理部门</label>
				<div class="frm-col-8">
					<input type="text" id="pe-glbm" disabled class="frm-input" value="${glbm }">
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-4">参数说明</label>
				<div class="frm-col-20">
					<textarea id="pe-cssm" disabled class="layui-textarea">${bean.cssm }</textarea>
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-4">参数值</label>
				<div class="frm-col-20" id="cszDiv">
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
			
			
			//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
			domTools.createBtnsAtBottom([
				{name:'<i class="layui-icon">&#xe605;</i> 保存', id:'pe-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},
				{name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'pe-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
			]);
			
			
			if($('#pe-glbm').val()){
				$('#pe-glbm').val(formateGlbm_jc($('#pe-glbm').val()));
			}
			
			if($('#pe-cslx').val()){
				$('#pe-cslx').val(formateCslx($('#pe-cslx').val()));
			}
			
			
			var xsxs = $('#hidden-pe-xsxs').val();
			var csz = $('#hidden-pe-csz').val();
			var dmlb = $('#hidden-pe-dmlb').val();
			if(!xsxs){
				//error
			}
			
			if(xsxs=='1'){	//文本框
				$('#cszDiv').html('<input id="pe-csz" name="csz" type="text" class="frm-input" value="'+csz+'">');
			}else if(xsxs=='2'){ //下拉框
				$('#cszDiv').html('<select id="pe-csz" name="csz"><option value="'+csz+'">'+csz+'</option></select>');
				if(dmlb){
					ajaxTools.loadCodeData($('#pe-csz'),{dmmc:dmlb},false,csz);
				}
			}else if(xsxs=='4'){ //单选
				if(dmlb){
					ajaxTools.loadCodeForRadio($('#cszDiv'),'csz',{dmmc:dmlb},false,csz);
				}else{
					$('#cszDiv').html('<input type="radio" disabled name="csz" value="'+csz+'" title="'+csz+'" checked />');
				}
			}else if(xsxs=='5'){ //多选
				if(dmlb){
					ajaxTools.loadCodeForCheckbox($('#cszDiv'),'csz',{dmmc:dmlb},false,csz,'','primary');
				}else{
					$('#cszDiv').html('<input type="checkbox" disabled name="csz" value="'+csz+'" title="'+csz+'" lay-skin="primary" checked />');
				}
			}else{
				//error
			}
			
			
			//渲染
			element.init();
			form.render();
			
			
			$('#pe-save').on('click',function(){
				 /* var csz;
				 
				 if(csz!=0&&!csz){
				 	layer.msg('请输入合法有效的参数值', {icon: 5,shift: 6});
				 	return;
				 } */
				 
				 $(mainParamEditForm).ajaxSubmit({
				 	type:'POST',
					url:'param.do',
					data:{
						method:'saveParamValue',
						
						//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
						cxid:hrefTools.getLocationParam('cxdh',parent),
						gnid:'01010401',
					},
					dataType:'json',
					success:function(rlt){
						if(rlt.code=='1'){
							layer.alert(rlt.mess, {icon: 6});
						}else{
							layer.alert(rlt.mess, {icon: 5});
						}
						
						try {
							parent.refreshParamList();
						} catch (e) {}
					}
				 });
			});
		});
	</script>
</body>
</html>
