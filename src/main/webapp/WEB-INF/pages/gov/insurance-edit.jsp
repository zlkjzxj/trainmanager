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
/* 		#frm{ */
/* 		Margin:30px; */
		
/* 		} */
		
		.layui-input-block{
				margin-left: 0px;
				margin-right:30px;
			}
		</style>
	</head>
	<body>
	 <div id="content" style="margin-top:10px;">
		<form id="mainForm" name="mainForm" class="layui-form" method="post" action="">
		       <input type="hidden" id="opr" name="opr" value="${opr}">
			   <input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }"/>
			   <input type="hidden" id="hidden-ince-glbm" name="glbm" value="${Insurance.glbm }"/>
			   <input type="hidden" id="hidden-ince-hphm" value="${Insurance.hphm }" />
			   <input type="hidden" id="hphm" name="hphm"/>
			   <input type="hidden" id="Insurance-bxje" value="${Insurance.bxje }" />
		   
			
			<div class="frm-row" id="frm">
				  <label class="frm-label frm-col-4">号牌种类</label>
					<div class="layui-input-block frm-col-7" >
						<select id="hpzl" name="hpzl" lay-filter="hpzlSelect" placeholder="请选择号牌种类" data-value="${Insurance.hpzl }" lay-verify="required">
						        <option value="">请选择号牌种类</option>
						</select>
					</div>
			 
				 <label class="frm-label frm-col-4">号牌号码</label>
				 <div class=" layui-input-block frm-col-7">
                     <input type="text" id="ince-bdfzjg" value="" readonly class="layui-input" style="width: 18%;;float:left;">
					 <input type="text" id="hm"   lay-verify="hphm1"  onkeyup="this.value=this.value.toUpperCase()" maxlength="5" placeholder="请输入号牌号码" class="layui-input" style="width: 82%;float:right;">
				 </div>
				 
			</div>
			
			<div class="frm-row" id="frm">
			  <label class="frm-label frm-col-4">保险种类</label>
					<div class="layui-input-block frm-col-7" >
						<select id="bxzl" name="bxzl"  placeholder="请选择号牌种类" data-value="${Insurance.hpzl }" lay-verify="required" disabled="">
						        <option value="">请选择保险种类</option>
						</select>
					</div>
			
			          <label class="frm-label frm-col-4">保险单号</label>
				 <div class="layui-input-block  frm-col-7">
				   <input type="text" id="bdh" name="bxdh" value="${Insurance.bxdh}"  lay-verify="required"  maxlength="15" placeholder="请输入保险单号" class="layui-input">
				 </div>
			  </div>
			  
			  <div class="frm-row" id="frm">
				 <label class="frm-label frm-col-4">保险有效期始</label>
				 <div class="layui-input-block frm-col-7">
					 <input type="text" id="bxyxqs" name="bxyxqs" data-value="${Insurance.bxyxqs}" placeholder="请输入或选择保险有效期始" lay-verify="required|date" class="layui-input" > 
				 </div>
			 
				 <label class="frm-label frm-col-4">保险有效期止</label>
				 <div class="layui-input-block  frm-col-7">
					 <input type="text" id="bxyxqz" name="bxyxqz" data-value="${Insurance.bxyxqz}" placeholder="请输入或选择保险有效期止" lay-verify="required|date" class="layui-input"> 
				 </div>
			</div>
				
			  <div class="frm-row" id="frm">
			
				 <label class="frm-label frm-col-4">保险经办人</label>
				 <div class="layui-input-block  frm-col-7">
				   <input type="text" id="jbr" name="jbr" value="${userSession.user.xm }"    lay-verify="required"  maxlength="15" placeholder="请输入保险经办人" class="layui-input">
				 </div>
			
			      <label class="frm-label frm-col-4">保险金额</label>
				 <div class=" layui-input-block frm-col-7">
                     <input type="text" id="bxje" value="元" readonly class="layui-input" style="width: 18%;;float:right;">
					 <input type="text" id="je" name="bxje" onkeyup="this.value=this.value.toUpperCase()" lay-verify="money"  maxlength="8" placeholder="请输入保险金额" class="layui-input" style="width: 82%;float:right;">
				 </div>
		     </div> 
			
		    <div class="frm-row" id="frm">
		       <label class="frm-label frm-col-4">保险公司名称</label>
				 <div class="layui-input-block frm-col-19">
				   <input type="text" id="bxgsmc" name="bxgsmc" value="${Insurance.bxgsmc }"  lay-verify="required" maxlength="124" placeholder="请输入保险公司名称" class="layui-input">
			     </div>
		    </div>
		    
		  </form>
		</div>
		<script type="text/javascript">
			//发证机关选择下拉框事件
			var fzjg ='<%=Constant.SYS_PARAM.get("bdfzjg") %>';
			document.getElementById("ince-bdfzjg").value=fzjg;
		</script>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="gov/js/insurance-edit.js"></script>
	</body>
</html>
