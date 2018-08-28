<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>停车场管理</title>
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
			.pak-query-form .layui-input{
				display: inline-block;
			}
			.pak-query-form label{
				padding: 9px 4px 9px 9px;
				vertical-align: middle; 
			}
			.pak-query-form .layui-btn{
				float: right;
				margin-left: 10px;
			}
			.pak-query-form .layui-form-checkbox,.pak-query-form .layui-form-switch{
				margin: 0;
			}
			
			.td1{width:6%;}
			.td2{width:14%;}
			.td3{width:11%;}
			.td4{width:11%;}
			.td5{width:21%;}
			.td6{width:10%;}
			.td7{width:12%;}
			.td8{width:15%;}
		</style>
	</head>

	<body>
		<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
		<input type="hidden" id="hidden-pak-glbm">
		
		<div class="admin-main">

			<form id="mainPakEditForm" name="mainPakEditForm"  class="layui-form">
				<blockquote class="layui-elem-quote pak-query-form">
					<label class="">所属单位</label>
					<input type="text" id="pak-glbm" readonly placeholder="请选择所属单位" class="layui-input" style="width: 160px;">
					
					<label class="">场地分类</label>
					<div class="layui-input-inline" style="width: 100px;" >
						<select id="pak-cdfl" name="pak-cdfl">
							<option value="">请选择场地分类</option>
						</select>
					</div>
					<label class="">场地类型</label>
					<div class="layui-input-inline" style="width: 100px;" >
						<select id="pak-cdlx" name="pak-cdlx">
							<option value="">请选择场地类型</option>
						</select>
					</div>
					<label class="">场地地址</label>
					<div class="layui-input-inline" style="width: 145px;" >
						<input type="text" id="pak-cddz" maxlength="128" placeholder="请输入场地地址" class="layui-input" style="width: 140px;float:left;">
					</div>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="add"><i class="layui-icon" >&#xe654;</i> 新增</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>停车场列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
								<th class="td1">序号</th>
								<th class="td2">所属单位</th>
								<th class="td3">场地分类</th>
								<th class="td4">场地类型</th>
								<th class="td5">场地地址</th>
								<th class="td6">场地性质</th>
<!-- 								<th class="td7">可停车数</th> -->
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
			<tr data-cdbh="{{ item.cdbh }}">
				<td class="td1">{{ index+1 }}</td>
				<td style="display:none;">{{ item.cdbh }}</td>
				<td class="td2">{{ formateGlbm_jc(item.ssdw) }}</td>
				<td class="td3">{{ formateCdfl(item.cdfl) }}</td>
				<td class="td4">{{ formateCdlx(item.cdlx) }}</td>
				<td class="td5">{{ item.cddz }}</td>
				<td class="td6">{{ formateCdxz(item.cdxz) }}</td>
				
				<td class="td8">
					<a href="javascript:;" data-cdbh="{{ item.cdbh }}" data-opt="edit"    class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 编辑</a>
					<a href="javascript:;" data-cdbh="{{ item.cdbh }}" data-opt="del"     class="layui-btn layui-btn-danger layui-btn-mini"><i class="layui-icon">&#xe640;</i> 删除</a>
				</td>
			</tr>
			{{# }); }}
		</script>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="gov/js/pak.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
	</body>
</html>
