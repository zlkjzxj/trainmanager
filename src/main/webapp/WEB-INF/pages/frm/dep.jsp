<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>部门管理</title>
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
				border-right: 2px solid #3C8DBC;
			}
			#depTree{
				height: 100%;
				overflow: auto;
				width: 220px;
			}
			#depEdit{
				overflow: auto;
				margin-left: 204px;
				padding:0;
				height: 100%;
				overflow: hidden;
			}
			#depEdit>form{
				height:100%;
				box-sizing: border-box !important;
			    -webkit-box-sizing: border-box !important;
			    -moz-box-sizing: border-box !important;
				padding: 20px 30px 0 0;
				overflow: auto;
			}
		</style>
	</head>

	<body>
		<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
		<div id="depTreeDiv">
			<div id="depTree" class="ztree">
				<i style="display:inline-block" class="layui-icon layui-anim layui-anim-rotate layui-anim-loop">&#xe63d;</i> 正在加载……
			</div>
		</div>
		<div id="depEdit">
			<form id="mainDepEditForm" name="mainDepEditForm" method="post" class="layui-form">
				<input type="hidden" id="opr" value="e"> <!-- e:编辑  a:新增 v:查看 -->
				<input type="hidden" id="hidden-de-glbm" name="glbm" value="${userSession.dep.glbm }">
				<input type="hidden" id="hidden-de-bmjb" name="bmjb" value="${userSession.dep.bmjb }">
				<input type="hidden" id="hidden-de-sjbm" name="sjbm" value="${userSession.dep.sjbm }">
				
				<div class="frm-row">
					<label class="frm-label frm-col-3">上级部门</label>
					<div class="frm-col-5">
						<input type="text" id="de-sjbm" disabled data-value="${userSession.dep.sjbm }" lay-verify="required" placeholder="请选择上级部门" class="frm-input">
					</div>
					<label class="frm-label frm-col-3">部门级别</label>
					<div class="frm-col-5">
						<select id="de-bmjb" disabled data-value="${userSession.dep.bmjb }" placeholder="请选择部门级别" lay-verify="required">
					        <option value="3">中心</option>
					        <option value="4">单位</option>
						</select>
					</div>
					<label class="frm-label frm-col-3">组织机构代码</label>
					<div class="frm-col-5">
						<input type="text" id="de-zzjgdm" name="zzjgdm" value="${userSession.dep.zzjgdm }"  placeholder="请输入组织机构代码" class="frm-input">
					</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3">部门简称</label>
					<div class="frm-col-5">
						<input type="text" id="de-bmjc" name="bmjc" value="${userSession.dep.bmjc }" lay-verify="required" placeholder="请输入部门简称" class="frm-input">
					</div>
					<label class="frm-label frm-col-3">部门全称</label>
					<div class="frm-col-13">
						<input type="text" id="de-bmmc" name="bmmc" value="${userSession.dep.bmmc }" lay-verify="required" placeholder="请输入部门全称" class="frm-input">
					</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3">负责人</label>
					<div class="frm-col-5">
						<input type="text" id="de-fzr" name="fzr" value="${userSession.dep.fzr }" lay-verify="required" placeholder="请输入负责人" class="frm-input">
					</div>
					<label class="frm-label frm-col-3">联系人</label>
					<div class="frm-col-5">
						<input type="text" id="de-lxr" name="lxr" value="${userSession.dep.lxr }" lay-verify="required" placeholder="请输入联系人" class="frm-input">
					</div>
					<label class="frm-label frm-col-3">联系电话</label>
					<div class="frm-col-5">
						<input type="text" id="de-lxdh" name="lxdh" value="${userSession.dep.lxdh }" lay-verify="required|strictPhone" placeholder="请输入联系电话" class="frm-input">
					</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3">联系地址</label>
					<div class="frm-col-21">
						<input type="text" id="de-lxdz" name="lxdz" value="${userSession.dep.lxdz }" lay-verify="required" placeholder="请输入联系地址" class="frm-input">
					</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3">管理体制</label>
					<div class="frm-col-5">
						<select id="de-gltz" name="gltz" data-value="${userSession.dep.gltz }"  placeholder="请选择管理体制">
							<option value="">请选择管理体制</option>
						</select>
					</div>
					<label class="frm-label frm-col-3">建制级别</label>
					<div class="frm-col-5">
						<select id="de-jzjb" name="jzjb" data-value="${userSession.dep.jzjb }" placeholder="请选择建制级别">
							<option value="">请选择建制级别</option>
						</select>
					</div>
					<label class="frm-label frm-col-3">隶属关系</label>
					<div class="frm-col-5">
						<select id="de-lsgx" name="lsgx" data-value="${userSession.dep.lsgx }" placeholder="请选择隶属关系" >
							<option value="">请选择隶属关系</option>
						</select>
					</div>
				</div>
				<div class="frm-row" style="text-align: right;margin-top: 50px;">
					<a href="javascript:;" class="layui-btn layui-btn-small layui-btn-disabled" id="add"><i class="layui-icon" >&#xe654;</i> 新增</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="seal-edit"><i class="layui-icon" >&#xe64a;</i> 印章维护</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="save"><i class="layui-icon" >&#xe605;</i> 保存</a>
					<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
				</div>
			</form>
		</div>
		
		
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="frm/js/dep.js"></script>
	</body>
</html>
