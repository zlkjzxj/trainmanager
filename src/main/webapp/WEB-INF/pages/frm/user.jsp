<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>用户管理</title>
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
		<link rel="stylesheet" href="common/js/zTree_v3-master/css/zTreeStyle/zTreeStyle.css">
		<!-- <link rel="stylesheet" href="frm/css/table.css" /> -->
		<style type="text/css">
			.layui-elem-quote{
				padding: 9px 10px;
			}
			.layui-elem-quote:after {
				content:"."; 
				display:block; 
				height:0; 
				visibility:hidden;
				clear:both; 
			}
			.user-query-form .layui-input{
				display: inline-block;
			}
			.user-query-form label{
				padding: 9px 4px 9px 9px;
				vertical-align: middle; 
			}
			.user-query-form .layui-btn{
				float: right;
				margin-left: 10px;
			}
			.user-query-form .layui-form-checkbox,.user-query-form .layui-form-switch{
				margin: 0;
			}
			
			
			.td1{width:5%;}
			.td2{width:8%;}
			.td3{width:10%;}
			.td4{width:20%;}
			.td5{width:15%;}
			.td6{width:15%;}
			.td7{width:27%;}
		</style>
	</head>

	<body>
		<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
		<input type="hidden" id="curr-user-bmjc" value="${userSession.dep.bmjc }">
		<input type="hidden" id="hidden-us-glbm" value="${userSession.dep.glbm }">
		
		<div class="admin-main">

			<form class="layui-form">
				<blockquote class="layui-elem-quote user-query-form">
					<label class="">管理部门</label>
					<input type="text" id="us-glbm" value="${userSession.dep.bmjc }" readonly placeholder="请选择管理部门" class="layui-input" style="width: 180px;">
					
					<input type="checkbox" id="us-bhxj" title="含下级">
					
					<label class="">用户姓名</label>
					<input type="text" id="us-xm" placeholder="请输入用户姓名" class="layui-input" style="width: 140px;">
					
					<label class="">管理员</label>
					<input type="checkbox" id="us-sfgly" lay-text="是|否" lay-skin="switch">
					
					<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="add"><i class="layui-icon" >&#xe654;</i> 新增</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>用户列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
								<th class="td1">序号<!-- <input type="checkbox" lay-filter="allselector" lay-skin="primary"> --></th>
								<th class="td2">用户代号</th>
								<th class="td3">用户姓名</th>
								<th class="td4">管理部门</th>
								<th class="td5">用户有效期</th>
								<th class="td6">密码有效期</th>
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
			<tr data-yhdh="{{ item.yhdh }}">
				<td class="td1">{{ index+1 }}</td>
				<td class="td2">{{ item.yhdh }}</td>
				<td class="td3">{{ item.xm }}</td>
				<td class="td4">{{ formateGlbm_jc(item.glbm) }}</td>
				<td class="td5">{{ formateShortDate(item.yhyxq) }}</td>
				<td class="td6">{{ formateShortDate(item.mmyxq) }}</td>
				
				<td class="td7">
					<a href="javascript:;" data-yhdh="{{ item.yhdh }}" data-opt="edit"    class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 编辑</a>
					<a href="javascript:;" data-yhdh="{{ item.yhdh }}" data-opt="del"     class="layui-btn layui-btn-danger layui-btn-mini"><i class="layui-icon">&#xe640;</i> 删除</a>
					<a href="javascript:;" data-yhdh="{{ item.yhdh }}" data-opt="resetmm" class="layui-btn layui-btn-normal layui-btn-mini"><i class="layui-icon">&#xe628;</i> 密码重置</a>
				</td>
			</tr>
			{{# }); }}
		</script>
		
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="frm/js/user.js"></script>
	</body>
</html>
