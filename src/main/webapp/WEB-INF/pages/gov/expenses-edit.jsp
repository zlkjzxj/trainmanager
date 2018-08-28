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
/* 		#frm{ */
/* 		Margin:30px; */
/* 		} */
		/* #frm-id{
			margin-left:100px;
			} */
		.layui-input-block{
				margin-left: 0px;
				margin-right:30px;
			}
		</style>
		<script type="text/javascript">
		function setZs(zs1,zs2,zs3){
				document.getElementById("ince-lsh").value=zs1;
			}
		</script>
	</head>
	<body>
	 <div id="content" style="margin-top: 10px;">
		<form id="mainForm" name="mainForm" class="layui-form" method="post" action="">
		       <input type="hidden" id="opr" name="opr" value="${opr}">
			   <input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }"/>
		       <input type="hidden" id="curr-user-xm"  value="${userSession.user.xm }"/>
			   <input type="hidden" id="hidden-ince-hphm" value="${expense.hphm }" />
			   <input type="hidden" id="hphm"/>
			   <input type="hidden" id="expense-fyje" value="${expense.fyje }" />
			   
			      <div class="frm-row" id="frm">
			        <label class="frm-label frm-col-4">流水号</label>
					<div class="layui-input-block frm-col-7"  id="frm-id">
						<input type="text" id="ince-lsh"  name="lsh" value="${expense.lsh}"lay-verify="number"  maxlength="13"  placeholder="请选择流水号" class="layui-input" style="width:80%;float:left;">
					    <a href="javascript:;" class="layui-btn layui-btn-small" id="lsh-select" style="width:20%; margin-left:0px;"><i class="layui-icon" >&#xe615;</i>选择</a>
					</div>
					 <label class="frm-label frm-col-4">经办人</label>
				    <div class="layui-input-block  frm-col-7">
				        <input type="text" id="jbr" name="jbr" value="${userSession.user.xm}" lay-verify="chinese" maxlength="15"  placeholder="请输入经办人" class="layui-input">
				    </div>
					
				 </div>
				 
				  <div class="frm-row" id="frm">
				    <label class="frm-label frm-col-4">号牌种类</label>
				     <div class="layui-input-block frm-col-7" >
						<select id="hpzl" name="hpzl" lay-filter="hpzlSelect" placeholder="请选择号牌种类"  data-value="${expense.hpzl }" lay-verify="required">
						        <option value="">请选择号牌种类</option>
						</select>
			        </div>
				  
			        <label class="frm-label frm-col-4" >号牌号码</label>
				 <div class=" layui-input-block frm-col-7">
                     <input type="text" id="ince-bdfzjg" value="" readonly class="layui-input" style="width: 18%;;float:left;">
					 <input type="text" id="hm"  onkeyup="this.value=this.value.toUpperCase()" lay-verify="hphm" maxlength="5" placeholder="请输入号牌号码" class="layui-input" style="width: 82%;float:right;">
				 </div>
			   </div>
			    
			    <div class="frm-row" id="frm">
				              <label class="frm-label frm-col-4" >费用类型</label>
				   <div class="layui-input-block frm-col-7" >
						<select id="fylx" name="fylx" lay-filter="fylxSelect" placeholder="请选择费类型" data-value="${expense.fylx}" lay-verify="required">
						        <option value="">请选择费用类型</option>
						</select>
				  </div>
					
					   <label class="frm-label frm-col-4">费用金额</label>
				 <div class=" layui-input-block frm-col-7">
                     <input type="text" id="fyje" value="元" readonly class="layui-input" style="width: 18%; float:right;">
					 <input type="text" id="je" name="fyje" lay-verify="money1"  maxlength="10" placeholder="请输入费用金额" class="layui-input" style="width: 82%;float:right;">
				 </div>
			  </div>
			   <div class="frm-row"  style="float:left;">
					 <div class=" layui-input-block frm-col-2" style="margin-left:530px;margin-top:10px;" >
					     <a href="javascript:;" class="layui-btn layui-btn-small" id="addc"><i class="layui-icon" >&#xe654;</i>上传票据添加</a>
					 </div>
			   </div>
			
			  <div class="frm-row"  id="cs" style="border:1px solid #e6e6e6; width:900px;height:200px;margin-left:115px; overflow-y:scroll;">
		      
		      
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
		<script type="text/javascript" src="gov/js/expenses-edit.js"></script>
	</body>
</html>
