<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>处置登记</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		
		<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="frm/css/global.css" media="all">
		<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="frm/css/frmColors.css" type="text/css">
		<link rel="stylesheet" href="frm/css/table.css" />
		<style type="text/css">
			.layui-elem-quote{
				padding: 9px 10px;
			}
			.flow-query-form .layui-input{
				display: inline-block;
			}
			.flow-query-form label{
				padding: 9px 4px 9px 9px;
				vertical-align: middle; 
			}
			.flow-query-form .layui-btn{
				float: right;
				margin-left: 10px;
			}
			.flow-query-form .layui-form-checkbox,.flow-query-form .layui-form-switch{
				margin: 0;
			}
			
			.td1{width:4%;}
			.td2{width:8%;}
			.td3{width:11%;}
			.td4{width:11%;}
			.td5{width:11%;}
			.td6{width:13%;}
			.td7{width:8%;}
			.td8{width:15%;}
		</style>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script type="text/javascript">
			layui.config({
				base: '',
				version: new Date().getTime()
			}).extend({
				paging:'frm/js/paging',
				glbmSelect:'common/js/glbmSelect',
				hrefTools:'common/js/hrefTools',
				ajaxTools:'common/js/ajaxTools',
				domTools:'common/js/domTools'
			}).use(['element','laydate','paging','form','tree','glbmSelect','hrefTools','ajaxTools','domTools'], function() {
				var $ = layui.jquery,
					paging = layui.paging(),
					layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
					layer = layui.layer, //获取当前窗口的layer对象
					form = layui.form(),
					hrefTools = layui.hrefTools,
					domTools = layui.domTools,
					ajaxTools = layui.ajaxTools;
				
				
				//查询按钮
				$('#query').on('click',function(){
					queryFlowList();
				});
				
				
				//重置按钮
				$('#reset').on('click',function(){
					$('#dis-sqrq').val('');
					$('#lsh').val('');
				});
				
				
				//关闭按钮
				$('#close').on('click',function(){
					top.closeTab(hrefTools.getLocationParam('cxdh'));
				});
				
				window.reDisposeflowList = function(){
					queryFlowList();
				}
				
				function queryFlowList(){
					var params = {};
					params.sqbm = '${userSession.dep.glbm }';
					params.ywlx = 'D';
					params.sqrq = $('#dis-sqrq').val();
					params.bhxj = '0';
					params.ywgw = '6';
					params.lszt = '1';
					params.lsh = $('#lsh').val();
					//初始化
					paging.init({
						url: 'flow.do?method=selectListPageFlow', //地址
						elem: '#content', //内容容器
						params: params, //发送到服务端的参数
						type: 'POST',
						tempElem: '#tpl', //模块容器
						pageConfig: { //分页参数配置
							elem: '#paged', //分页容器
							pageSize: 10 //分页大小
						},
						complate: function() { //完成的回调
							//绑定窗口调整事件
							$(window).off('resize',domTools.resizeTableHeight).on('resize', domTools.resizeTableHeight).resize();
							$('#content').children('tr').each(function() {
								var $that = $(this);
								//编辑按钮事件
								$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
									openFlowEdit($(this).data('lsh'));
								});
								
							});
							$('#content').children('tr').on('dblclick',function(){
								if(!$(this).data('lsh')){
									return;
								}
								openFlowEdit($(this).data('lsh'));
							});
						}
					});
				}
				
				function openFlowEdit(lsh){
					var condition = (!lsh)?'':'&lsh='+lsh;
					layer.open({
						type: 2,
						id:'flowEdit',
						content:['flow.do?method=forwardFlowEditPage&ymmc=dispose_edit'+condition],
						title: '车辆处置信息', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
						shade: 0.2,
						offset: ['30px', '10%'],
						area: ['1000px', '435px'],
						zIndex: 10000000,
						moveOut: true,
						maxmin: false,
						btn: 0 	//['新增','保存', '取消']
					});
				}
			});
		</script>
	</head>

	<body>
		<div class="admin-main">

			<form id="mainflowEditForm" name="mainflowEditForm"  class="layui-form">
				<blockquote class="layui-elem-quote flow-query-form">
					<label class="">流水号</label>
					<input type="text" id="lsh" class="layui-input" style="width:180px" placeholder="请输入流水号" maxlength="13">
					<label class="">申请日期</label>
					<input class="layui-input" id="dis-sqrq" onclick="layui.laydate({elem: this})"  type="text" placeholder="请编写如1990-11-11" autocomplete="off" style="width:180px;">
					<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>车辆处置列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
								<th class="td1">序号</th>
								<th class="td2">流水号</th>
								<th class="td3">业务原因</th>
								<th class="td4">申请人</th>
								<th class="td5">申请单位</th>
								<th class="td6">业务岗位</th>
								<th class="td7">申请日期</th>
								<th class="td8">操作</th>
							</tr>
						</thead>
					</table>
					<div id="contentDiv">
						<table id="tbodyTable" class="layui-table admin-table">
							<tbody id="content">
							</tbody>
						</table>
					</div>
				</div>
			</fieldset>
			<div class="admin-table-page">
				<div id="paged" class="page">
				</div>
			</div>
		</div>
		
		<!--模板-->
		<script type="text/html" id="tpl">
			{{# layui.each(d.list, function(index, item){ }}
			<tr data-ywlx="{{ item.ywlx }}" data-lsh="{{ item.lsh }}">
				<td class="td1">{{ index+1 }}</td>
				<td class="td2">{{ item.lsh }}</td>
				<td class="td3">{{ formateYwYy(item.ywyy,item.ywlx) }}</td>
				<td class="td4">{{ item.sqry }}</td>
				<td class="td5">{{ formateGlbm_jc(item.sqbm) }}</td>
				<td class="td6">{{ formateYwgw(item.ywgw==null?'':item.ywgw) }}</td>
				<td class="td7">{{ formateShortDate(item.sqrq==null?'':item.sqrq) }}</td>
				
				<td class="td8">
					<a href="javascript:;" data-lsh="{{ item.lsh }}" data-opt="edit"   class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 编辑</a>
				</td>
			</tr>
			{{# }); }}
		</script>
		
	</body>
</html>
