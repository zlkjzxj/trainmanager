<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		#frm{
/* 		Margin:22px; */
		
		}
		
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
		<form id="mainForm" name="mainForm" method="post" class="layui-form" style="">
			<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
			<input type="hidden" name="lsh" value="${obj.lsh }">
			<input type="hidden" id="ywlx" name="ywlx" value="${obj.ywlx }">
			<input type="hidden" id="ywyy" name="ywyy" value="${obj.ywyy }">
			<input type="hidden" id="kssj" name="kssj" value="${obj.kssj }">
			<input type="hidden" id="jssj" name="jssj" value="${obj.jssj }">
			<input type="hidden" id="sqrq" name="sqrq" value="${obj.sqrq }">
			<input type="hidden" id="sqbm" value="${obj.glbm }">
			<input type="hidden" id="audit-cllx" value="${obj.cllx }">
			<div id="ywxxtop" style="height:304px;position:relative;margin-top:0px;overflow-x:hidden;">
				<div class="layui-field-box layui-form" style="height:98px;padding-top:0px;padding-bottom:0px;">
					<div style="color: #3C8DBC;border-bottom: 1px solid #3C8DBC;line-height: 20px;height: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;业务信息</div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">流水号</label>
						<div class="frm-col-5 frm-text" >${obj.lsh }</div>
						<label class="frm-label frm-col-3">业务类型</label>
						<div class="frm-col-5 frm-text" id="ywlxs"></div>
						<label class="frm-label frm-col-3">业务原因</label>
						<div class="frm-col-5 frm-text" id="ywyys"></div>
					</div>
					<div class="frm-row" style="margin-bottom:0px;">
						<label class="frm-label frm-col-3">申请单位</label>
						<div class="frm-text frm-col-5" id="sqbms"></div>
						<label class="frm-label frm-col-3">申请人员</label>
						<div class="frm-text  frm-col-5">${obj.sqry }</div>
						<label class="frm-label frm-col-3">申请时间</label>
						<div class="frm-text  frm-col-5 sqrq"></div>
					</div>
				</div>
				<div id="gwycxx" style="display:none;padding-top:0px;padding-bottom:0px;" class="layui-field-box layui-form">
					<div class="frm-row">
						<label class="frm-label frm-col-3">开始时间</label>
						<div class="frm-text frm-col-5 kssj" ></div>
						<label class="frm-label frm-col-3">结束时间</label>
						<div class=" frm-text frm-col-5 jssj"></div>
						<label class="frm-label frm-col-3">需要用时</label>
						<div class=" frm-text frm-col-5">${obj.sxsj }小时</div>
					</div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">开始地址</label>
						<div class="frm-textS  frm-col-5">${obj.ksdz }&nbsp;</div>
						<label class="frm-label frm-col-3">途径地址</label>
						<div class="frm-textS frm-col-5">${obj.tjdz }&nbsp;</div>
						<label class="frm-label frm-col-3">到达地址</label>
						<div class="frm-textS  frm-col-5">${obj.dddz }&nbsp;</div>
					</div>
					<div class="frm-row">
						<label class="frm-label frm-col-4">公务用车任务内容</label>
						<div class="frm-textS  frm-col-20">${obj.rwnr }&nbsp;</div>
				    </div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">使用人员</label>
						<div class="frm-textS  frm-col-21">${obj.syry }&nbsp;</div>
				    </div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">使用人数</label>
						<div class="frm-text  frm-col-5">${obj.syrs }人</div>
						<label class="frm-label frm-col-3">联系电话</label>
						<div class="frm-textS frm-col-13">${obj.syrylxdh }&nbsp;</div>
				    </div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">车辆类型</label>
						<div class="frm-text frm-col-5 audit-cllx">${obj.cllx }</div>
						<label class="frm-label frm-col-3">号牌号码</label>
						<div class="frm-text  frm-col-10">${obj.hphm }</div>
						<div class="frm-label  frm-col-3">(指定的车辆)&nbsp;&nbsp;&nbsp;&nbsp;</div>
					</div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">驾驶员证件号码</label>
						<div class="frm-text  frm-col-5">${obj.jsryzjhm }</div>
						<label class="frm-label frm-col-3">驾驶员姓名</label>
						<div class="frm-text  frm-col-10">${obj.jsry }</div>
						<div class="frm-label  frm-col-3">(指定的驾驶员)</div>
					</div>
				</div>
				<div id="jdcbyxx" style="display:none;padding-top:0px;padding-bottom:0px;" class="layui-field-box layui-form">
					<div class="frm-row">
						<label class="frm-label frm-col-3">原因说明</label>
						<div class="frm-textS  frm-col-21">${obj.rwnr }</div>
				    </div>
				   
					<div class="frm-row">
						<label class="frm-label frm-col-3">开始时间</label>
						<div class="frm-text frm-col-5 kssj" ></div>
						<label class="frm-label frm-col-3">结束时间</label>
						<div class=" frm-text frm-col-5 jssj"></div>
						<label class="frm-label frm-col-3">需要用时</label>
						<div class=" frm-text frm-col-5">${obj.sxsj }小时</div>
					</div>
					 <c:if test="${obj.ywyy=='A' || obj.ywyy=='B'}">
						<div class="frm-row">
							<label class="frm-label frm-col-3">维修单位编号</label>
							<div class="frm-text  frm-col-5">${obj.wxdwbh }</div>
							<label class="frm-label frm-col-3">维修单位名称</label>
							<div class="frm-text  frm-col-13">${obj.wxdwmc }</div>
						</div>
					</c:if>
					<div class="frm-row">
						<label class="frm-label frm-col-3">驾驶员姓名</label>
						<div class="frm-col-5 frm-text">${obj.jsry }</div>
						<label class="frm-label frm-col-3">驾驶员证件号码</label>
						<div class="frm-col-13 frm-text">${obj.jsryzjhm }</div>
<!-- 						<label class="frm-label frm-col-3">相关费用</label> -->
<!-- 						<div class="frm-text frm-col-5">${obj.xgfy }元</div> -->
					</div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">车辆类型</label>
						<div class="frm-text frm-col-5 audit-cllx">${obj.cllx }</div>
						<label class="frm-label frm-col-3">号牌号码</label>
						<div class="frm-text  frm-col-10">${obj.hphm }</div>
						<div class="frm-label  frm-col-3">(指定的车辆)&nbsp;&nbsp;&nbsp;&nbsp;</div>
					</div>
				</div>
				<div id="qxjxx" style="display:none;padding-top:0px;padding-bottom:0px;" class="layui-field-box layui-form">
					<div class="frm-row">
						<label class="frm-label frm-col-4">驾驶员请休假原因说明</label>
						<div class="frm-textS  frm-col-20">${obj.rwnr }&nbsp;</div>
				    </div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">驾驶员姓名</label>
						<div class="frm-text frm-col-5" >${obj.jsry }</div>
						<label class="frm-label frm-col-3">驾驶员证件号码</label>
						<div class=" frm-text frm-col-13">${obj.jsryzjhm }</div>
					</div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">开始时间</label>
						<div class="frm-text frm-col-5 kssj" ></div>
						<label class="frm-label frm-col-3">结束时间</label>
						<div class=" frm-text frm-col-5 jssj"></div>
						<label class="frm-label frm-col-3">需要用时</label>
						<div class=" frm-text frm-col-5">${obj.sxsj }小时</div>
					</div>
				</div>
				<div id="jdcczxx" style="display:none;padding-top:0px;padding-bottom:0px;" class="layui-field-box layui-form">
					<div class="frm-row">
						<label class="frm-label frm-col-5">公务车处置原因说明</label>
						<div class="frm-textS  frm-col-19">${obj.rwnr }&nbsp;</div>
				    </div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">车辆类型</label>
						<div class="frm-text frm-col-5 audit-cllx">${obj.cllx }</div>
						<label class="frm-label frm-col-3">号牌号码</label>
						<div class="frm-text  frm-col-13">${obj.hphm }</div>
					</div>
<!-- 					<div class="frm-row"> -->
<!-- 						<label class="frm-label frm-col-3">开始时间</label> -->
<!-- 						<div class="frm-text frm-col-5 kssj" ></div> -->
<!-- 						<label class="frm-label frm-col-3">结束时间</label> -->
<!-- 						<div class=" frm-text frm-col-5 jssj"></div> -->
<!-- 						<label class="frm-label frm-col-3">需要用时</label> -->
<!-- 						<div class=" frm-text frm-col-5">${obj.sxsj }小时</div> -->
<!-- 					</div> -->
				</div>
			</div>
			<div style="height:109px;position:relative;margin-bottom:0px;overflow:hidden;">
				<div class="layui-field-box layui-form" style="padding:0px;">
					<div style="color: #3C8DBC;border-bottom: 1px solid #3C8DBC;line-height: 20px;height: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;审核信息</div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">审核结果</label>
						<div class="layui-input-block frm-col-20">
							<div id="audit-shjg"></div>
						</div>
					</div>
					<div class="frm-row">
						<label class="frm-label frm-col-3">审核意见</label>
						<div class="layui-input-block  frm-col-20">
							<input type="text" id="bz" name="shyj" maxlength="64" placeholder="请输入审核意见" class="layui-input">
						</div>
					</div>
				</div>
			</div>
			<div class="frm-row">
					<div class="frm-col-23" style="text-align: right;">
							<a href="javascript:;" class="layui-btn layui-btn-small" id="audit-save" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#xe605;</i> 保存</a>
							<a href="javascript:;" class="layui-btn layui-btn-small" id="audit-cancel" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#x1006;</i> 关闭</a>
					</div>
				</div>
		</form>
	</div>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="gov/js/audit2_edit.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
	</body>
</html>
