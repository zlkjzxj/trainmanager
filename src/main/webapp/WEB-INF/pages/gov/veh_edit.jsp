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
        <link rel="stylesheet" href="frm/css/table.css" />
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
			.veh-lr{
				width: 38%;
				float:left;
			}
			.veh-mid{
				width: 38%;
				float:left;
			}
			.veh-rr{
				width: 18%;
				float:left;
			}
			.veh-r .layui-form-item{
				clear: none;
			}
			.veh-r .layui-form-item:after{
				clear: none;
			}
			.veh-r .layui-form-label{
				width: 80px;
			}
			.veh-r .layui-input-block{
				margin-left: 105px;
				margin-right: 10px;
			}
			.layui-form-select dl{
				max-height:200px;
			}
			.veh-r #veh-dlms-div{
/* 			    position: absolute; */
/* 			    bottom: 37px; */
/* 			    top:37px; */
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
		</style>
	</head>
	<body>
		<!-- 页面所有内容都要放到这个div中，方便后面调方法创建layer底部按钮 -->
		<div id="content">
		<form id="mainVehEditForm" name="mainVehEditForm" class="layui-form" method="post" enctype="multipart/form-data">
			<input type="hidden" id="opr" name="opr" value="${opr }"/>
			<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }"/>
			<input type="hidden" id="hidden-veh-glbm" name="glbm" value="${vehicle.glbm }"/>
			<input type="hidden" id="hidden-veh-hphm" value="${vehicle.hphm }" />
			<input type="hidden" id="hphm" name="hphm"/>
			<input type="hidden" id="hpzl" name="hpzl" value="${vehicle.hpzl }"/>
			<input type="hidden" id="yxqsh" value="${vehicle.yxqs }" />
			<input type="hidden" id="yxqzh" value="${vehicle.yxqz }" />
			
			<div style="margin-top:10px;">
			  	<div class="veh-r veh-lr">
	  				<div class="layui-form-item">
						<label class="layui-form-label">号牌种类</label>
						<div class="layui-input-block">
							<select id="veh-hpzl" name="veh-hpzl" lay-filter="hpzlSelect" placeholder="请选择号牌种类" data-value="${vehicle.hpzl }" lay-verify="required">
						        <option value="">请选择号牌种类</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">车辆类型</label>
						<div class="layui-input-block">
							<select id="veh-cllx" name="cllx" lay-filter="cllxSelect" placeholder="请选择车辆类型" data-value="${vehicle.cllx }" lay-verify="required">
						        <option value="">请选择车辆类型</option>
							</select>
						</div>
					</div> 
					
					<div class="layui-form-item">
						<label class="layui-form-label">车辆属性</label>
						<div class="layui-input-block">
							<select id="veh-vehdrvsx" name="clsx" lay-filter="vehdrvsxSelect" placeholder="请选择车辆属性" data-value="${vehicle.clsx }" lay-verify="required">
						        <option value="">请选择车辆属性</option>
							</select>
						</div>
					</div>
					 <div class="layui-form-item">
						<label class="layui-form-label">核定载客</label>
						<div class="layui-input-block">
							<input type="text" id="veh-hdzk" name="hdzk" lay-verify="number" maxlength="3" lay-verify="required" value="${vehicle.hdzk }" style="width: 80%;float:left;" placeholder="请输入核定载客" class="layui-input" >
							<input type="text" value="人" readonly style="width: 20%;float:left;" class="layui-input">
						</div>
					</div>
					
					<div class="layui-form-item">
						<label class="layui-form-label">所属部门</label>
						<div class="layui-input-block">
					       <input type="text" id="veh-glbm" readonly placeholder="请选择管理部门" data-value="${vehicle.glbm}" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
					   <div class="layui-input-block">
							<input type="hidden" id="veh-ljlc" name="ljlc" max-length="11" value="${vehicle.ljlc }" style="width: 80%;float:left;"  class="layui-input">
					  </div>
					</div>
	  			</div>
			  	<div class="veh-r veh-mid">
					<div class="layui-form-item">
						<label class="layui-form-label">号牌号码</label>
						<div class="layui-input-block">
							<input type="text" id="veh-bdfzjg" value="" readonly class="layui-input" style="width: 15%;float:left;">
							<input type="text" id="hm" value="" onkeyup="this.value=this.value.toUpperCase()" maxlength="5" lay-verify="hphm" lay-verify="required" style="width: 85%;float:left;" placeholder="请输入号牌号码" class="layui-input">
						</div>
					</div> 
						<div class="layui-form-item">
						<label class="layui-form-label">车辆品牌</label>
						<div class="layui-input-block">
							<input type="text" id="veh-clpp" name="clpp" maxlength="20" lay-verify="required" value="${vehicle.clpp }" placeholder="请输入车辆品牌" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">年审时间起</label>
						<div class="layui-input-block">
				           <input type="text" id="car-nssjq" value="" name="yxqs" lay-verify="required" class="layui-input cle" placeholder="请编写如1990/11/11 12:12:12"  onclick="layui.laydate({elem: this, istime: true, format: 'YYYY/MM/DD hh:mm:ss'})">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">年审时间止</label>
						<div class="layui-input-block">
				           <input type="text" id="car-nssjz" value="" name="yxqz" lay-verify="required" class="layui-input cle" placeholder="请编写如1990/11/11 12:12:12"  onclick="layui.laydate({elem: this, istime: true, format: 'YYYY/MM/DD hh:mm:ss'})">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">初始里程</label>
						<div class="layui-input-block">
							<input type="text" id="veh-cslc" name="cslc" max-length="11" lay-verify="float10" value="${vehicle.cslc }" style="width: 80%;float:left;" placeholder="请输入初始里程" class="layui-input">
							<input type="text" value="公里" readonly style="width: 20%;float:left;" class="layui-input">
						</div>
					</div>
				
					
			  	</div>
			  	</div>
			  		
				<div class="veh-r veh-rr">
					<div class=""  style="width:200px;height:220px;margin-left: 15px;margin-bottom: 10px;float:left;">
						<div id="PreviewDiv" style="width:200px;height:200px;position: absolute;overflow: hidden;">
							<img id="PreviewImg" src="veh.do?method=printGovVehPhoto&hphm=${vehicle.hphm }&hpzl=${vehicle.hpzl }&zpzl=1" onerror="this.src='common/pictures/veh.png'" style="width: 200px;">
						</div>
						  <input id="pic" name="pic" type="file" class="layui-input layui-upload-file" style="position:relative;width:200px;height:200px;top:0;left:0;z-index:999;opacity:0;" />
					</div>	
				</div>
<!-- 				<div> -->
<!-- 					<div id="previewDivs" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src='common/pictures/xk2.jpg')"> -->
<!-- 						<img id="previews" src="common/pictures/veh.png" /> -->
<!-- 					</div> -->
<!-- 					<input id="pics" type="file"> -->
<!-- 				</div> -->
			</div>
		</form>
	</div>
		
		<script type="text/javascript">
			//发证机关选择下拉框事件
			var fzjg = '<%=Constant.SYS_PARAM.get("bdfzjg") %>';
			document.getElementById("veh-bdfzjg").value=fzjg;
		</script>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="gov/js/veh-edit.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
	</body>
</html>
