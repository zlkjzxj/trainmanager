<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="frm/css/global.css" media="all">
<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="frm/css/frmColors.css" type="text/css">
<style type="text/css">
	form#mainRoleEditForm{
		padding: 20px 20px 0 0;
	}
	.layui-form-checkbox[lay-skin=primary]{
		min-height: 32px;
		line-height: 32px;
		margin-top: 0;
	}
	#re-czqx .layui-colla-item .layui-colla-title{
		padding-left: 12px;
	}
	#re-czqx .layui-colla-item .layui-colla-title>i{
		display: none;
	}
	#re-czqx .layui-colla-title .layui-form-checkbox{
		margin: 0 5px 0 7px;
	}
	#re-czqx .layui-colla-title .all{
		float: right;
	}
	#re-czqx .layui-form-label{
		padding-left: 0;
		padding-right: 0;
	}
</style>
</head>
<body>
	<div id="content"><!-- 页面所有内容都要放到这个div中，方便后面调方法创建layer底部按钮 -->
		<form id="mainRoleEditForm" name="mainRoleEditForm" class="layui-form" method="post">
			<input type="hidden" id="opr" name="opr" value="${opr }">  <!-- e:编辑  a:新增 v:查看 -->
			<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
			<input type="hidden" id="hidden-re-qxcjbm" name="qxcjbm" value="${(opr.equals('e')||opr.equals('v'))?role.qxcjbm:userSession.dep.glbm }">
			<input type="hidden" id="hidden-re-qxgroup" name="qxgroup" value="${role.qxgroup }">
			<input type="hidden" id="hidden-re-qxsyjb" name="qxsyjb" value="${role.qxsyjb }">
			<input type="hidden" id="hidden-re-cxdh" value="${role.cxdh }">
 
			<div class="frm-row">
				<label class="frm-label frm-col-4">角色名称</label>
				<div class="frm-col-8">
					<input type="text" id="re-qxgroupmc" name="qxgroupmc" lay-verify="required" style="width: 90%;" class="frm-input" value="${role.qxgroupmc }">
				</div>
				<label class="frm-label frm-col-4">是否管理员</label>
				<div class="frm-col-8">
					<input type="checkbox" id="re-sfgly" class="frm-input" lay-filter="SfglySwitch" data-value="${role.sfgly }" lay-text="是|否" lay-skin="switch">
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-4">使用级别</label>
				<div class="frm-col-20" id="re-qxsyjb-div" ></div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-4">操作权限</label>
				<div class="frm-col-20">
					<div id="re-czqx" class="layui-collapse" lay-accordion></div>
				</div>
			</div>
		</form>
	</div>

	<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
	<script type="text/javascript" src="common/js/translation.js"></script>
	<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
	<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
	<script type="text/javascript" src="frm/js/role-edit.js"></script>
</body>
</html>
