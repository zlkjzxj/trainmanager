<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>业务修改</title>
		<meta name="renderer" content="webkit">
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
			.td1{width:7%;}
			.td2{width:11%;}
			.td3{width:11%;}
			.td4{width:11%;}
			.td5{width:11%;}
			.td6{width:11%;}
			.td7{width:13%;}
			.td8{width:13%;}
			.td9{width:10%;}
		</style>
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
					
				//初始换管理部门下拉选择框
				var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['300px','300px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
				//管理部门选择下拉框事件
				$('#drv-glbm').on('click',function(){
					glbmSelectByZTree.show($('#drv-glbm'),function(event, treeId, treeNode){
						$('#drv-glbm').val(treeNode.name);
						$('#hidden-drv-glbm').val(treeNode.tags.glbm);
					},$(this).val());
				});
				//业务类型加载
				ajaxTools.loadCodeDataKK($('#ue-ywlx'),{dmmc:'ywlx'},false,'','code.do?method=selectListCode','请选择业务类型');
				form.render('select');
				//关闭按钮
				$('#close').on('click',function(){
					top.closeTab(hrefTools.getLocationParam('cxdh'));
				});
				//查询按钮
				$('#query').on('click',function(){
					queryFlowList();
				});
				function queryFlowList(){
					var params = {};
					params.sqbm = $('#hidden-drv-glbm').val();
					params.lsh= $('#lsh').val();
					params.bhxj= "0";
					params.ywlx= $('#ue-ywlx').val();
					params.lszt="1";
					params.ywgw="1,2,3,4"
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
										openFlowEdit($(this).data('lsh'),$(this).data('ywlx'),$(this).data('ywgw'));
								});
							});	
							$('#content').children('tr').on('dblclick',function(){
								if(!$(this).data('lsh')){
									return;
								}
								openFlowEdit($(this).data('lsh'),$(this).data('ywlx'),$(this).data('ywgw'));
							});
						}
					});
				}
				function openFlowEdit(lsh,ywlx,ywgw){
				var condition ='&cxdh=020108&lsh='+lsh+'&bz='+ywlx+'&ywgw='+ywgw;
				layer.open({
					type: 2,
					id:'flowEdit',
					content:['flow.do?method=forwardUpdatePage'+condition],
					title: '业务信息编辑', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
					shade: 0.2,
					offset: ['30px', '10%'],
					area: ['1100px', '530px'],
					zIndex: 10000000,
					moveOut: true,
					maxmin: false,
					btn: 0 	//['新增','保存', '取消']
				});
			}
				//重置按钮
				$('#reset').on('click',function(){
					$('#drv-glbm').val('');
					$('#hidden-drv-glbm').val('');
					$('#lsh').val('');
					$('#ue-ywlx').val('');
					form.render();
				});
			});
		</script>
	</head>

	<body>
		<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
		<input type="hidden" id="hidden-drv-glbm">
		<input type="hidden" id="yhdh" value="${userSession.user.yhdh }">
		<div class="admin-main">
			<form class="layui-form">
				<blockquote class="layui-elem-quote req-query-form">
					<label class="">管理部门</label>
					<input type="text" id="drv-glbm" readonly placeholder="请选择管理部门" class="layui-input" style="width: 180px;">
					<label class="" style="width:8%">业务类型</label>
					<div class="layui-input-inline" style="width:180">
				        <select id="ue-ywlx">
				        	<option value="">请选择业务类型</option>
					    </select>
					</div>
					<label class="">流水号</label>
					<input type="text" id="lsh" class="frm-input" style="width:180px" placeholder="请输入流水号" maxlength="13">
					<div class="layui-input-inline" style="float: right;margin-top: 5px;">
						<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
						<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
						<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
					</div>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>业务信息列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
								<th class="td1">序号</th>
								<th class="td2">流水号</th>
								<th class="td3">业务类型</th>
								<th class="td4">业务原因</th>
								<th class="td5">业务岗位</th>
								<th class="td6">申请人</th>
								<th class="td7">申请单位</th>
								<th class="td8">申请日期</th>
								<th class="td9">操作</th>
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
			<tr data-lsh="{{ item.lsh }}" data-ywlx="{{ item.ywlx }}" data-ywgw="{{ item.ywgw }}">
				<td class="td1">{{ index+1 }}</td>
				<td class="td2">{{ item.lsh }}</td>
				<td class="td3">{{ formateYwlx(item.ywlx) }}</td>
				<td class="td4">{{ formateYwYy(item.ywyy,item.ywlx) }}</td>
				<td class="td5">{{ formateYwgw(item.ywgw) }}</td>
				<td class="td6">{{ item.sqry }}</td>
				<td class="td7">{{ formateGlbm_jc(item.sqbm) }}</td>
				<td class="td8">{{ formateShortDate(item.sqrq==null?'':item.sqrq) }}</td>
				<td class="td9"><a href="javascript:;" data-lsh="{{ item.lsh }}" data-ywlx="{{ item.ywlx }}" data-ywgw="{{ item.ywgw }}" data-opt="edit"    class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 编辑</a></td>
			</tr>
			{{# }); }}
		</script>
	</body>
</html>
