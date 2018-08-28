<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>流水查询</title>
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
			.td1{width:5%;}
			.td2{width:8%;}
			.td3{width:11%;}
			.td4{width:11%;}
			.td5{width:11%;}
			.td6{width:11%;}
			.td7{width:11%;}
			.td8{width:13%;}
			.td9{width:13%;}
			.td10{width:10%;}
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
					
				//重置按钮
				$('#reset').on('click',function(){
					$('#f-glbm').val('');
					$('#hidden-glbm').val('');
					$('#flow-sqrq').val('');
					$('#lsh').val('');
					$('#flow-ywlx').val('');
					$('#flow-hphm').val('');
					form.render();
				});
				
				//初始换管理部门下拉选择框
				var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['300px','300px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
				//管理部门选择下拉框事件
				$('#f-glbm').on('click',function(){
					glbmSelectByZTree.show($('#f-glbm'),function(event, treeId, treeNode){
						$('#f-glbm').val(treeNode.name);
						$('#hidden-glbm').val(treeNode.tags.glbm);
					},$(this).val());
				});
				//业务类型下拉框事件
				ajaxTools.loadCodeDataKK($('#flow-ywlx'),{dmmc:'ywlx'},false,'','code.do?method=selectListCode','请选择业务类型');
				form.render('select')
				//关闭按钮
				$('#close').on('click',function(){
					top.closeTab(hrefTools.getLocationParam('cxdh'));
				});
				//查询按钮
				$('#query').on('click',function(){
					queryFlowList();
				});
				window.refreshBackList=function(){queryFlowList();}
				function queryFlowList(){
					var params = {};
					params.sqbm = $('#hidden-glbm').val();
					params.lsh= $('#lsh').val();
					params.sqrq = $('#flow-sqrq').val();
					params.bhxj= "1";
					params.ywlx= $('#flow-ywlx').val();
					var fzjg = $('#flow-bdfzjg').val();
					var hphm = $('#flow-hphm').val();
					if(hphm!=""&&hphm!=null){
						var reg = /^[A-Z_0-9]{5}$/
						if(!reg.test(hphm)){
							layer.msg("号牌号码必须为数字或数字与字母组合！", {icon: 5,shift: 6});
						}
						params.hphm = fzjg+hphm;
					}else{
						params.hphm = '';
					}
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
										openFlowEdit($(this).data('lsh'),$(this).data('ywlx'),$(this).data('ywyy'));
								});
							});	
							$('#content').children('tr').on('dblclick',function(){
								if(!$(this).data('lsh')){
									return;
								}
								openFlowEdit($(this).data('lsh'),$(this).data('ywlx'),$(this).data('ywyy'));
							});
						}
					});
				}
				function openFlowEdit(lsh,ywlx,ywyy){
				var condition ='&cxdh=090101&lsh='+lsh+'&ymmc=cxtj/flowquery_edit&ywlx='+ywlx+'&ywyy='+ywyy;
				layer.open({
					type: 2,
					id:'backEdit',
					content:['flow.do?method=forwardCxtjFlowEditPage'+condition],
					title: '流水信息', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
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
	</head>

	<body>
		<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
		<input type="hidden" id="hidden-glbm">
		<input type="hidden" id="yhdh" value="${userSession.user.yhdh }">
		<div class="admin-main">
			<form class="layui-form">
				<blockquote class="layui-elem-quote req-query-form">
					<label class="">管理部门</label>
					<input type="text" id="f-glbm" readonly placeholder="请选择管理部门" class="layui-input" style="width: 150px;">
					<label class="">业务类型</label>
					<div class="layui-input-inline" style="width: 140px;" >
						<select id="flow-ywlx" name="flow-ywlx">
							<option value="">请选择业务类型</option>
						</select>
					</div>
					<label >申请日期</label>
					<input class="layui-input" id="flow-sqrq" onclick="layui.laydate({elem: this})"  type="text" placeholder="请选择日期" readonly autocomplete="off" style="width:180px;">
					<label class="">号牌号码</label>
					<div class="layui-input-inline" >
						<input type="text" id="flow-bdfzjg" value="" readonly class="layui-input" style="width: 40px;float:left;">
						<input type="text" id="flow-hphm" onkeyup="this.value=this.value.toUpperCase()" maxlength="5" placeholder="请输入号牌号码" class="layui-input" style="width: 140px;float:left;">
					</div>
					<label class="">流水号</label>
					<input type="text" id="lsh" class="frm-input" style="width:120px" placeholder="请输入流水号" maxlength="13">
					
					<div class="layui-input-inline" style="float: right;margin-top: 5px;">
						<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
						<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
						<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
					</div>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>流水信息列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
								<th class="td1">序号</th>
								<th class="td2">流水号</th>
								<th class="td3">业务类型</th>
								<th class="td4">业务原因</th>
								<th class="td5">号牌号码</th>
								<th class="td6">业务岗位</th>
								<th class="td7">申请人</th>
								<th class="td8">申请单位</th>
								<th class="td9">申请日期</th>
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
			<tr data-lsh="{{ item.lsh }}" data-ywlx="{{ item.ywlx }}">
				<td class="td1">{{ index+1 }}</td>
				<td class="td2">{{ item.lsh }}</td>
				<td class="td3">{{ formateYwlx(item.ywlx) }}</td>
				<td class="td4">{{ formateYwYy(item.ywyy,item.ywlx) }}</td>
				<td class="td5">{{ item.hphm }}</td>
				<td class="td6">{{ formateYwgw(item.ywgw) }}</td>
				<td class="td7">{{ item.sqry }}</td>
				<td class="td8">{{ formateGlbm_jc(item.sqbm) }}</td>
				<td class="td9">{{ formateShortDate(item.sqrq==null?'':item.sqrq) }}</td>
				<td class="td10"><a href="javascript:;" data-lsh="{{ item.lsh }}" data-ywlx="{{ item.ywlx }}" data-ywyy="{{ item.ywyy }}" data-opt="edit"    class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe60b;</i> 详细</a></td>
			</tr>
			{{# }); }}
		</script>
		<script type="text/javascript">
			//发证机关选择下拉框事件
			var fzjg ='<%=Constant.SYS_PARAM.get("bdfzjg") %>';
			document.getElementById("flow-bdfzjg").value=fzjg;
		</script>
	</body>
</html>
