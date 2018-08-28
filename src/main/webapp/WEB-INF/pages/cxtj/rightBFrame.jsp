<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>驾驶员管理</title>
		<meta name="renderer" content="webkit">
		 <meta http-equiv="pragma" content="no-cache">  
		<meta http-equiv="cache-control" content="no-cache">  
		<meta http-equiv="expires" content="0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		
		<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="frm/css/frmColors.css" type="text/css">
		<link rel="stylesheet" href="frm/css/global.css" media="all">
		<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script type="text/javascript">
		layui.config({
			base: '',
			version: new Date().getTime()
		}).extend({
			paging:'frm/js/paging',
			glbmSelect:'common/js/glbmSelect',
			hrefTools:'common/js/hrefTools',
			domTools:'common/js/domTools',
			ajaxTools:'common/js/ajaxTools'
		}).use(['element','laydate','paging','form','tree','glbmSelect','hrefTools','ajaxTools','domTools'], function() {
			var $ = layui.jquery,
				paging = layui.paging(),
				layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
				layer = layui.layer, //获取当前窗口的layer对象
				form = layui.form(),
				hrefTools = layui.hrefTools,
				domTools = layui.domTools,
				ajaxTools = layui.ajaxTools;
				$(window).on('resize', function() {
				}).resize();
				
				$(function (){
					$.ajax({
						url:'main.do?method=getUserWarnList&t='+new Date(),
						async:false,
						dataType:'json',
						success:function(rlt){
							var xxbjlist="";
							$.each(rlt, function(index,val) {
								if(rlt[index].xxjb=="0"){
									xxbjlist+="<div style=\"line-height:22px;\"><img src=\"frm/images/warn.png\">&nbsp;&nbsp;"+rlt[index].xxbt+"</div>";
								}else{
									xxbjlist+="<div style=\"line-height:22px;\"><img src=\"frm/images/warn.png\">"+rlt[index].xxbt+"</div>";
								}
							})
 							$('#ggxxnr').html(xxbjlist);
						}
					});
				})
			
		});
		</script>
	</head>
	<body>
		<ul class="layui-nav" style="height:30px;background-color:#3c8dbc;margin-left: 1px;margin-top: 2px;">
		 <li style="line-height: 30px;">公告信息</li>
		</ul>
		<div id="ggxxnr">
		</div>
		
	</body>
</html>
