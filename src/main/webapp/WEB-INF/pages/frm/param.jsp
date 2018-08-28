<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>参数管理</title>
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
		<style type="text/css">
			html,body{
				height: 100%;
			}
			#depTreeDiv{
				float: left;
				width:202px;
				height: 100%;
				overflow: hidden;
				border-right: 2px solid #3C8DBC;/*#1AA094;*/
			}
			#depTree{
				height: 100%;
				overflow: auto;
				width: 220px;
			}
			#paramQuery{
				margin-left: 204px;
			}
			#paramQuery .layui-tab{
				margin: 0 10px 0 3px;
			}
			#paramQuery .layui-tab-content{
				padding: 0;
			}
			#close{
				position: absolute;
			    right: 0px;
			    top: 5px;
			}
			
			#paramQuery table{
				table-layout: fixed;
			}
			#theadTable1,#theadTable2{
				margin-bottom: 0;
			}
			#tbodyTable1,#tbodyTable2{
				margin-top: 0;
			}
			.td1{width:5%;}
			.td2{width:11%;}
			.td3{width:17%;}
			.td4{width:17%;}
			.td5{width:30%;}
			.td6{width:10%;}
			.td7{width:10%;}
			.longtd{
				overflow: hidden;
				white-space:nowrap;
				text-overflow:ellipsis;
				-o-text-overflow:ellipsis;
			}
		</style>
	</head>

	<body>
		<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
		<input type="hidden" id="curr-user-bmjb" value="${userSession.dep.bmjb }">
		<input type="hidden" id="hidden-ps-glbm" value="${userSession.dep.glbm }">
		<input type="hidden" id="hidden-ps-bmjc" value="${userSession.dep.bmjc }">
		
		<div id="depTreeDiv">
			<div id="depTree" class="ztree">
				<i style="display:inline-block" class="layui-icon layui-anim layui-anim-rotate layui-anim-loop">&#xe63d;</i>正在加载……
			</div>
		</div>
		<div id="paramQuery">
			<form method="post" class="layui-form">
				<div class="layui-tab  layui-tab-brief" lay-filter="ParamTab">
				  <ul class="layui-tab-title">
				    <li class="layui-this">系统参数</li>
				    <li>业务参数</li>
				    <a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
				  </ul>
				  <div class="layui-tab-content">
				    <div class="layui-tab-item layui-show">
						<div>
							<table id="theadTable1" class="layui-table admin-table">
								<thead>
									<tr>
										<th class="td1">序号</th>
										<th class="td2">参数关键字</th>
										<th class="td3">参数名称</th>
										<th class="td4">参数值</th>
										<th class="td5">参数说明</th>
										<th class="td6">参数属性</th>
										<th class="td7">操作</th>
									</tr>
								</thead>
							</table>
							<div id="contentDiv1">
								<table id="tbodyTable1" class="layui-table admin-table">
									<tbody id="content1">
									</tbody>
								</table>
							</div>
						</div>
						<div class="admin-table-page">
							<div id="paged1" class="page">
							</div>
						</div>
				    </div>
				    <div class="layui-tab-item">
						<div class="">
							<table id="theadTable2" class="layui-table admin-table">
								<thead>
									<tr>
										<th class="td1">序号</th>
										<th class="td2">参数关键字</th>
										<th class="td3">参数名称</th>
										<th class="td4">参数值</th>
										<th class="td5">参数说明</th>
										<th class="td6">参数属性</th>
										<th class="td7">操作</th>
									</tr>
								</thead>
							</table>
							<div id="contentDiv2">
								<table id="tbodyTable2" class="layui-table admin-table">
									<tbody id="content2">
									</tbody>
								</table>
							</div>
						</div>
						<div class="admin-table-page">
							<div id="paged2" class="page">
							</div>
						</div>
				    </div>
				  </div>
				</div>
			</form>
		</div>
		
		<!--模板-->
		<script type="text/html" id="tpl">
			{{# layui.each(d.list, function(index, item){ }}
			<tr data-gjz="{{ item.gjz }}" data-xtlb="{{ item.xtlb }}">
				<td class="td1">{{ index+1 }}</td>
				<td class="td2">{{ item.gjz }}</td>
				<td class="td3">{{ item.csmc }}</td>
				<td class="td4 longtd">{{ item.csz }}</td>
				<td class="td5 longtd">{{ item.cssm }}</td>
				<td class="td6">{{ formateCssx(item.cssx) }}</td>
				
				<td class="td7">
					<a href="javascript:;" data-gjz="{{ item.gjz }}" data-xtlb="{{ item.xtlb }}" data-opt="edit" class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 编辑</a>
				</td>
			</tr>
			{{# }); }}
		</script>
		
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="frm/js/param.js"></script>
	</body>
</html>
