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
		<link rel="stylesheet" href="common/js/zTree_v3-master/css/zTreeStyle/zTreeStyle.css">
		<style type="text/css">
			body{
				padding: 0 10px;
			}
		</style>
	</head>
	<body>
		<!-- 页面所有内容都要放到这个div中，方便后面调方法创建layer底部按钮 -->
		<div id="content">
		<form id="mainPakEditForm" name="mainPakEditForm" class="layui-form" method="post">
			<input type="hidden" id="opr" name="opr" value="${opr }"/>
			<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }"/>
			<input type="hidden" id="hidden-pak-ssdw" name="ssdw" value="${obj.ssdw }"/>
			<input type="hidden" id="hidden-pak-cdbh" name="cdbh" value="${obj.cdbh }" />
			<div style="margin-top:10px;">
				<div class="frm-row">
					<label class="frm-label frm-col-3" >所属单位</label>
					<div class="frm-col-8">
						<input type="text" id="pak-ssdw" readonly placeholder="请选择所属单位" lay-verify="required" data-value="${obj.ssdw }" class="frm-input">
					</div>
					<label class="frm-label frm-col-3">场地分类</label>
					<div class="frm-col-8">
						<select id="pak-cdfl" name="cdfl" lay-filter="tccflSelect" placeholder="请选择场地分类" data-value="${obj.cdfl }" lay-verify="required">
							<option value="">请选择场地分类</option>
						</select>
					</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3">场地类型</label>
					<div class="frm-col-8">
						<select id="pak-cdlx" name="cdlx" lay-filter="tcclxSelect" placeholder="请选择场地类型" data-value="${obj.cdlx }" lay-verify="required">
							<option value="">请选择场地类型</option>
						</select>
					</div>
					<label class="frm-label frm-col-3">场地性质</label>
					<div class="frm-col-8">
						<select id="pak-cdxz" name="cdxz" lay-filter="tccflSelect" placeholder="请选择场地性质" data-value="${obj.cdxz }" lay-verify="required">
							<option value="">请选择场地性质</option>
						</select>
					</div>
				</div>
				
				<div class="frm-row">
					<label class="frm-label frm-col-3">联系人员</label>
					<div class="frm-col-8">
						<input type="text" id="lxry" name="lxry" value="${obj.lxry }" maxlength="10" lay-verify="required" placeholder="请输入联系人员" class="frm-input">
					</div>
				 
					<label class="frm-label frm-col-3">联系电话</label>
					<div class="frm-col-8">
						<input type="text" id="lxdh" name="lxdh" value="${obj.lxdh }" maxlength="11" lay-verify="phone" placeholder="请输入联系电话" class="frm-input">
					</div>
				</div> 
				<div class="frm-row">
<!-- 					<label class="frm-label frm-col-3">可停车数</label> -->
<!-- 					<div class="frm-col-8"> -->
<!-- 						<input type="text" id="ktcs" name="ktcs" value="${obj.ktcs }" maxlength="5" lay-verify="number" style="width: 75%;float:left;" placeholder="请输入可停车数" class="frm-input"> -->
<!-- 						<input type="text" id="tcs" value="辆" readonly style="width: 25%;float:left;" class="layui-input"> -->
<!-- 					</div> -->
					<label class="frm-label frm-col-3">建筑面积</label>
					<div class="frm-col-8">
					    <!-- lay-verify="number" --> 
						<input type="text" id="jzmj" name="jzmj" value="${obj.jzmj }" maxlength="8" style="width: 75%;float:left;" placeholder="请输入建筑面积" class="frm-input">
						<input type="text" id="mj" value="平方米" readonly style="width: 25%;float:left;" class="layui-input">
					</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3">场地地址</label>
					<div class="frm-col-19">
						<input type="text" id="cddz" name="cddz" value="${obj.cddz }" maxlength="128" lay-verify="required" placeholder="请输入场地地址" class="frm-input">
					</div>
				</div>
<!-- 				<div class="frm-row"> -->
<!-- 					<label class="frm-label frm-col-3">场地位置</label> -->
<!-- 					<div class="frm-col-19"> -->
<!-- 						<input type="text" id="cdwz" name="cdwz" value="${obj.cdwz }" maxlength="128" lay-verify="required" placeholder="请输入场地位置" class="frm-input"> -->
<!-- 					</div> -->
<!-- 				</div> -->
				
			</div>
		</form>
	</div>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="common/js/imageTools.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="gov/js/pak-edit.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
	</body>
</html>
