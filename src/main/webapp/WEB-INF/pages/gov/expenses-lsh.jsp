<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>费用登记管理</title>
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
		<script type="text/javascript">
		
		</script>
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
			
			.td1{width:6%;}
			.td2{width:10%;}
			.td3{width:10%;}
			.td4{width:10%;}
			.td5{width:10%;}
			.td6{width:10%;}
			.td7{width:10%;}
			.td8{width:6%;}
		</style>
	</head>

	<body>
	    <input type="hidden" id="curr-user-glbm" name="glbm" value="${userSession.dep.glbm }">
		<div class="admin-main">
				<blockquote class="layui-elem-quote veh-query-form">
				</blockquote>
			<fieldset class="layui-elem-field">
				<legend>流水信息管理列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
						        <th class="td1">序号</th>
								<th class="td2">流水号</th>
								<th class="td3">号牌种类</th>
								<th class="td4">号牌号码</th>
								<th class="td5">申请部门</th>
								<th class="td6">申请人员</th>
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
			<tr data-lsh="{{ item.lsh }}" data-hpzl="{{item.hpzl}}" data-hphm="{{item.hphm}}">
				<td class="td1">{{ index+1 }}</td>
				<td class="td2">{{item.lsh}}</td>
				<td class="td3">{{formateHpzl(item.hpzl)}}</td>
				<td class="td4">{{item.hphm}}</td>
				<td class="td5">{{formateGlbm_jc(item.sqbm)}}</td>
                <td class="td6">{{item.sqry}}</td>
				<td class="td7">
					<a href="javascript:;" data-hphm="{{ item.hphm }}" data-hpzl="{{ item.hpzl }}"  data-lsh="{{ item.lsh }}" " data-opt="edit2"  class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe605;</i> 选择</a>
				</td>
			</tr>
			{{# }); }}
		</script>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="gov/js/expenses-lsh.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
	</body>
</html>
