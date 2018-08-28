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
		.layui-input-block{
				margin-left: 0px;
/* 				margin-right: 10px; */
			}
		.frm-row::after {
/* 		    clear: both; */
		    content: ".";
		    display: block;
		    height: 0;
		    visibility: hidden;
		}
		.frm-textS{
			line-height:28px;
		    color: #C6B1A9;
		    border-bottom: 1px solid #c6b1a9;
		}
		</style>
	</head>
	<body>
	<div id="content" style="overflow:hidden;">
		<form id="mainForm" name="mainForm" method="post" class="layui-form">
			<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
			<input type="hidden" name="lsh" value="${obj.lsh }">
			<input type="hidden" id="ywlx" name="ywlx" value="${obj.ywlx }">
			<input type="hidden" id="ywyy" name="ywyy" value="${obj.ywyy }">
			<input type="hidden" id="sqbm" name="glbm" value="${obj.glbm }">
			<input type="hidden" id="jsry" name="jsry" value="${obj.jsry }">
			<input type="hidden" id="jsryzjhm" name="jsryzjhm" value="${obj.jsryzjhm }">
			<input type="hidden" id="sqrq" name="sqrq" value="${obj.sqrq }">
			<input type="hidden" id="kssj" name="kssj" value="${obj.kssj }">
			<input type="hidden" id="jssj" name="jssj" value="${obj.jssj }">
			<input type="hidden" id="sxsj" name="sxsj" value="${obj.sxsj }">
			<input type="hidden" id="rwnr" name="rwnr" value="${obj.rwnr }">
			<div id="ywxxtop" style="height:304px;position:relative;margin-top:0px;overflow-x:hidden;">
				<div class="layui-field-box layui-form">
					<div class="frm-row">
						<label class="frm-label frm-col-3">流水号</label>
						<div class="frm-col-5 frm-text" >${obj.lsh }</div>
						<label class="frm-label frm-col-3">姓名</label>
						<div class="frm-text frm-col-5" >${obj.jsry }</div>
						<label class="frm-label frm-col-3">证件号码</label>
						<div class=" frm-text frm-col-5">${obj.jsryzjhm }</div>
					</div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">业务原因</label>
						<div class="frm-col-5 frm-text" id="ywyys"></div>
						<label class="frm-label frm-col-3">申请人员</label>
						<div class="frm-text  frm-col-5">${obj.sqry }</div>
						<label class="frm-label frm-col-3">申请时间</label>
						<div class="frm-text  frm-col-5 sqrq"></div>
					</div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">开始时间</label>
						<div class="frm-text frm-col-5 kssj" ></div>
						<label class="frm-label frm-col-3">结束时间</label>
						<div class=" frm-text frm-col-5 jssj"></div>
						<label class="frm-label frm-col-3">需要用时</label>
						<div class=" frm-text frm-col-5">${obj.sxsj }小时</div>
					</div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">请休假原因</label>
						<div class="frm-textS  frm-col-21">${obj.rwnr }&nbsp;</div>
				    </div>
				</div>
			</div>
		</form>
	</div>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="gov/js/salesleave_edit.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
	</body>
</html>
