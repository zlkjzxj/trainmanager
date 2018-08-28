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
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript">
		layui.config({
			base: '',
			version: new Date().getTime()
			}).extend({
				ajaxTools:	'common/js/ajaxTools',
				glbmSelect:	'common/js/glbmSelect',
				domTools:	'common/js/domTools',
				hrefTools:	'common/js/hrefTools',
				jqueryform:	'common/js/jquery.form'
					
			}).use(['element','form','laydate','ajaxTools','glbmSelect','domTools','hrefTools','jqueryform'],function(){
				
				var $ = jquery = layui.jquery,
					element = layui.element(),
					ajaxTools  = layui.ajaxTools,
					domTools = layui.domTools,
					hrefTools = layui.hrefTools,
					form = layui.form();
				var gnid="";
				$(function (){
				renderQx();
				})
				domTools.createBtnsAtBottom([{
					name:'<i class="layui-icon">&#xe605;</i> 保存', id:'ue-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
					name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'ue-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
				]);
				$('#ue-save').click(function(){
					var cks = $('#ue-yhqx input[lay-filter=CzqxCheckBox]:checked');
					var cxdhs = [];
					if(cks.length=="0"){
						gnid='3';
					}
					cks.each(function(){
						cxdhs.push($(this).data('cxdh'));
					});
					var cxdh = cxdhs.join(',');
					$(maindeskForm).ajaxSubmit({
						type:'POST',
						url:'main.do',
						data:{
							method:'processingUserDesk',
							cxdh:cxdh,
							gnid:gnid
						},
						dataType:'json',
						success:function(rlt){
							if(gnid=="1"){
								gnid="2";
							}
							if(gnid=="3"){
								gnid="1";
							}
							if(rlt.code=='1'){
								layer.alert(rlt.mess, {icon: 6});
							}else{
								layer.alert(rlt.mess, {icon: 5});
							}
								//刷新父页面列表
									top.refreshdesk();
						}
					});
				})
 				element.init();
  				form.render();
				function renderQx(){
					var menuCode = ajaxTools.getUserAllMenu({yhdh:'${userSession.user.yhdh }'});
					$('#ue-yhqx').html('');
					var tempMenuStr = '';
					for(var i in menuCode){
						var lbmenus = menuCode[i].programLbList;
						var mlstr = '';
						for(var j in lbmenus){
							var cxmenus = lbmenus[j].programList;
							var cxstr = '';
							for(var k in cxmenus){
								if(cxmenus[k].check=="1"){
									cxstr += '<input class="cxmenus" type="checkbox" lay-filter="CzqxCheckBox" data-cxdh="'+(cxmenus[k].cxdh)+'"  lay-skin="primary" title="'+cxmenus[k].cxmc+'">';
								}
							}
							mlstr += '<div class="layui-form-item">\
										<label class="layui-form-label">'+lbmenus[j].lbmc+'</label>\
							    		<div class="layui-input-block">'+cxstr+'</div>\
									  </div>';
							
							if(j<lbmenus.length-1){
								mlstr += '<hr>';
							}
						 }
						tempMenuStr += '<div class="layui-colla-item">\
								  			<h2 class="layui-colla-title">\
												<span class="'+menuCode[i].mltp+'"></span> '+menuCode[i].mlmc+'\
											</h2>\
								  			<div class="layui-colla-content cxmenus-'+i+'">'+mlstr+'</div>\
										</div>';
					}
 					$('#ue-yhqx').html(tempMenuStr);
 					defaultdate();
				}
			    function  defaultdate(){
			    	var cxqxData="";
			    	$.ajax({
						url:'main.do?method=getUserDesk&yhdh='+'${userSession.user.yhdh }'+'&t='+new Date(),
						async:false,
						dataType:'json',
						success:function(rlt){
							cxqxData = rlt;
						}
					});
					if(cxqxData!=null){
						gnid="2";
				    	$('#ue-yhqx .cxmenus').each(function(){
				    	var aa=cxqxData.toString().indexOf($(this).data('cxdh').toString())>-1;
							this.checked = (cxqxData.toString().indexOf($(this).data('cxdh').toString())>-1);
						});
					}else{
						gnid="1";
					}
			    }
			    
		});
		</script>
	</head>
	<body>
		<div id="content"><!-- 页面所有内容都要放到这个div中，方便后面调方法创建layer底部按钮 -->
		<form id="maindeskForm" name="maindeskForm" class="layui-form" method="post">
			<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
			<input type="hidden" id="hidden-ue-glbm" name="yhdh" value="${userSession.user.yhdh }">
			<div class="layui-tab layui-tab-brief" lay-filter="">
			  	<div class="layui-tab-content" >
			  		<div class="layui-tab-item layui-show">
			  			<div class="ue-r ue-lr">
	    				     <div class="layui-form-item">
							    	<label class="layui-form-label">操作权限</label>
							    	<div class="layui-input-block">
							    		<div id="ue-yhqx" class="layui-collapse"></div>
							    	</div>
							  </div>
			  			</div>
			  		</div>
			  	</div>
			</div>
		</form>
		</div>
		
		
	</body>
</html>
