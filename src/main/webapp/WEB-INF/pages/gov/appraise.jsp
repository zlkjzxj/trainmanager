<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>用车评价</title>
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
			.td6{width:13%;}
			.td7{width:10%;}
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
				
				//自定义验证规则  
				form.verify({  
					hphm: [/^[A-Z_0-9]{5}|[A-Z_0-9]{0}$/, '号牌号码必须为5位数字或数字与字母组合！']
				});
				
				//初始换管理部门下拉选择框
				var glbmSelect = layui.glbmSelect({bgColor:'#F9FAFC',area:['200px','100px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
				//管理部门选择下拉框事件
// 				$('#drv-glbm').on('click',function(){
// 					glbmSelect.show($('#drv-glbm'),function(node){
// 						$('#drv-glbm').val(node.name);
// 						$('#hidden-drv-glbm').val(node.tags.glbm);
// 					},$('#hidden-drv-glbm').val());
// 				});
				//用车评价
				ajaxTools.loadCodeData($('#raise-ycpj'),{dmmc:'ycpj'},false,'','code.do?method=selectListCode','用车评价');
				form.render('select');
	
				//关闭按钮
				$('#close').on('click',function(){
					top.closeTab(hrefTools.getLocationParam('cxdh'));
				});
				//查询按钮
				$('#query').on('click',function(){
					queryFlowList();
				});
				
				
				//定义一个刷新列表的方法，方便子iframe页面刷新父页面列表
				window.refreshVehList = function(){
					paging.reload();
				}
				window.reQueryVehList = function(){
					queryFlowList();
				}
				function queryFlowList(){
					if(form.verifyForm(mainForm)){//form.verifyForm返回ture表示表单验证成功
						var params = {};
						var url='';
						var ycpj = $('#raise-ycpj').val();
						var fzjg = $('#veh-bdfzjg').val();
						var hphm = $('#veh-hphm').val();
						if(hphm!=""&&hphm!=null){
							var reg = /^[A-Z_0-9]{5}$/
							if(!reg.test(hphm)){
								layer.msg("号牌号码必须为数字或数字与字母组合！", {icon: 5,shift: 6});
								return;
							}
							params.hphm = fzjg+hphm;
						}else{
							params.hphm = '';
						}
						params.sqry = $('#pjr').val();
						params.glbm = $('#curr-user-glbm').val();
						params.lsh= $('#lsh').val();
						params.bhxj= "0";
						params.jsry= $('#jsry').val();
						
						if(1==ycpj){
							url='flow.do?method=getAppraise';
						}else{
							url='flow.do?method=getNotAppraise';
						}
						//初始化
						paging.init({
							url: url, //地址
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
				}
				function openFlowEdit(lsh){
					var pjr = $("#pjr").val();
					var condition = (!lsh)?'':'&lsh='+lsh;
					var condition1 = (!pjr)?'':'&pjr='+pjr;
					layer.open({
						type: 2,
						id:'backEdit',
						content:['appraise.do?method=forwardAppraiseEditPage'+condition+condition1],
						title: '用车评价信息', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
						shade: 0.2,
						offset: ['30px', '10%'],
						area: ['800px', '500px'],
						zIndex: 999,
						moveOut: true,
						maxmin: false,
						btn: 0 	//['新增','保存', '取消']
					});
				}
				//重置按钮
				$('#reset').on('click',function(){
					$('#hidden-glbm').val('');
					$('#lsh').val('');
					$('#veh-hphm').val('');
					$('#jsry').val('');
					$('#raise-ywyy').val('A');
					form.render();
				});
			});
		</script>
	</head>

	<body>
		<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
		<input type="hidden" id="hidden-glbm">
		<input type="hidden" id="pjr" name="pjr" value="${userSession.user.xm }">
		<div class="admin-main">
			<form class="layui-form" name="mainForm" id="mainForm">
				<blockquote class="layui-elem-quote req-query-form">
					<label class="">流水号</label>
					<input type="text" id="lsh" class="frm-input" style="width:180px" placeholder="请输入流水号" maxlength="13">
					<label class="">驾驶员姓名</label>
					<input type="text" id="jsry" name="jsry" class="frm-input" style="width:180px" placeholder="请输入驾驶员姓名" maxlength="13">
					<label class="">号牌号码</label>
					<div class="layui-input-inline" >
						<input type="text" id="veh-bdfzjg" value="" readonly class="layui-input" style="width: 40px;float:left;">
						<input type="text" id="veh-hphm" onkeyup="this.value=this.value.toUpperCase()" maxlength="5" lay-verify="hphm" placeholder="请输入号牌号码" class="layui-input" style="width: 140px;float:left;">
					</div>
					<label class="">用车评价</label>
					<div class="layui-input-inline" style="width: 100px;" >
						<select id="raise-ycpj" name="ycpj">
							<option value="">请选择评价类型</option>
						</select>
					</div>
					<div class="layui-input-inline" style="float: right;margin-top: 5px;">
						<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
						<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
						<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
					</div>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>用车评价信息列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
								<th class="td1">序号</th>
								<th class="td2">流水号</th>
								<th class="td3">业务类型</th>
								<th class="td4">业务原因</th>
								<th class="td5">号牌号码</th>
								<th class="td6">开始时间</th>
								<th class="td7">操作</th>
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
				<td class="td5">{{ item.hphm==null?'':item.hphm }}</td>
				<td class="td6">{{ formateShortDate(item.kssj==null?'':item.kssj) }}</td>
				<td class="td7"><a href="javascript:;" data-lsh="{{ item.lsh }}" data-opt="edit"    class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe60c;</i> 评价</a></td>
			</tr>
			{{# }); }}
		</script>
		<script type="text/javascript">
			//发证机关选择下拉框事件
			var fzjg ='<%=Constant.SYS_PARAM.get("bdfzjg") %>';
			document.getElementById("veh-bdfzjg").value=fzjg;
		</script>
	</body>
</html>
