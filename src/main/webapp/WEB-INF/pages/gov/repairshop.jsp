<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>定点保养维护单位管理</title>
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
			.user-query-form .layui-input{
				display: inline-block;
				height:32px;
				line-height: 32px;
				vertical-align: middle;
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
			.td3{width:8%;}
			.td4{width:20%;}
			.td5{width:20%;}
			.td6{width:8%;}
			.td7{width:13%;}
			.td8{width:5%;}
			.td9{width:13%;}
						
		</style>
	</head>

	<body>
	     <input type="hidden" id="curr-dep-glbm" value="${userSession.dep.glbm }">
		 <input type="hidden" id="curr-user-xm"  value="${userSession.user.xm }"/>
		 <input type="hidden" id="repair-gnid">
		
		<div class="admin-main">
			<form class="layui-form">
				<blockquote class="layui-elem-quote user-query-form">
					<label class="">单位类型</label>
					<div class="layui-input-inline" >
						<select id="Dwlx" name="Dwlx" lay-filter="dwlxSelect" placeholder="请选择单位类型" lay-verify="required">
						        <option value="">请选择单位类型</option>
						</select>
					</div>
					<label class="">单位名称</label>
                        <input type="text" id="dwmc" name="dwmc"  lay-verify="requieed" maxlength="40" placeholder="请输入单位名称" class="layui-input" style="width:300px;">   					
					<a href="javascript:;" class="layui-btn layui-btn-small" id="closeym"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="add"><i class="layui-icon" >&#xe654;</i> 新增</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>定点保养维护管理列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
								<th class="td1">序号<!-- <input type="checkbox" lay-filter="allselector" lay-skin="primary"> --></th>
								<th class="td2">单位编号</th>
								<th class="td3">单位类型</th>
								<th class="td4">单位名称</th>
								<th class="td5">单位地址</th>
								<th class="td6">联系人</th>
								<th class="td7">联系电话</th>
								<th class="td8">状态</th>
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
			{{# layui.each(d.list, function(index, shop){ }}
			<tr data-dwbh="{{ shop.dwbh }}">
				<td class="td1">{{index+1}}</td>
				<td class="td2">{{ shop.dwbh}}</td>
                <td class="td3">{{formateDwlx(shop.dwlx)}}</td>
				<td class="td4">{{ shop.dwmc}}</td>
				<td class="td5">{{ shop.dwdz}}</td>
                <td class="td6">{{ shop.lxr }}</td>
				<td class="td7">{{ shop.lxrdh}}</td>
                <td class="td8">{{formateZt(shop.zt)}}</td>
				<td class="td9">
				 <a href="javascript:;" data-dwbh="{{ shop.dwbh }}" data-opt="edit"    class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 编辑</a>
				<a href="javascript:;" data-dwbh="{{ shop.dwbh }}"  data-dwmc="{{shop.dwmc}}"  data-opt="del"     class="layui-btn layui-btn-danger layui-btn-mini"><i class="layui-icon">&#xe640;</i> 删除</a>
				</td>
			</tr>
			{{# }); }}
		</script>
		
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="gov/js/repairshop.js"></script>
	   </body>
</html>
