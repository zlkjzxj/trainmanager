<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>业务审批</title>
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
			
			.td1{width:6%;}
			.td2{width:10%;}
			.td3{width:11%;}
			.td4{width:11%;}
			.td5{width:11%;}
			.td6{width:14%;}
			.td7{width:12%;}
			.td8{width:15%;}
		</style>
	</head>

	<body>
		<div class="admin-main">

			<form id="mainflowEditForm" name="mainflowEditForm"  class="layui-form">
				<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
				<input type="hidden" id="hidden-flow-glbm">
				<input type="hidden" id="hidden-flow-ywlx">
				<blockquote class="layui-elem-quote flow-query-form">
<!-- 					<label class="">申请部门</label> -->
<!-- 					<input type="text" id="flow-glbm" readonly placeholder="请选择申请部门" class="layui-input" style="width: 160px;"> -->
					
					<label class="">业务类型</label>
					<div class="layui-input-inline" >
						<select id="flow-ywlx" name="flow-ywlx">
							<option value="">请选择业务类型</option>
						</select>
					</div>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>业务审批列表</legend>
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
			<tr data-ywlx="{{ item.ywlx }}" data-lsh="{{ item.lsh }}">
				<td class="td1">{{ index+1 }}</td>
				<td class="td2">{{ item.lsh }}</td>
				<td class="td3">{{ formateYwlx(item.ywlx) }}</td>
				<td class="td4">{{ formateYwYy(item.ywyy,item.ywlx) }}</td>
				<td class="td5">{{ item.sqry }}</td>
				<td class="td6">{{ formateGlbm_jc(item.sqbm) }}</td>
				<td class="td7">{{ formateShortDate(item.sqrq==null?'':item.sqrq) }}</td>
				
				<td class="td8">
					<a href="javascript:;" data-ywlx="{{ item.ywlx }}" data-lsh="{{ item.lsh }}" data-opt="edit"   class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 审批</a>
					<!--<a href="javascript:;" data-lsh="{{ item.lsh }}" data-opt="del"     class="layui-btn layui-btn-danger layui-btn-mini"><i class="layui-icon">&#xe640;</i> 删除</a>-->
				</td>
			</tr>
			{{# }); }}
		</script>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="gov/js/audit1.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
	</body>
</html>
