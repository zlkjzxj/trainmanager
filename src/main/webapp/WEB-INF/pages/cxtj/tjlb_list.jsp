<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>统计列表</title>
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
					params.para = $('#para').val();
					params.bj = bj;
					var tpl="";
					var url="";
					if(bj=="drv"){
						tpl="tpl1";
					}else if(bj=="veh"){
						tpl="tpl2";
					}else if("flow"==bj){
						tpl="tpl3";
					}else{
						tpl="tpl4";
					}
					queryDrvList(params,tpl);
				})
				function queryDrvList(params,tpl){
					paging.init({
						url: 'main.do?method=selectObjectListPage', //地址
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
						}
					})
				}	
			});
			
		</script>
	</head>
	<body>
				<input type="hidden" id="para" name="para" value="${para }">
				<input type="hidden" id="bj" name="bj" value="${bj }">
				<div class="admin-main">
				<blockquote class="layui-elem-quote veh-query-form">信息列表</blockquote> 
				<fieldset class="layui-elem-field">
					<div class="layui-field-box layui-form">
						<table id="theadTable" class="layui-table admin-table">
							<thead>
								<c:if test="${bj=='drv' }">
								<tr>
									<th style="width:10%">序号</th>
									<th style="width:18%">驾驶证号</th>
									<th style="width:18%">姓名</th>
									<th style="width:12%">性别</th>
									<th style="width:15%">出生日期</th>
									<th style="width:12%">准驾车型</th>
									<th style="width:15%">状态</th>
								<tr>
								</tr>
								</c:if>
								<c:if test="${bj=='veh' }">
									<tr>
										<th style="width:10%">序号</th>
										<th style="width:18%">号牌种类</th>
										<th style="width:14%">号牌号码</th>
										<th style="width:12%">车辆类型</th>
										<th style="width:15%">车辆品牌</th>
										<th style="width:15%">核定载客</th>
										<th style="width:16%">状态</th>
									</tr>
								</c:if>
								<c:if test="${bj=='flow' }">
									<tr>
										<th style="width:8%">序号</th>
										<th style="width:15%">流水号</th>
										<th style="width:16%">业务类型</th>
										<th style="width:13%">业务原因</th>
										<th style="width:15%">申请人</th>
										<th style="width:18%">申请单位</th>
										<th style="width:15%">申请日期</th>
									</tr>
								</c:if>
								<c:if test="${bj=='vehused' }">
									<tr>
										<th style="width:10%">序号</th>
										<th style="width:15%">流水号</th>
										<th style="width:12%">业务类型</th>
										<th style="width:15%">业务原因</th>
										<th style="width:15%">申请人</th>
										<th style="width:18%">申请单位</th>
										<th style="width:15%">申请日期</th>
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
			<tr>
				<td class="td1">{{ index+1 }}</td>
				<td style="width:18%">{{ item.jszh }}</td>
				<td style="width:18%">{{ item.xm }}</td>
				<td style="width:12%">{{ formateXb(item.xb) }}</td>
				<td style="width:15%">{{ formateShortDate(item.csrq==null?'':item.csrq)}}</td>
				<td style="width:12%">{{ item.zjcx }}</td>
				<td style="width:15%">{{ formateDrvbdzt(item.bdzt) }}</td>
			</tr>
			{{# }); }}
		</script>
		<script type="text/html" id="tpl2">
			{{# layui.each(d.list, function(index, item){ }}
			<tr>
				<td class="td1">{{ index+1 }}</td>
				<td style="width:18%">{{ formateHpzl(item.hpzl) }}</td>
				<td style="width:14%">{{ item.hphm }}</td>
				<td style="width:12%">{{ formateCllx(item.cllx) }}</td>
				<td style="width:15%">{{ item.clpp}}</td>
				<td style="width:15%">{{ item.hdzk }}</td>
				<td style="width:16%">{{ formateBdzt(item.bdzt) }}</td>
			</tr>
			{{# }); }}
		</script>
		<script type="text/html" id="tpl3">
			{{# layui.each(d.list, function(index, item){ }}
			<tr>
				<td style="width:8%">{{ index+1 }}</td>
				<td style="width:15%">{{ item.lsh }}</td>
				<td style="width:16%">{{ formateYwlx(item.ywlx) }}</td>
				<td style="width:13%">{{ formateYwYy(item.ywyy,item.ywlx) }}</td>
				<td style="width:15%">{{ item.sqry }}</td>
				<td style="width:18%">{{ formateGlbm_jc(item.sqbm) }}</td>
				<td style="width:15%">{{ formateShortDate(item.sqrq==null?'':item.sqrq) }}</td>
			</tr>
			{{# }); }}
		</script>
		<script type="text/html" id="tpl4">
			{{# layui.each(d.list, function(index, item){ }}
			<tr>
				<td style="width:10%">{{ index+1 }}</td>
				<td style="width:15%">{{ item.lsh }}</td>
				<td style="width:12%">{{ formateYwlx(item.ywlx) }}</td>
				<td style="width:15%">{{ formateYwYy(item.ywyy,item.ywlx) }}</td>
				<td style="width:15%">{{ item.sqry }}</td>
				<td style="width:18%">{{ formateGlbm_jc(item.glbm) }}</td>
				<td style="width:15%">{{ formateShortDate(item.gxsj==null?'':item.gxsj) }}</td>
			</tr>
			{{# }); }}
		</script>
	</body>
</html>
