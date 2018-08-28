<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>微信审批人员维护</title>
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
		<link rel="stylesheet" href="common/js/zTree_v3-master/css/zTreeStyle/zTreeStyle.css">
		<style type="text/css">
			html,body{
				height: 100%;
			}
			#depTreeDiv{
				float: left;
				width:202px;
				height: 100%;
				overflow: hidden;
				border-right: 2px solid #3C8DBC;
			}
			#depTree{
				height: 100%;
				overflow: auto;
				width: 220px;
			}
			#depEdit{
				overflow: auto;
				margin-left: 204px;
				padding:0;
				height: 100%;
				overflow: hidden;
			}
			#depEdit>form{
				height:100%;
				box-sizing: border-box !important;
			    -webkit-box-sizing: border-box !important;
			    -moz-box-sizing: border-box !important;
				padding: 20px 30px 0 0;
				overflow: auto;
			}
			
		</style>
	</head>

	<body>
		<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
		<div id="depTreeDiv">
			<div id="depTree" class="ztree">
			</div>
		</div>
		<div id="depEdit">
		<div class="admin-main">
			<form id="mainDepEditForm" name="mainDepEditForm" method="post" class="layui-form">
				<input type="hidden" id="hidden-de-glbm" name="glbm" value="${userSession.dep.glbm }">
				<input type="hidden" id="de-bmjc"  value="${userSession.dep.bmjc }">
				<blockquote class="layui-elem-quote veh-query-form">
				<div class="frm-row">
					<label class="frm-label frm-col-3">用户代号</label>
					<div class="frm-col-5">
						<select id="sp-yhdh" lay-verify="required" name="yhdh">
					        <option value="">请选择人员</option>
						</select>
					</div>
					<label class="frm-label frm-col-3">维护类别</label>
					<div class="frm-col-5">
						<select id="sp-lb" name="lb"  placeholder="请选择维护类别" lay-verify="required">
					        <option value="1">审批人员</option>
					        <option value="2">审核人员</option>
					        <option value="3">出场人员</option>
						</select>
					</div>
					<div class="frm-col-7" style="text-align: right;">
						<a href="javascript:;" class="layui-btn layui-btn-small" id="add"><i class="layui-icon" >&#xe654;</i> 添加</a>
						<a href="javascript:;" class="layui-btn layui-btn-small" id="select"><i class="layui-icon" >&#xe615;</i> 查询</a>
						<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					</div>
				</div>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>人员列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
								<th class="td1">序号</th>
								<th class="td2">用户代号</th>
								<th class="td3">身份证明号码</th>
								<th class="td4">姓名</th>
								<th class="td5">管理部门</th>
								<th class="td6">手机号码</th>
								<th class="td7">维护类别</th>
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
		</div>
		
		<!--模板-->
		<script type="text/html" id="tpl">
			{{# layui.each(d.list, function(index, item){ }}
			<tr data-lsh="{{ item.lsh }}">
				<td class="td1">{{ index+1 }}</td>
				<td class="td2">{{ item.yhdh }}</td>
				<td class="td3">{{ item.sfzmhm }}</td>
				<td class="td4">{{ item.xm}}</td>
				<td class="td5">{{ formateGlbm_jc(item.glbm) }}</td>
				<td class="td6">{{ item.lxdh }}</td>
				<td class="td7">{{ item.lb==1?'审批':'审核' }}</td>
				<td class="td8"><a href="javascript:;" data-yhdh="{{ item.yhdh }}"  data-opt="edit"    class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 删除</a></td>
			</tr>
			{{# }); }}
		</script>
		
		
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript">
		layui.config({
			base: '',
			version: new Date().getTime()
			
		}).extend({
			paging:'frm/js/paging',
			domTools:'common/js/domTools',
			ajaxTools:'common/js/ajaxTools',
			hrefTools:'common/js/hrefTools',
			jqueryform:	'common/js/jquery.form',
			verifyTools:'common/js/verifyTools',
			ztree:'common/js/zTree_v3-master/js/jquery.ztree.core'
				
		}).use(['element','laydate','form','paging','verifyTools','tree','domTools','ajaxTools','hrefTools','jqueryform','ztree'], function() {
			var $ = layui.jquery,
				element = layui.element(),
				paging = layui.paging(),
				layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
				layer = layui.layer, //获取当前窗口的layer对象
				form = layui.form(),
				verifyTools = layui.verifyTools(form),
				domTools = layui.domTools,
				ajaxTools = layui.ajaxTools,
				hrefTools = layui.hrefTools;
			
			
			if($('#curr-user-glbm').val()){
				queryTree();
				queryDep($('#curr-user-glbm').val());
			}else{
				domTools.printMsgToConsole('error','当前用户管理部门错误');
			}
			
			form.render();
			
			$('#add').on('click',function(){
				if(form.verifyForm(mainDepEditForm)){
					$(mainDepEditForm).ajaxSubmit({
						type:'POST',
						url:'wxSpry.do',
						data:{
							gnid:'01020801',
							cxid:'010208',
							method:'saveWxSpry'
						},
						dataType:'json',
						success:function(rlt){
							if(rlt.code=='1'){
								layer.alert(rlt.mess, {icon: 6});
								queryWxUserList($('#hidden-de-glbm').val())
							}else{
								layer.alert(rlt.mess, {icon: 5});
							}
							queryTree();
						}
					});
				}
			});
			
			$('#close').on('click',function(){
				top.closeTab(hrefTools.getLocationParam('cxdh'));
			});
			
			function queryTree(){
				$.ajax({
					url:'dep.do',
					dataType:'json',
					type:'POST',
					data:{
						method:'getDeparmentTreeJson',
						rootBmdm:$('#curr-user-glbm').val()
					},
					success:function(data){
						renderTree(data);
					},
					error:function(xhr,mess,e){
						domTools.printMsgToConsole('error','Ajax查询部门json字符串发生错误');
					}
				});
			}
			
			function renderTree(data){
				var currSelectedNodeGlbm = $('#de-bmjc').val();
				$('#depTree').html('');
				if(data){
					var ztreeObj = $.fn.zTree.init($("#depTree"), {
						callback: {
							onClick: function(event, treeId, treeNode){
								var eg = $('#hidden-de-glbm').val();
								if(!eg||eg!=treeNode.tags.glbm){
									//赋值
									queryDep(treeNode.tags.glbm);
								}
							}
						}
					}, [data]);
					if(currSelectedNodeGlbm){
						var ztreeCurNode = ztreeObj.getNodeByParam("name",currSelectedNodeGlbm);
						//console.log(ztreeObj.expandNode(ztreeCurNode,true,false));
						ztreeObj.selectNode(ztreeCurNode);
						
						var jCurNode = $('#'+ztreeCurNode.tId+'_span');
						var tp = parseInt(jCurNode.offset().top);
						$('#depTree').animate({
							scrollTop:(tp>90)?(tp-90):tp
					    },500);
					}
					//模拟点击，展开至当前选中树
				}else{
					domTools.printMsgToConsole('error','数据查询错误');
				}
			}
			
			function queryDep(glbm){
				$.getJSON('dep.do?method=getDepartment',{glbm:glbm},function(result){
					$('#de-bmjc').val(result.dep.bmjc);
					$('#hidden-de-glbm').val(result.dep.glbm);
					form.render('select');
				});
				reloadYhdh(glbm)
			}
				
			function reloadYhdh(glbm){
				ajaxTools.loadCodeDataKK($('#sp-yhdh'),{glbm:glbm,bhxj:0},false,'','code.do?method=getUserJsonWx&t='+new Date().getTime(),'请选择用户');
				form.render('select');
				queryWxUserList(glbm);
			}
			$('#select').on('click',function(){
				queryWxUserList($('#hidden-de-glbm').val())
			})
			function queryWxUserList(glbm){
					var params = {};
					params.lb = $('#sp-lb').val();
					params.glbm=glbm
					//初始化
					paging.init({
						url: 'wxSpry.do?method=getWxSpryListPage', //地址
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
									openWxUserEdit($(this).data('yhdh'));
								});
								
							});
						}
					});
				}
				
			function openWxUserEdit(yhdh){
				layer.confirm('确认取消此人员？', {icon: 3, title:'提示'}, function(index){
					$.getJSON('wxSpry.do',{method:'deleteWxSpry',yhdh:yhdh,gnid:'01020803',cxid:'010208',t:new Date().getTime()},function(rlt){
						paging.reload();
					});
					layer.close(index);
				});
			}
		});
		
		</script>
	</body>
</html>
