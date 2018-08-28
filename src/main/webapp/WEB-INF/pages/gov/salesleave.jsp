<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>销假登记</title>
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
			.td2{width:12%;}
			.td3{width:11%;}
			.td4{width:11%;}
			.td5{width:11%;}
			.td6{width:13%;}
			.td7{width:8%;}
			.td8{width:15%;}
		</style>
	</head>

	<body>
		<div class="admin-main">
			<form id="mainflowEditForm" name="mainflowEditForm"  class="layui-form">
				<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
				<blockquote class="layui-elem-quote flow-query-form">
<!-- 					<label class="">申请部门</label> -->
<!-- 					<input type="text" id="flow-glbm" readonly placeholder="请选择申请部门" class="layui-input" style="width: 160px;"> -->
					
<!-- 					<label class="">业务原因</label> -->
<!-- 					<div class="layui-input-inline" > -->
<!-- 						<select id="flow-ywyy" name="ywyy"> -->
<!-- 							<option value="">请选择业务原因</option> -->
<!-- 						</select> -->
<!-- 					</div> -->
					<label class="">流水号</label>
					<input type="text" id="lsh" class="layui-input" style="width:180px" placeholder="请输入流水号" maxlength="13">
					<label class="">申请日期</label>
					<input class="layui-input" id="dis-sqrq" onclick="layui.laydate({elem: this})"  type="text" placeholder="请选择日期" readonly autocomplete="off" style="width:180px;">
					<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>请休假信息列表</legend>
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
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="gov/js/salesleave.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
	</body>
</html>
