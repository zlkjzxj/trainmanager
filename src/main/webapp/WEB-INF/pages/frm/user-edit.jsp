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
			.layui-form-checkbox[lay-skin=primary]{
				min-height: 32px;
				margin-top: 0;
				line-height: 32px;
			}
			.ue-lr{
				width: 50%;
				float:left;
			}
			.ue-rr{
				margin-left:50%;
			}
			.ue-r .layui-form-item{
				clear: none;
			}
			.ue-r .layui-form-item:after{
				clear: none;
			}
			.ue-r .layui-form-label{
				width: 80px;
			}
			.ue-r .layui-input-block{
				margin-left: 105px;
				margin-right: 10px;
			}
			.ue-r #ue-dlms-div{
			    //position: absolute;
			    //bottom: 37px;
			    //top:37px;
			    background-color: white;
			    border: 1px solid #e2e2e2;
			    border-radius: 4px;
			    box-sizing:border-box;
				-moz-box-sizing:border-box;
				-webkit-box-sizing:border-box;
				padding: 3px;
				position: fixed;
				top:auto;
				left:auto;
			}
			#czqx-tab>.layui-form-item>.layui-form-label{
				//padding: 9px 0 9px 5px;
				//padding: 6px 9px;
			}
			#czqx-tab #qxms-form-item{
				float:left;
				width:50%;
				margin-bottom: 0;
			}
			#czqx-tab #qxms-form-item .layui-form-select{
				width:80%;
			}
			#czqx-tab #sfgly-form-item{
				margin-left: 50%;
				clear: none;
				margin-bottom: 12px;
			}
			#czqx-tab #ue-yhqx .layui-colla-item .layui-colla-title{
				padding-left: 12px;
			}
			#czqx-tab #ue-yhqx .layui-colla-item .layui-colla-title>i{
				display: none;
			}
			#czqx-tab #ue-yhqx .layui-colla-title .layui-form-checkbox{
				margin: 0 5px 0 7px;
			}
			#czqx-tab #ue-yhqx .layui-colla-title .all{
				float: right;
			}
			#czqx-tab #ue-yhqx .layui-form-label{
				padding-left: 0;
				padding-right: 0;
			}
		</style>
	</head>
	<body>
		<div id="content"><!-- 页面所有内容都要放到这个div中，方便后面调方法创建layer底部按钮 -->
		<form id="mainUserEditForm" name="mainUserEditForm" class="layui-form" method="post">
			<input type="hidden" id="opr" name="opr" value="${opr }">
			<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
			<input type="hidden" id="hidden-ue-glbm" name="glbm" value="${user.glbm }">
			<input type="hidden" id="hidden-ue-dlms" name="dlms" value="${user.dlms }">
			<input type="hidden" id="hidden-ue-bmjb" >
			
		
			<div class="layui-tab layui-tab-brief" lay-filter="">
			  	<ul class="layui-tab-title">
				    <li class="layui-this">基本信息</li>
				    <li>用户权限</li>
			  	</ul>
			  	<div class="layui-tab-content" >
			  		<div class="layui-tab-item layui-show">
			  			<div class="ue-r ue-lr">
			  				<div class="layui-form-item">
								<label class="layui-form-label">用户代号</label>
								<div class="layui-input-block">
									<input type="text" id="ue-yhdh" name="yhdh" value="${user.yhdh }" lay-verify="required" placeholder="请输入用户代号" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">姓名</label>
								<div class="layui-input-block">
									<input type="text" name="xm" value="${user.xm }" lay-verify="required" placeholder="请输入姓名" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">用户级别</label>
								<div class="layui-input-block">
									<select id="ue-yhjb" lay-filter="UserJbSelect" name="yhjb" placeholder="请选择用户级别" data-value="${user.yhjb }" lay-verify="required">
								        <option value="">请选择用户级别</option>
									</select>
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">密码有效期</label>
								<div class="layui-input-block">
									<input type="text" id="ue-mmyxq" name="mmyxq" data-value="${user.mmyxq }" placeholder="请输入或选择密码有效期" lay-verify="required|date" class="layui-input" onclick="layui.laydate({elem:this, festival: true})">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">手机号码</label>
								<div class="layui-input-block">
									<input type="text" id="ue-lxdh" name="lxdh" value="${user.lxdh }" lay-verify="phone" placeholder="请输入手机号码" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">登陆模式</label>
								<div class="layui-input-block">
									<input id="ue-dlms" type="text" data-value="${user.dlms }" readonly placeholder="请选择登陆模式" lay-verify="required" class="layui-input" onclick="layui.jquery('#ue-dlms-div').removeClass('layui-hide').addClass('layui-show')">
									<div id="ue-dlms-div" class="layui-hide"></div>
								</div>
							</div>
			  			</div>
			  			<div class="ue-r ue-rr">
			  				<div class="layui-form-item">
								<label class="layui-form-label">管理部门</label>
								<div class="layui-input-block">
									<input type="text" id="ue-glbm" data-value="${user.glbm }" readonly placeholder="请选择管理部门" lay-verify="required" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">身份证号码</label>
								<div class="layui-input-block">
									<input type="text" name="sfzmhm" value="${user.sfzmhm }" lay-verify="identity" placeholder="请输入身份证号码" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">用户类别</label>
								<div class="layui-input-block">
									<select id="ue-yhlb" name="yhlb" data-value="${user.yhlb }" placeholder="请选择用户类别" lay-verify="required">
								        <option value="">请选择用户类别</option>
									</select>
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">用户有效期</label>
								<div class="layui-input-block">
									<input type="text" id="ue-yhyxq" name="yhyxq" data-value="${user.yhyxq }" placeholder="请输入或选择用户有效期" lay-verify="required|date" class="layui-input" onclick="layui.laydate({elem:this, festival: true})">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">MAC地址</label>
								<div class="layui-input-block">
									<input type="text" name="mac" value="${user.mac }" placeholder="请输入MAC地址" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">是否启用</label>
								<div class="layui-input-block">
									<input type="checkbox" id="ue-sfqy" checked data-value="${user.zt }" lay-text="是|否" lay-skin="switch">
								</div>
							</div>
			  			</div>
			  		</div>
	    			<div class="layui-tab-item" id="czqx-tab">
	    				  <div class="layui-form-item" id="qxms-form-item">
						    	<label class="layui-form-label">权限模式</label>
						    	<div class="layui-input-block">
						    		<select id="ue-qxms" lay-filter="QxmsSelect" name="qxms" placeholder="请选择权限模式" data-value="${user.qxms }" lay-verify="required">
								        <option value="">请选择权限模式</option>
									</select>
						    	</div>
						  </div>
						  <div class="layui-form-item" id="sfgly-form-item">
						    	<label class="layui-form-label">是否管理员</label>
						    	<div class="layui-input-block">
						    		<input type="checkbox" id="ue-sfgly" lay-filter="SfglySwitch" data-value="${user.sfgly }" lay-text="是|否" lay-skin="switch">
						    	</div>
						  </div>
	    				  <div class="layui-form-item">
						    	<label class="layui-form-label">操作权限</label>
						    	<div class="layui-input-block">
						    		<div id="ue-yhqx" class="layui-collapse" lay-accordion></div>
						    	</div>
						  </div>
	    			</div>
			  	</div>
			</div>
		</form>
		</div>
		
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="frm/js/user-edit.js"></script>
	</body>
</html>
