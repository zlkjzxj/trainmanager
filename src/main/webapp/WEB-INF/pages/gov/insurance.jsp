<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>保险登记管理</title>
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
			.td2{width:6%;}
			.td3{width:10%;}
			.td4{width:11%;}
			.td5{width:13%;}
			.td6{width:15%;}
			.td7{width:15%;}
			.td8{width:8%;}
			.td9{width:6%;}
		</style>
	</head>

	<body>
	    <input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
	    <input type="hidden" id="curr-user-bmjc" value="${userSession.dep.bmjc }">
		<input type="hidden" id="hidden-ince-glbm" value="${userSession.dep.glbm}">
		
		<div class="admin-main">

			<form id="mainVehEditForm" name="mainVehEditForm"  class="layui-form">
				<blockquote class="layui-elem-quote veh-query-form">
					<label class="">管理部门</label>
					<input type="text" id="ince-glbm" readonly value="${userSession.dep.bmjc }" placeholder="请选择管理部门" class="layui-input" style="width: 180px;">				
					
					<label class="">号牌种类</label>
						<div class="layui-input-inline" >
							<select id="hpzl" name="hpzl" lay-filter="hpzlSelect" placeholder="请选择号牌种类"  lay-verify="required">
						        <option value="">请选择号牌种类</option>
							</select>
						</div>
					
					<label class="">号牌号码</label>
					<div class="layui-input-inline" >
						<input type="text" id="ince-bdfzjg" value="" readonly class="layui-input" style="width: 40px;float:left;">
						<input type="text" id="ince-hphm"  onkeyup="this.value=this.value.toUpperCase()" maxlength="5" lay-verify="hphm1" placeholder="请输入号牌号码" class="layui-input" style="width: 140px;float:left;">
					</div>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="add"><i class="layui-icon" >&#xe654;</i> 新增</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
				</blockquote>
			</form>
			<fieldset class="layui-elem-field">
				<legend>保险登记信息管理列表</legend>
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
						        <th class="td1">序号</th>
						        <th class="td2">保险种类</th>
								<th class="td3">保险单号</th>
								<th class="td4">号牌种类</th>
								<th class="td5">号牌号码</th>
								<th class="td6">保险有效期始</th>
								<th class="td7">保险有效期止</th>
								<th class="td8">保险金额</th>
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
			{{# layui.each(d.list, function(index, item){ }}
			<tr data-hphm="{{ item.hphm }}" data-bxdh="{{item.bxdh}}">
				<td class="td1">{{ index+1 }}</td>
                <td class="td2">{{formatebxzl(item.bxzl)}}</td>
				<td class="td3">{{item.bxdh}}</td>
				<td class="td4">{{formateHpzl(item.hpzl)}}</td>
				<td class="td5">{{item.hphm}}</td>
				<td class="td6">{{formateShortDate(item.bxyxqs)}}</td>
				<td class="td7">{{formateShortDate(item.bxyxqz)}}</td>
                <td class="td8">{{item.bxje}}</td>
				<td class="td9">
			<a href="javascript:;" data-hpzl="{{ item.hpzl }}" data-hphm="{{ item.hphm }}" data-bxdh="{{item.bxdh}}" data-opt="edit"   class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 编辑</a>
				</td>
			</tr>
			{{# }); }}
		</script>
		
		<script type="text/javascript">
			//发证机关选择下拉框事件
			var fzjg ='<%=Constant.SYS_PARAM.get("bdfzjg") %>';
			document.getElementById("ince-bdfzjg").value=fzjg;
		</script>
		
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="gov/js/insurance.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
	</body>
</html>
