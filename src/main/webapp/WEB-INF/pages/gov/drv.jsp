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
			.td1{width:4%;}
			.td2{width:13%;}
			.td3{width:15%;}
			.td4{width:7%;}
			.td5{width:7%;}
/* 			.td6{width:12%;} */
			.td7{width:12%;}
			.td8{width:6%;}
			.td9{width:9%;}
			.td10{width:15%;}
		</style>
	</head>
	<body>
		<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
		<input type="hidden" id="hidden-drv-glbm">
		<div class="admin-main">
			<form class="layui-form">
				<blockquote class="layui-elem-quote veh-query-form">
					<label class="">管理部门</label>
					<input type="text" id="drv-glbm" readonly placeholder="请选择管理部门" class="layui-input" style="width: 180px;">
					
					<label class="">姓名</label>
					<input type="text" id="drv-xm"  placeholder="请输入姓名" maxlength="15" class="layui-input" style="width: 180px;">
					<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="add"><i class="layui-icon" >&#xe654;</i> 新增</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>驾驶人列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
								<th class="td1">序号</th>
								<th class="td2">管理部门</th>
								<th class="td3">身份证号</th>
								<th class="td4">姓名</th>
								<th class="td5">性别</th>
								<th class="td7">手机号码</th>
								<th class="td8">状态</th>
								<th class="td9">准驾车型</th>
								<th class="td10">操作</th>
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
			<tr data-jszh="{{ item.jszh }}">
				<td class="td1">{{ index+1 }}</td>
				<td class="td2">{{ formateGlbm_jc(item.glbm) }}</td>
				<td class="td3">{{ item.jszh }}</td>
				<td class="td4">{{ item.xm }}</td>
				<td class="td5">{{ formateXb(item.xb) }}</td>
				<!--<td class="td6">{{ formateShortDate(item.csrq==null?'':item.csrq) }}</td>-->
				<td class="td7">{{ item.sjhm==null?'':item.sjhm }}</td>
				<td class="td8">{{ formateDrvbdzt(item.bdzt==null?'':item.bdzt) }}</td>
				<td class="td9">{{ formateZjcx(item.zjcx)}}</td>
				
				<td class="td10">
					<a href="javascript:;" data-jszh="{{ item.jszh }}"  data-opt="edit"    class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 编辑</a>
					<a href="javascript:;" data-jszh="{{ item.jszh }}"  data-opt="del"    class="layui-btn layui-btn-danger layui-btn-mini"><i class="layui-icon">&#xe640;</i> 删除</a>
				</td>
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
				queryDrvList();
			});
			
			
			//重置按钮
			$('#reset').on('click',function(){
				$('#drv-glbm').val('');
				$('#drv-xm').val('');
				$('#hidden-drv-glbm').val('');
				form.render('select');
			});
			
			
			//新增按钮
			$('#add').on('click', function() {
				openDrvEdit();
			});
			//关闭按钮
			$('#close').on('click',function(){
				top.closeTab(hrefTools.getLocationParam('cxdh'));
			});
			
			
			//定义一个刷新列表的方法，方便子iframe页面刷新父页面列表
			window.refreshDrvList = function(){
				paging.reload();
			}
			window.reQueryDrvList = function(){
				queryDrvList();
			}
			
			function queryDrvList(){
				var params = {};
				params.glbm = $('#hidden-drv-glbm').val();
				params.xm = $('#drv-xm').val();
				//初始化
				paging.init({
					url: 'driving.do?method=getDrivingListPage', //地址
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
							
							//绑定所有编辑按钮事件
							$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
								openDrvEdit($(this).data('jszh'));
							});
							
							//绑定所有删除按钮事件
							$that.children('td:last-child').children('a[data-opt=del]').on('click', function() {
								delDrv($(this).data('jszh'));
							});
						});
						$('#content').children('tr').on('dblclick',function(){
							if(!$(this).data('jszh')){
								//error
								return;
							}
							openDrvEdit($(this).data('jszh'));
						});
					}
				});
			}
			
			function openDrvEdit(jszh){
				var condition = (!jszh)?'':'&jszh='+jszh;
				layer.open({
					type: 2,
					id:'DrvEdit',
					content:['driving.do?method=forwardDrvEditPage'+condition],
					title: '驾驶人信息编辑', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
					shade: 0.2,
					offset: ['30px', '15%'],
					area: ['1000px', '500px'],
					zIndex: 10000000,
					moveOut: true,
					maxmin: false,
					btn: 0 	//['新增','保存', '取消']
				});
			}
			
			function delDrv(jszh){
				layer.confirm('确认要删除这条信息吗？', {icon: 3, title:'提示'}, function(index){
					$.getJSON('driving.do',{method:'processingDrivingLicense',jszh:jszh,gnid:'02090203',cxid:hrefTools.getLocationParam('cxdh')},function(rlt){
						paging.reload();
					});
 					layer.close(index);
				});
			}
		
		});
		</script>
	</body>
</html>
