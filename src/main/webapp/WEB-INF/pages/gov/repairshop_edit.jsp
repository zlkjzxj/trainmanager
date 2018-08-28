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
		#frm{
		 Margin:22px;
		}
		
		.layui-input-block{
				margin-left: 0px;
				margin-right: 20px;
			}
		</style>
	</head>
	<body>
	 <div id="content">
		<form id="mainForm" name="mainForm" class="layui-form" method="post" action="">
		       <input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }"/>
		       <input type="hidden" id="curr-user-xm"  value="${userSession.user.xm }"/>
		       <input type="hidden" id="opr" name="opr" value="${opr}"/>
			
			<div class="frm-row" id="frm">
				  <label class="frm-label frm-col-3">单位类型</label>
					<div class="layui-input-block frm-col-8" >
						<select id="Dwlx" name="Dwlx" lay-filter="dwlxSelect" placeholder="请选择单位类型" data-value="${shop.dwlx }" lay-verify="required">
						        <option value="">请选择单位类型</option>
						</select>
					</div>
			 
				 <label class="frm-label frm-col-3">单位名称</label>
				 <div class=" layui-input-block frm-col-8">
				   <input type="text" id="dwmc" name="dwmc" value="${shop.dwmc }" lay-verify="required" maxlength="128" placeholder="请输入单位名称" class="layui-input">
				 </div>
			</div>
			<div class="frm-row" id="frm">
			    <label class="frm-label frm-col-3">单位地址</label>
			     <div class="layui-input-block  frm-col-19">
				   <input type="text" id="dwdz" name="dwdz" value="${shop.dwdz }" lay-verify="required" maxlength="128" placeholder="请输入单位地址" class="layui-input" style="width:619px; ">
				 </div>
			</div>
			
			<div class="frm-row" id="frm">
				 <label class="frm-label frm-col-3">负责人</label>
				 <div class="layui-input-block frm-col-8">
				   <input type="text" id="fzr" name="fzr" value="${shop.fzr }" lay-verify="required" maxlength="10" placeholder="请输入负责人" class="layui-input">
				 </div>
			 
				 <label class="frm-label frm-col-3">负责人电话</label>
				 <div class="layui-input-block  frm-col-8">
				   <input type="text" id="fzrdh" name="fzrdh" value="${shop.fzrdh }" lay-verify="phone" placeholder="请输入负责人电话" class="layui-input">
				 </div>
			</div>
			
			<div class="frm-row" id="frm">
				 <label class="frm-label frm-col-3">联系人</label>
				 <div class="layui-input-block  frm-col-8">
				   <input type="text" id="lxr" name="lxr" value="${shop.lxr }" lay-verify="required" maxlength="10" placeholder="请输入联系人" class="layui-input">
				 </div>
			 
				 <label class="frm-label frm-col-3">联系人电话</label>
				 <div class="layui-input-block frm-col-8">
				   <input type="text" id="lxrdh" name="lxrdh" value="${shop.lxrdh }" lay-verify="phone" placeholder="请输入联系人电话" class="layui-input">
			     </div>
		    </div> 
			     
			<div class="frm-row" id="frm1">
				   <input type="hidden" id="zt" name="zt" value="1" lay-verify="requieed"  class="frm-input">
				   <input type="hidden" id="dwbh" name="dwbh" value="${shop.dwbh }" lay-verify="requieed"  class="frm-input">
			</div>
		  </form>
		</div>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="gov/js/repairshop_edit.js"></script>
	</body>
</html>
