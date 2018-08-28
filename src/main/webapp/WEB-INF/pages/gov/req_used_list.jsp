<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
		<link rel="stylesheet" href="frm/css/table.css" />
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
		</style>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
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
			}).use(['element','laydate','paging','form','tree','glbmSelect','ajaxTools','hrefTools','domTools'], function() {
			
				var $ = layui.jquery,
				paging = layui.paging(),
				layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
				layer = layui.layer, //获取当前窗口的layer对象
				form = layui.form(),
				hrefTools = layui.hrefTools,
				domTools=layui.domTools;
				ajaxTools = layui.ajaxTools;
				$(function(){
					var bj=$('#bj').val()
					var params = {};
					var url="";
					if(bj=="1"){
						params.glbm = $('#glbm').val();
						params.bj="1";
						url='driving.do?method=getDrivingListPage';
						tpl="tpl1";
					}else if(bj=="3"||bj=="5"){
						params.glbm = $('#glbm').val();
						params.cllx = $('#cllx').val();
						params.bj="1";
						url='veh.do?method=selectListPageVeh';
						tpl="tpl2";
					}else if("4"==bj){
						params.glbm = $('#glbm').val();
						params.bj="1";
						url='driving.do?method=getDrivingListPage';
						tpl="tpl1";
					}else if("6"==bj){
						params.lsh = $('#glbm').val();
						params.bj=bj;
						url='dispatch.do?method=getDispacthDrvVehListPage';
						tpl="tpl1";
					}else if("7"==bj){//tpl1人tpl2车
						params.lsh = $('#glbm').val();
						params.cllx = $('#cllx').val();
						params.bj=bj;
						url='dispatch.do?method=getDispacthDrvVehListPage';
						tpl="tpl2";
					}else{
						params.glbm = $('#glbm').val();
						params.syrs = $('#syrs').val();
						params.cllx = $('#cllx').val();
						params.syrq = $('#syrq').val();
						params.bj="1";
						url='veh.do?method=selectListPageVeh';
						tpl="tpl2";
					}
					queryDrvList(url,params,tpl,bj);
				})
				// bj 1驾驶人  2机动车
				function queryDrvList(url,params,tpl,bj){
					paging.init({
						url: url, //地址
						elem: '#content', //内容容器
						params: params, //发送到服务端的参数
						type: 'POST',
						tempElem: '#'+tpl, //模块容器
						pageConfig: { //分页参数配置
							elem: '#paged', //分页容器
							pageSize: 10 //分页大小
						},
						complate: function() { //完成的回调
							$(window).off('resize',domTools.resizeTableHeight).on('resize', domTools.resizeTableHeight).resize();
							$('#content').children('tr').each(function() {
								var $that = $(this);
								if(bj=="1"||bj=="4"||bj=="6"){
									$that.children('td:last-child').children('a[data-opt=edit1]').on('click', function() {
										getZs($(this).data('jszh'),$(this).data('xm'),bj,'');
									});
								}else{
									$that.children('td:last-child').children('a[data-opt=edit2]').on('click', function() {
										getZs($(this).data('hphm'),$(this).data('hpzl'),bj,$(this).data('cllx'));
									});
								}
							});
							$('#content').children('tr').on('dblclick',function(){
								if(bj=="1"||bj=="4"||bj=="6"){
									getZs($(this).data('jszh'),$(this).data('xm'),bj,'');
								}else{
									getZs($(this).data('hphm'),$(this).data('hpzl'),bj,$(this).data('cllx'));
								}
							});
						}
					})
				}	
				function getZs(zs1,zs2,bj,zs3){
					parent.setZs(zs1,zs2,bj,zs3);
					var index = parent.layer.getFrameIndex(window.name); 
 					parent.layer.close(index);
				}
			});
			
		</script>
	</head>
	<body>
				<input type="hidden" id="glbm" name="glbm" value="${glbm }">
				<input type="hidden" id="bj" name="bj" value="${bj }">
				<input type="hidden" id="syrs" name="syrs" value="${syrs }">
				<input type="hidden" id="cllx" name="cllx" value="${cllx }">
				<input type="hidden" id="syrq" name="syrq" value="${syrq }">
				<div class="admin-main">
				<blockquote class="layui-elem-quote veh-query-form">信息列表</blockquote> 
				<fieldset class="layui-elem-field">
					<div class="layui-field-box layui-form">
						<table id="theadTable" class="layui-table admin-table">
							<thead>
								<c:if test="${bj==1||bj==4||bj==6 }">
								<tr>
									<th style="width:20%">驾驶证号</th>
									<th style="width:19%">姓名</th>
									<th style="width:10%">性别</th>
									<th style="width:15%">出生日期</th>
									<th style="width:15%">手机号码</th>
									<th style="width:11%">准驾车型</th>
									<th style="width:11%">操作</th>
								</tr>
								</c:if>
								<c:if test="${bj==2||bj==3||bj==5||bj==7 }">
									<tr>
										<th style="width:18%">号牌种类</th>
										<th style="width:14%">号牌号码</th>
										<th style="width:12%">车辆类型</th>
										<th style="width:15%">车辆品牌</th>
										<th style="width:15%">核定载客</th>
										<th style="width:16%">累计行驶里程</th>
										<th style="width:11%">操作</th>
									</tr>
								</c:if>
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
		<script type="text/html" id="tpl1">
			{{# layui.each(d.list, function(index, item){ }}
			<tr data-jszh="{{ item.jszh }}" data-xm="{{ item.xm }}">
				<td style="width:20%">{{ item.jszh }}</td>
				<td style="width:19%">{{ item.xm }}</td>
				<td style="width:10%">{{ formateXb(item.xb) }}</td>
				<td style="width:15%">{{ formateShortDate(item.csrq==null?'':item.csrq)}}</td>
				<td style="width:15%">{{ item.sjhm }}</td>
				<td style="width:11%">{{ item.zjcx }}</td>
				<td style="width:11%">
					<a href="javascript:;" data-jszh="{{ item.jszh }}" data-xm="{{ item.xm }}" data-opt="edit1"  class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe605;</i> 选择</a>
				</td>
			</tr>
			{{# }); }}
		</script>
		<script type="text/html" id="tpl2">
			{{# layui.each(d.list, function(index, item){ }}
			<tr data-hphm="{{ item.hphm }}" data-hpzl="{{ item.hpzl }}" data-cllx="{{ item.cllx }}">
				<td style="width:18%">{{ formateHpzl(item.hpzl) }}</td>
				<td style="width:14%">{{ item.hphm }}</td>
				<td style="width:12%">{{ formateCllx(item.cllx) }}</td>
				<td style="width:15%">{{ item.clpp}}</td>
				<td style="width:15%">{{ item.hdzk }}</td>
				<td style="width:16%">{{ item.ljlc }}</td>
				<td style="width:11%">
					<a href="javascript:;" data-hphm="{{ item.hphm }}" data-hpzl="{{ item.hpzl }}" data-cllx="{{ item.cllx }}" data-opt="edit2"  class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe605;</i> 选择</a>
				</td>
			</tr>
			{{# }); }}
		</script>
	</body>
</html>
