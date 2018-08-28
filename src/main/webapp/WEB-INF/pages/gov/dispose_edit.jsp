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
			}
		.frm-row::after {
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
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script type="text/javascript">
		layui.config({
			base: '',
			version: new Date().getTime()
		}).extend({
			paging:'frm/js/paging',
			glbmSelect:'common/js/glbmSelect',
			hrefTools:'common/js/hrefTools',
			ajaxTools:'common/js/ajaxTools',
			domTools:'common/js/domTools',
			jqueryform:	'common/js/jquery.form'
		}).use(['element','laydate','paging','form','tree','glbmSelect','hrefTools','ajaxTools','domTools','jqueryform'], function() {
			var $ = layui.jquery,
				paging = layui.paging(),
				layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
				layer = layui.layer, //获取当前窗口的layer对象
				form = layui.form(),
				hrefTools = layui.hrefTools,
				domTools = layui.domTools,
				ajaxTools = layui.ajaxTools;
			
				$(function (){
					$("#ywlx").html(formateYwlx('${obj.ywlx}'));
					$("#ywyy").html(formateYwYy('${obj.ywyy}','${obj.ywlx}'));
					$("#glbm").html(formateGlbm_jc('${obj.glbm}'));
					$("#sqrq").html(formateShortDate('${obj.sqrq}'));
					$("#kssj").html(formateLongDate('${obj.kssj}'));
					$("#jssj").html(formateLongDate('${obj.jssj}'));
					$("#car-cllx1").html(formateCllx('${obj.cllx}'));
				})
			//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
			domTools.createBtnsAtBottom([{
				name:'<i class="layui-icon">&#xe605;</i> 处置', id:'archive-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
				name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'archive-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
			]);
			
			
			//提交
			$('#archive-save').click(function(){
				if($('#archive-save').attr('disabled')=="disabled"){
					return;
				}
				if(form.verifyForm(mainForm)){
					$(mainForm).ajaxSubmit({
						type:'POST',
						url:'flow.do',
						data:{
							method:'saveGovArchive',
							
							//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
							cxdh:'020805',
							gnid:'02080501'
						},
						dataType:'json',
						success:function(rlt){
							if(rlt.code=='1'){
								$('#archive-save').css({ background: "#F2F2F2",color:"gray"});
								$('#archive-save').attr('disabled',true);
								layer.alert(rlt.mess, {icon: 6});
							}else{
								layer.alert(rlt.mess, {icon: 5});
							}
							
							try {
								//刷新父页面列表
								parent.reDisposeflowList();
							} catch (e) {}
						}
					});
				}
			});
			
			//关闭按钮
			$('#close').on('click',function(){
				top.closeTab(hrefTools.getLocationParam('cxdh'));
			});
		});
		</script>
	</head>
	<body>
	<div id="content" style="overflow:hidden;">
		<form id="mainForm" name="mainForm" method="post" class="layui-form">
		<input type="hidden" value="${obj.lsh }" id="lshh" name="lsh">
		<input type="hidden" value="${obj.hpzl }" id="hpzlh" name="hpzl">
		<input type="hidden" value="${obj.hphm }" id="hphmh" name="hphm">
		<input type="hidden" value="${obj.ywlx }" id="ywlxh" name="ywlx">
		<input type="hidden" value="${obj.ywyy }" id="ywyyh" name="ywyy">
		<input type="hidden" value="${obj.glbm }" id="glbmh" name="glbm">
		<input type="hidden" value="${obj.rwnr }" id="rwnrh" name="rwnr">
		<input type="hidden" value="${userSession.user.xm }" id="syry" name="syry">
		<div id="ywxxtop" style="height:304px;position:relative;margin-top:0px;overflow-x:hidden;">
		<div class="layui-field-box layui-form">
			<div class="frm-row" style="margin-top: 10px;">
				<label class="frm-label frm-col-3 colmr">流水号</label>
				<div class="frm-col-5 frm-text">${obj.lsh }</div>
				<label class="frm-label frm-col-3 colmr">业务类型</label>
				<div class="frm-col-5 frm-text" id="ywlx">
				</div>
				<label class="frm-label frm-col-3 colmr">业务原因</label>
				<div class="frm-col-4 frm-text" id="ywyy">
				</div>
			</div>
			<div class="frm-row">
				<label class="frm-label frm-col-3 colmr">申请单位</label>
				<div class="frm-col-5 frm-text" id="glbm">
				</div>
				<label class="frm-label frm-col-3 colmr">申请人</label>
				<div class="frm-col-5 frm-text">${obj.sqry }</div>
				<label class="frm-label frm-col-3 colmr">申请日期</label>
				<div class="frm-col-4 frm-text" id="sqrq">
				</div>
			</div>
<!-- 			<div class="frm-row"> -->
<!-- 				<label class="frm-label frm-col-3 colmr">开始时间</label> -->
<!-- 				<div class="frm-col-5 frm-text" id="kssj"> -->
<!-- 				</div> -->
<!-- 				<label class="frm-label frm-col-3 colmr">结束时间</label> -->
<!-- 				<div class="frm-col-5 frm-text" id="jssj"></div> -->
<!-- 				<label class="frm-label frm-col-3 colmr">需要用时</label> -->
<!-- 				<div class="frm-col-4 frm-text">${obj.sxsj }小时</div> -->
<!-- 			</div> -->
			<div class="frm-row">
				<label class="frm-label frm-col-3">车辆处置原因</label>
				<div class="frm-textS  frm-col-21">${obj.rwnr }&nbsp;</div>
		    </div>
			<div class="frm-row">
				<label class="frm-label frm-col-3">车辆类型</label>
				<div class="frm-col-5 frm-text" id="car-cllx1"></div>
				<label class="frm-label frm-col-3">号牌号码</label>
				<div class="frm-col-5 frm-text">${obj.hphm }</div>
				<label class="frm-label frm-col-3">处置金额</label>
				<div class="frm-col-4">
					<input type="text" id="car-xgfy" name="xgfy"  class="layui-input cle" maxlength="10"  value="" lay-verify="float10" placeholder="请输入相关费用" style="width: 75%;float:left;">
					<input type="text"  value="元" readonly style="width: 25%;float:left;" class="layui-input">
				</div>
			</div>
		</div>
		</div>
		</form>
	</div>
		
	</body>
</html>
