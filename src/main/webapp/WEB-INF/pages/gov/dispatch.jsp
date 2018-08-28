<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>智能派车</title>
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
		<link rel="stylesheet" href="frm/css/global.css" media="all">
		<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="frm/css/table.css" />
		<link rel="stylesheet" href="common/js/zTree_v3-master/css/zTreeStyle/zTreeStyle.css">
		<style type="text/css">
			.layui-elem-quote{
				padding: 9px 10px;
			}
			.veh-query-form .layui-input{
				display: inline-block;
			}
			.veh-query-form label{
				padding: 9px 4px 9px 9px;
				vertical-align: middle; 
			}
			.veh-query-form .layui-btn{
				float: right;
				margin-left: 10px;
			}
			.veh-query-form .layui-form-checkbox,.veh-query-form .layui-form-switch{
				margin: 0;
			}
			.td1{width:7%;}
			.td2{width:13%;}
			.td3{width:13%;}
			.td4{width:13%;}
			.td5{width:13%;}
			.td6{width:15%;}
			.td7{width:13%;}
			.td8{width:13%;}
		</style>
	</head>
	<body>
		<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
		<input type="hidden" id="hidden-drv-glbm">
		<div class="admin-main">
			<form class="layui-form">
				<blockquote class="layui-elem-quote veh-query-form">
					<label style="float: left;line-height: 17px;">申请部门</label>
					<div style="float: left;">
					<input type="text" id="drv-glbm" readonly placeholder="请选择管理部门" class="layui-input" style="width: 180px;">
					</div>
					<label style="float: left;line-height: 17px;">业务原因</label>
					<div style="float: left;width: 150px;">
						       <select id="drv-ywlx">
						         <option value="">请选择</option>
							   </select>
					</div>
					<label style="float: left;line-height: 17px;">申请日期</label>
					<input class="layui-input" id="dis-sqrq" name="sqrq" onclick="layui.laydate({elem: this})"  type="text" placeholder="请编写如1990-11-11" autocomplete="off" lay-verify="date" style="width:180px;">
					<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>智能派车列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
								<th class="td1">序号</th>
								<th class="td2">流水号</th>
								<th class="td3">业务类型</th>
								<th class="td4">业务原因</th>
								<th class="td5">申请人</th>
								<th class="td6">申请单位</th>
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
			<tr data-lsh="{{ item.lsh }}">
				<td class="td1">{{ index+1 }}</td>
				<td class="td2">{{ item.lsh }}</td>
				<td class="td3">{{ formateYwlx(item.ywlx) }}</td>
				<td class="td4">{{ formateYwYy(item.ywyy,item.ywlx) }}</td>
				<td class="td5">{{ item.sqry }}</td>
				<td class="td6">{{ formateGlbm_jc(item.sqbm) }}</td>
				<td class="td7">{{ formateShortDate(item.sqrq==null?'':item.sqrq) }}</td>
				<td class="td8"><a href="javascript:;" data-lsh="{{ item.lsh }}"  data-opt="edit"    class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 编辑</a></td>
			</tr>
			{{# }); }}
		</script>
		
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
			glbmSelectByZTree:'common/js/glbmSelectByZTree',
			hrefTools:'common/js/hrefTools',
			domTools:'common/js/domTools',
			ajaxTools:'common/js/ajaxTools'
		}).use(['element','laydate','paging','form','tree','glbmSelectByZTree','hrefTools','ajaxTools','domTools'], function() {
			var $ = layui.jquery,
				paging = layui.paging(),
				layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
				layer = layui.layer, //获取当前窗口的layer对象
				form = layui.form(),
				hrefTools = layui.hrefTools,
				domTools = layui.domTools,
				ajaxTools = layui.ajaxTools;
				
			ajaxTools.loadCodeDataKK($('#drv-ywlx'),{dmmc:'gwycyy'},false,'','code.do?method=selectListCode','请选择业务原因');
			form.render('select');
			//初始换管理部门下拉选择框
			var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['300px','300px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
			//管理部门选择下拉框事件
			$('#drv-glbm').on('click',function(){
				glbmSelectByZTree.show($('#drv-glbm'),function(event, treeId, treeNode){
					$('#drv-glbm').val(treeNode.name);
					$('#hidden-drv-glbm').val(treeNode.tags.glbm);
				},$(this).val());
			});
			
			//查询按钮
			$('#query').on('click',function(){
				queryDispacthList();
			});
			//关闭按钮
			$('#close').on('click',function(){
				top.closeTab(hrefTools.getLocationParam('cxdh'));
			});
			//重置按钮
			$('#reset').on('click',function(){
				$('#drv-glbm').val('');
				$('#hidden-drv-glbm').val('');
				$('#dis-sqrq').val('');
				$('#drv-ywlx').val('');
				form.render('select');
			});
			
			window.refreshDispatchList=function(){queryDispacthList();}
			function queryDispacthList(){
				var params = {};
				params.sqbm = $('#hidden-drv-glbm').val();
				params.sqrq = $('#dis-sqrq').val();
				params.ywyy=$('#drv-ywlx').val();
				params.ywgw='3';
				params.ywlx="A";
				params.lszt="1";
				params.bhxj="1";
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
						$(window).off('resize',domTools.resizeTableHeight).on('resize', domTools.resizeTableHeight).resize();
						$('#content').children('tr').each(function() {
							var $that = $(this);
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
				var condition ="&lsh="+lsh;
				layer.open({
					type: 2,
					id:'dispatchEdit',
					content:['flow.do?method=forwardFlowEditPage&ymmc=dispatch_edit'+condition],
					title: '智能派车编辑', 
					shade: 0.2,
					offset: ['30px', '10%'],
					area: ['1000px', '550px'],
					zIndex: 10000000,
					moveOut: true,
					maxmin: false,
					btn: 0 	//['新增','保存', '取消']
				});
			}
		
		});
		</script>
	</body>
</html>
