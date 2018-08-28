<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>日志管理</title>
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
			.layui-elem-quote{
				padding: 9px 10px;
			}
			.req-query-form .layui-input{
				display: inline-block;
				height:32px;
				line-height: 32px;
				vertical-align: middle;
			}
			.req-query-form label{
				padding: 9px 4px 9px 9px;
				vertical-align: middle; 
			}
			.req-query-form .layui-btn{
				float: right;
				margin-left: 10px;
			}
			.req-query-form .layui-form-checkbox,.req-query-form .layui-form-switch{
				margin: 0;
			}
			.layui-input-labe{
				text-align: right;
			}	
		</style>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script type="text/javascript">
			layui.config({
				base: '',
				version: new Date().getTime()
			}).extend({
				hrefTools:'common/js/hrefTools',
				ajaxTools:'common/js/ajaxTools'
			}).use(['element','form','ajaxTools','hrefTools'], function() {
				var $ = layui.jquery,
				layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
				layer = layui.layer, //获取当前窗口的layer对象
				form = layui.form(),
				hrefTools = layui.hrefTools,
				ajaxTools = layui.ajaxTools;
				//业务类型加载
				ajaxTools.loadCodeDataKK($('#ue-ywlx'),{cxdh:'020101'},false,'02010101','code.do?method=getProgramGnidListJson','请选择业务类型');
				form.render('select');
				//关闭按钮
				$('#close').on('click',function(){
					top.closeTab(hrefTools.getLocationParam('cxdh'));
				});
				//查询按钮
				$('#query').on('click',function(){
					var gnid=$('#ue-ywlx').val();
					if(gnid==""){
						layer.alert("请选择业务类型", {icon: 5});
						return;
					}
					var url='flow.do?method=forwardReqPage&gnid='+gnid;
					$('#reqifm').attr('src',url);
				});
				function selectOnchage(){
					var url='flow.do?method=forwardReqPage&gnid='+gnid;
					$('#reqifm').attr('src',url);
				}
				query.click();
				//重置按钮
				$('#reset').on('click',function(){
					$('#ue-ywlx').val('');
					form.render();
				});
				form.on('select(ywlxSelect)',function(data){
					//form.render('select');
					query.click();
				});
			});
		</script>
	</head>

	<body>
		<div>
		<input type="hidden" id="yhdh" value="${userSession.user.yhdh }">
		<div class="admin-main">
			<form class="layui-form">
				<blockquote class="layui-elem-quote req-query-form">
					<label class="" style="width:8%">业务类型</label>
					<div class="layui-input-inline" style="width:15%">
				        <select id="ue-ywlx" name="ywlx" lay-filter="ywlxSelect">
				        	<option value="">请选择业务类型</option>
					    </select>
					</div>
					<div class="layui-input-inline" style="float: right;margin-top: 5px;">
						<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
<!-- 						<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a> -->
						<a href="javascript:;" class="layui-btn layui-btn-small" id="query" style="display: none;"><i class="layui-icon" >&#xe615;</i> 查询</a>
					</div>
				</blockquote>
			</form>
			<iframe name="reqifm" id="reqifm" src="" style="border:0px;width: 100%;height: 550px;overflow: auto;" frameborder="no"></iframe>
		</div>
		</div>
	</body>
</html>
