<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>流水查询信息</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		
		<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="frm/css/global.css" media="all">
		<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
		<style type="text/css">
			html,body{
				height: 100%;
			}
			.layui-form-select dl{
				max-height:80px;
			}
			.colmr{
				/* color: #C6B1A9; */
			}
			.frm-textS{
			    line-height: 28px;
			    color: #C6B1A9;
			    border-bottom: 1px solid #c6b1a9;
			}
			.layui-form-switch{
			width:80px;
			}
			.layui-form-switch EM{
			width:50px;
			}
			.layui-form-onswitch I{
			left:60px;
			}
			.frm-row{
				margin:0px 0px 10px;
			}
		</style>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript">
			layui.config({
				base: '',
				version: new Date().getTime()
			}).extend({
				ajaxTools:	'common/js/ajaxTools',
				glbmSelect:	'common/js/glbmSelect',
				domTools:	'common/js/domTools',
				hrefTools:	'common/js/hrefTools',
				Tools:	'common/js/Tools',
				timeline:	'common/js/timeline',
				jqueryform:	'common/js/jquery.form'
			}).use(['element','form','laydate','ajaxTools','glbmSelect','domTools','hrefTools','jqueryform','Tools','timeline'],function(){
				var $ = jquery = layui.jquery,
				element = layui.element(),
				ajaxTools  = layui.ajaxTools,
				domTools = layui.domTools,
				hrefTools = layui.hrefTools,
				Tools = layui.Tools,
				timeline = layui.timeline,
				form = layui.form();
				
				var items2 = [];
				var ss = $('.flow-timeline').data('ywlc').split('');
				for(var i in ss){
					var tse = $('.log-clrq-ywgw-'+ss[i]);
					if(tse&&tse.text()){
						items2.push(formateLongDate(tse.text()));
					}
				}
				timeline.create({
					margin:'50px 70px 10px',
					elem:$('.flow-timeline'),
					items:formateYwgwSplit($('.flow-timeline').data('ywlc')).split(' '),
					items2:items2,
					currItem:formateYwgw($('.flow-timeline').data('ywgw'))
				});
				
				element.on('tab(tabBriefTab)', function(data){
					$(window).resize();
				});
				
				$('.log-ywyy').each(function(){
					$(this).text(formateYwyySplit($(this).text(),$(this).data('ywlx')));
				});
				$('.log-ywlx').each(function(){
					$(this).text(formateYwlx($(this).text()));
				});
				$('.log-glbm').each(function(){
					$(this).text(formateGlbm($(this).text()));
				});
				$('.log-ywgw').each(function(){
					$(this).text(formateYwgw($(this).text()));
				});
				$('.log-clrq').each(function(){
					$(this).text(formateLongDate($(this).text()));
				});
			
				//车辆类型选择下拉框事件
				$(function (){
					$("#ywlx").html(formateYwlx('${bobj.ywlx}'));
					$("#ywyy").html(formateYwYy('${bobj.ywyy}','${bobj.ywlx}'));
					$("#glbm").html(formateGlbm_jc('${bobj.sqbm}'));
					$("#sqrq").html(formateShortDate('${bobj.sqrq}'));
					$("#bjrq").html(formateLongDate('${bobj.bjrq}'));
// 									=='Q''流水已退办,办结':'' bobj.lszt=='W''流水审批审核不通过,办结':'' 
					var lsztnew= '${bobj.lszt}';
					if(lsztnew!='W'&&lsztnew!='Q'){
						$("#lszt").html(formateLszt('${bobj.lszt}'));
					}else{
						$("#lszt").css('color','red');
						if(lsztnew=='W'){
							$("#lszt").html('流水审批审核不通过,办结');
						}else{
							$("#lszt").html('流水已退办,办结');
						}
					}				
					$("#ywgw").html(formateYwgw('${bobj.ywgw}'));
					
					$(".kssj").html(formateLongDate($(".kssj").text()));
					$(".jssj").html(formateLongDate($(".jssj").text()));
					$(".czsj").html(formateLongDate($(".czsj").text()));
					$(".cllx").html(formateCllx($(".cllx").text()));
					$(".hpzl").html(formateHpzl($(".hpzl").text()));
					if($('#ywgwh').val()!='E'){
						$('#bjrqwz').attr('style','display:none');
						$('#bjrq').attr('style','display:none');
					}
					tabfy();
				})
				$(".opt").click(function(){
					var lsh=$(this).data('lsh');
					var fylx=$(this).data('fylx');
					$.ajax({
						url:'govPhoto.do?method=selectGovPhotoList&lsh='+lsh+'&zplx='+fylx+"&t="+new Date().getTime(),
						async:false,
						dataType:'json',
						success:function(rlt){
							var stringdiv="";
							for(var i in rlt){
								stringdiv+="<div class=\"frm-col-4\" style=\"text-align: center;\">";
								stringdiv+="<div class=\"tpxq\">";
								stringdiv+="<img layer-src=\"flow.do?method=printGovPhotos&lsh="+rlt[i].lsh+"&zplx="+rlt[i].zplx+"&zpbh="+rlt[i].zpbh+"\" src=\"flow.do?method=printGovPhotos&lsh="+rlt[i].lsh+"&zplx="+rlt[i].zplx+"&zpbh="+rlt[i].zpbh+"\" onerror=\"this.src='common/pictures/01.jpg'\" style=\"width: 150px;height:100px;\">";
								stringdiv+="</div>";
								stringdiv+="<div style=\"text-align: center;\">";
								stringdiv+="</div>";
								stringdiv+="</div>";
							}
							$("#tpxq").html(stringdiv);
							layer.photos({
							  photos: '.tpxq',
							  anim: 5
						  	});
						}
					});
				})
				$('#car-close').on('click', function() {
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭
				});
				function tabfy(){
				$(".hpzlfy").each(function() {
					$(this).text(formateHpzl($(this).text()))
				})
				$(".fylxfy").each(function() {
					$(this).text(formateFylx($(this).text()))
				})
				}
			});
		</script>
	</head>

	<body style="overflow: hidden;">
		
		<form id="mainForm" name="mainForm" method="post" class="layui-form">
			<input type="hidden" value="${bobj.lsh }" id="lshh" name="lsh">
			<input type="hidden" value="${bobj.ywlx }" id="ywlxh" name="ywlx">
			<input type="hidden" value="${bobj.ywyy }" id="ywyyh" name="ywyy">
			<input type="hidden" value="${bobj.sqbm }" id="glbmh" name="glbm">
			<input type="hidden" value="${bobj.bjrq }" id="bjrqh" name="bjrq">
			<input type="hidden" value="${bobj.lszt }" id="lszth" name="lszt">
			<input type="hidden" value="${bobj.ywgw }" id="ywgwh" name="ywgw">
			<div style="width:100%;height:380px;">
			<div class="layui-tab layui-tab-brief" style="margin-top:0px;" lay-filter="tabBriefTab">
				<ul class="layui-tab-title">
					<li class="layui-this">基本信息</li>
					<li>操作日志</li>
					${bobj.ywlx=="B" || bobj.ywlx=="A"?'<li>相关资料</li>':'' }
				</ul>
				<div class="layui-tab-content">
					<div class="layui-tab-item layui-show">
						<div class="frm-row">
							<label class="frm-label frm-col-3 colmr">流水号</label>
							<div class="frm-col-5 frm-text">${bobj.lsh }</div>
							<label class="frm-label frm-col-4 colmr">业务类型</label>
							<div class="frm-col-5 frm-text" id="ywlx">
							</div>
							<label class="frm-label frm-col-3 colmr">业务原因</label>
							<div class="frm-col-4 frm-text" id="ywyy">
							</div>
						</div>
						<div class="frm-row">
							<label class="frm-label frm-col-3 colmr">申请人</label>
							<div class="frm-col-5 frm-text">${bobj.sqry }</div>
							<label class="frm-label frm-col-4 colmr">流水状态</label>
							<div class="frm-col-5 frm-text" id="lszt"></div>
							<label class="frm-label frm-col-3 colmr" id="bjrqwz">办结日期</label>
							<div class="frm-col-4 frm-text" id="bjrq"></div>
						</div>
						<!-- 从临时表查出的信息展示.....开始 -->
						<c:if test="${bj=='1' }">
							<c:if test="${obj.ywlx=='A' }">
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">开始时间</label>
									<div class="frm-col-5 frm-text kssj" id="">${obj.kssj}</div>
									<label class="frm-label frm-col-4 colmr">结束时间</label>
									<div class="frm-col-5 frm-text jssj" id="">${obj.jssj}</div>
									<label class="frm-label frm-col-3 colmr">需要用时</label>
									<div class="frm-col-4 frm-text">${obj.sxsj==null?0:obj.sxsj }小时</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">出发地址</label>
									<div class="frm-col-5 frm-text">${obj.ksdz }</div>
									<label class="frm-label frm-col-4 colmr">途径地址</label>
									<div class="frm-col-5 frm-text">${obj.tjdz }</div>
									<label class="frm-label frm-col-3 colmr">到达地址</label>
									<div class="frm-col-4 frm-text">${obj.dddz }</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">号牌种类</label>
									<div class="frm-col-5 frm-text hpzl">${obj.hpzl}</div>
									<label class="frm-label frm-col-4">号牌号码</label>
									<div class="frm-col-5 frm-text">${obj.hphm }</div>
									<label class="frm-label frm-col-3">行驶里程</label>
									<div class="frm-col-4 frm-text">${obj.xslc==null?0:obj.xslc }公里</div>
								</div>
								
								<div class="frm-row">
									
									<label class="frm-label frm-col-3">驾驶员姓名</label>
									<div class="frm-col-5 frm-text">${obj.jsry }</div>
									<label class="frm-label frm-col-4">驾驶员证件号码</label>
									<div class="frm-col-5 frm-text">${obj.jsryzjhm }</div>
									<label class="frm-label  frm-col-3 colmr">使用人数</label>
									<div class="frm-col-4 frm-text">${obj.syrs==null?0:obj.syrs }人</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">外观情况</label>
									<div class="frm-col-5 frm-text">${obj.wgqk==1?'完整':'不完整 '}</div>
									<label class="frm-label frm-col-4">工具包情况</label>
									<div class="frm-col-5 frm-text">${obj.gjbqk==1?'完整':'不完整' }</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">使用人员</label>
									<div class="frm-col-21 frm-text">${obj.syry }</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">任务内容</label>
									<div class="frm-col-21 frm-textS">${obj.rwnr }</div>
								</div>
							</c:if>
							<c:if test="${obj.ywlx=='B' }">
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">开始时间</label>
									<div class="frm-col-5 frm-text kssj" id="">${obj.kssj}</div>
									<label class="frm-label frm-col-4 colmr">结束时间</label>
									<div class="frm-col-5 frm-text jssj" id="">${obj.jssj}</div>
									<label class="frm-label frm-col-3 colmr">需要用时</label>
									<div class="frm-col-4 frm-text">${obj.sxsj==null?0:obj.sxsj }小时</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">驾驶人员姓名</label>
									<div class="frm-col-5 frm-text">${obj.jsry }</div>
									<label class="frm-label frm-col-4">驾驶人员证件号码</label>
									<div class="frm-col-5 frm-text">${obj.jsryzjhm }</div>
									<label class="frm-label frm-col-3">相关费用</label>
									<div class="frm-col-4 frm-text">${obj.xgfy==null?0:obj.xgfy }元</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">号牌种类</label>
									<div class="frm-col-5 frm-text hpzl">${obj.hpzl}</div>
									<label class="frm-label frm-col-4">号牌号码</label>
									<div class="frm-col-5 frm-text">${obj.hphm }</div>
									
								</div>
								<div class="frm-row">
									<c:if test="${obj.ywyy=='A' || obj.ywyy=='B'}">
										<label class="frm-label frm-col-3">维修单位编号</label>
										<div class="frm-col-5 frm-text">${obj.wxdwbh }</div>
										<label class="frm-label frm-col-4">维修单位名称</label>
										<div class="frm-col-5 frm-text">${obj.wxdwmc }</div>
									</c:if>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">维修保养原因</label>
									<div class="frm-col-21 frm-textS">${obj.rwnr }</div>
								</div>
							</c:if>
							<c:if test="${obj.ywlx=='C' }">
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">开始时间</label>
									<div class="frm-col-5 frm-text kssj" id="">${obj.kssj}</div>
									<label class="frm-label frm-col-4 colmr">结束时间</label>
									<div class="frm-col-5 frm-text jssj" id="">${obj.jssj}</div>
									<label class="frm-label frm-col-3 colmr">需要用时</label>
									<div class="frm-col-4 frm-text">${obj.sxsj==null?0:obj.sxsj }小时</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">驾驶员姓名</label>
									<div class="frm-col-5 frm-text">${obj.jsry }</div>
									<label class="frm-label frm-col-4">驾驶员证件号码</label>
									<div class="frm-col-5 frm-text">${obj.jsryzjhm }</div>
									
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">请休假原因</label>
									<div class="frm-col-21 frm-textS">${obj.rwnr }</div>
								</div>
							</c:if>
							<c:if test="${obj.ywlx=='D' }">
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">开始时间</label>
									<div class="frm-col-5 frm-text kssj" id="">${obj.kssj}</div>
									<label class="frm-label frm-col-4 colmr">结束时间</label>
									<div class="frm-col-5 frm-text jssj" id="">${obj.jssj}</div>
									<label class="frm-label frm-col-3 colmr">需要用时</label>
									<div class="frm-col-4 frm-text">${obj.sxsj==null?0:obj.sxsj }小时</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">车辆类型</label>
									<div class="frm-col-5 frm-text cllx" >${obj.cllx}</div>
									<label class="frm-label frm-col-4">号牌种类</label>
									<div class="frm-col-5 frm-text hpzl">${obj.hpzl}</div>
									<label class="frm-label frm-col-3">号牌号码</label>
									<div class="frm-col-4 frm-text">${obj.hphm }</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">处置原因</label>
									<div class="frm-col-21 frm-textS">${obj.rwnr }</div>
								</div>
							</c:if>
						</c:if>
						<!-- 从临时表查出的信息展示.....结束 -->
						<!-- 从办结表查出的信息展示.....开始 -->
						<c:if test="${bj=='2' }">
							<c:if test="${bobj.ywlx=='A' }">
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">开始时间</label>
									<div class="frm-col-5 frm-text kssj" id="">${obj.kssj}</div>
									<label class="frm-label frm-col-4 colmr">结束时间</label>
									<div class="frm-col-5 frm-text jssj" id="">${obj.jssj}</div>
									<label class="frm-label frm-col-3 colmr">需要用时</label>
									<div class="frm-col-4 frm-text">${obj.sxsj==null?0:obj.sxsj }小时</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">出发地址</label>
									<div class="frm-col-5 frm-text">${obj.ksdz }</div>
									<label class="frm-label frm-col-4 colmr">途径地址</label>
									<div class="frm-col-5 frm-text">${obj.tjdz }</div>
									<label class="frm-label frm-col-3 colmr">到达地址</label>
									<div class="frm-col-4 frm-text">${obj.dddz }</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">号牌种类</label>
									<div class="frm-col-5 frm-text hpzl">${obj.hpzl}</div>
									<label class="frm-label frm-col-4">号牌号码</label>
									<div class="frm-col-5 frm-text">${obj.hphm }</div>
									<label class="frm-label frm-col-3">行驶里程</label>
									<div class="frm-col-4 frm-text">${obj.xslc==null?0:obj.xslc }公里</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">外观情况</label>
									<div class="frm-col-5 frm-text">${obj.wgqk== 1 ? '完整' : '不完整' }</div>
									<label class="frm-label frm-col-4">工具包情况</label>
									<div class="frm-col-5 frm-text">${obj.gjbqk== 1 ? '完整' : '不完整' }</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">驾驶员姓名</label>
									<div class="frm-col-5 frm-text">${obj.jsry }</div>
									<label class="frm-label frm-col-4">驾驶员证件号码</label>
									<div class="frm-col-5 frm-text">${obj.jsryzjhm }</div>
									<label class="frm-label  frm-col-3 colmr">使用人数</label>
									<div class="frm-col-4 frm-text">${obj.syrs==null?0:obj.syrs }人</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">使用人员</label>
									<div class="frm-col-21 frm-text">${obj.syry }</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">任务内容</label>
									<div class="frm-col-21 frm-textS">${obj.rwnr }</div>
								</div>
							</c:if>
							<c:if test="${bobj.ywlx=='B' }">
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">开始时间</label>
									<div class="frm-col-5 frm-text kssj" id="">${obj.kssj}</div>
									<label class="frm-label frm-col-4 colmr">结束时间</label>
									<div class="frm-col-5 frm-text jssj" id="">${obj.jssj}</div>
									<label class="frm-label frm-col-3 colmr">申请人</label>
									<div class="frm-col-4 frm-text">${bobj.sqry }</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">号牌种类</label>
									<div class="frm-col-5 frm-text hpzl">${bobj.hpzl}</div>
									<label class="frm-label frm-col-4">号牌号码</label>
									<div class="frm-col-5 frm-text">${bobj.hphm }</div>
									<label class="frm-label frm-col-3">经办人</label>
									<div class="frm-col-4 frm-text">${obj.jbr }</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">驾驶人员姓名</label>
									<div class="frm-col-5 frm-text">${bobj.jsry }</div>
									<label class="frm-label frm-col-4">驾驶人员证件号码</label>
									<div class="frm-col-5 frm-text">${bobj.jsryzjhm }</div>
									<label class="frm-label frm-col-3">相关费用</label>
									<div class="frm-col-4 frm-text">${obj.wxfy==null?0:obj.wxfy }元</div>
								</div>
								<div class="frm-row">
									<c:if test="${obj.ywyy=='A' || obj.ywyy=='B'}">
									<label class="frm-label frm-col-3">维修单位编号</label>
									<div class="frm-col-5 frm-text">${obj.wxdwbh }</div>
									<label class="frm-label frm-col-4">维修单位名称</label>
									<div class="frm-col-5 frm-text">${obj.wxdwmc }</div>
									</c:if>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">任务内容</label>
									<div class="frm-col-21 frm-textS">${obj.wxnr==null?'无':obj.wxnr }</div>
								</div>
							</c:if>
							<c:if test="${bobj.ywlx=='C' }">
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">开始时间</label>
									<div class="frm-col-5 frm-text kssj">${obj.kssj}</div>
									<label class="frm-label frm-col-4 colmr">结束时间</label>
									<div class="frm-col-5 frm-text jssj">${obj.jssj}</div>
									<label class="frm-label frm-col-3 colmr">需要用时</label>
									<div class="frm-col-4 frm-text">${obj.qjsc==null?0:obj.qjsc }小时</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3">驾驶员姓名</label>
									<div class="frm-col-5 frm-text">${obj.jsyxm }</div>
									<label class="frm-label frm-col-4">驾驶员证件号码</label>
									<div class="frm-col-5 frm-text">${obj.jsyzjhm }</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">请休假原因</label>
									<div class="frm-col-21 frm-textS">${obj.qjyy }</div>
								</div>
							</c:if>
							<c:if test="${bobj.ywlx=='D' }">
								<div class="frm-row">
									<label class="frm-label frm-col-3">号牌种类</label>
									<div class="frm-col-5 frm-text hpzl">${obj.hpzl}</div>
									<label class="frm-label frm-col-4">号牌号码</label>
									<div class="frm-col-5 frm-text">${obj.hphm }</div>
									<label class="frm-label frm-col-3 colmr">经办人</label>
									<div class="frm-col-4 frm-text">${obj.jbr }</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">处置时间</label>
									<div class="frm-col-5 frm-text czsj">${obj.czsj }</div>
									<label class="frm-label frm-col-4 colmr">处置金额</label>
									<div class="frm-col-5 frm-text">${obj.czje==null?0:obj.czje }元</div>
								</div>
								<div class="frm-row">
									<label class="frm-label frm-col-3 colmr">处置原因</label>
									<div class="frm-col-21 frm-textS">${obj.czyy }</div>
								</div>
							</c:if>
						</c:if>
						<!-- 从办结表查出的信息展示.....结束 -->
					</div>
					<div class="layui-tab-item">
						<table class="layui-table">
				  			<tr>
				  				<th>序号</th>
<!-- 				  				<th>业务类型</th> -->
<!-- 				  				<th>业务原因</th> -->
				  				<th>业务岗位</th>
				  				<th>管理部门</th>
				  				<th>经办人</th>
				  				<th>处理日期</th>
				  				<th>IP地址</th>
				  				<th>备注</th>
				  			</tr>
				  			<c:forEach items="${logs }" var="log" varStatus="index">
				  				<tr class="">
				  					<td>${index.index+1 }</td>
<!-- 				  					<td class="log-ywlx">${log.ywlx }</td> -->
<!-- 				  					<td class="log-ywyy" data-ywlx="${log.ywlx }">${log.ywyy }</td> -->
				  					<td class="log-ywgw">${log.ywgw }</td>
				  					<td class="log-glbm">${log.glbm }</td>
				  					<td>${log.jbr }</td>
				  					<td class="log-clrq log-clrq-ywgw-${log.ywgw }">${log.clrq }</td>
				  					<td>${log.ip }</td>
				  					<td>${log.bz }</td>
				  				</tr>
				  			</c:forEach>
				  		</table>
						<div class="flow-timeline" data-ywlc="${bobj.ywlc }" data-ywgw="${bobj.ywgw }" ></div>
					</div>
					<div class="layui-tab-item layer-photos-demo" id="layer-photos-demo">
						<table class="layui-table">
				  			<tr>
				  				<th>序号</th>
				  				<th>号牌种类</th>
				  				<th>号牌号码</th>
				  				<th>费用类型</th>
				  				<th>费用金额</th>
				  				<th>经办人</th>
				  				<th>操作</th>
				  			</tr>
				  			<c:forEach items="${explist }" var="exp" varStatus="index">
				  				<tr class="">
				  					<td>${index.index+1 }</td>
				  					<td><div class="hpzlfy">${exp.hpzl }</div></td>
				  					<td>${exp.hphm }</td>
				  					<td><div class="fylxfy">${exp.fylx }</div></td>
				  					<td>${exp.fyje }</td>
				  					<td>${exp.jbr }</td>
				  					<td>
				  					<a href="javascript:;"  data-lsh="${exp.lsh }" data-fylx="${exp.fylx }" class="layui-btn layui-btn-mini opt"><i class="layui-icon">&#xe64a;</i> 看图</a>
				  					</td>
				  				</tr>
				  			</c:forEach>
				  		</table>
						<div class="frm-row layer-photos-demo" id="tpxq">
						</div>
					</div>
				</div>
			</div>
			</div>
			<div class="frm-row">
				<div class="frm-col-23" style="text-align: right">
						<a href="javascript:;" class="layui-btn layui-btn-small" id="car-close" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#x1006;</i> 关闭</a>
				</div>
			</div>
		</form>
<!-- 		<div id="imacom" style='position:absolute; z-index:3; width:500px; height:400px; right:50px; top:30px;border:1px solid gray;display: none'> -->
<!-- 			<img id="Imga7"  src="" style="width: 500px;height:400px;"> -->
<!-- 		</div> -->
	</body>
</html>
