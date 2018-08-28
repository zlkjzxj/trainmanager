<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>车辆回场信息编辑</title>
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
			    line-height: 20px;
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
				margin:0px 0px 15px;
			}
			#id1{
			 margin-top:92px;
			}
			.td1{width:3%;}
			.td2{width:8%;}
			.td3{width:5%;}
			.td4{width:7%;}
			.td5{width:5%;}
			.td6{width:6%;}
			.td7{width:5%;}
		</style>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
	</head>

	<body style="overflow: hidden">
		  
		<form id="mainForm" name="mainForm" method="post" class="layui-form" enctype="multipart/form-data">
		    <input type="hidden" id="jbr"  value="${userSession.user.xm }"/>
			<input type="hidden" value="${obj.lsh }" id="lshh" name="lsh">
			<input type="hidden" value="${obj.hpzl }" id="hpzlh" name="hpzl">
			<input type="hidden" value="${obj.hphm }" id="hphmh" name="hphm">
			<input type="hidden" value="${obj.jsry }" id="jsryh" name="jsry">
			<input type="hidden" value="${obj.jsryzjhm }" id="jsryzjhmh" name="jsryzjhm">
			<input type="hidden" value="${obj.ywlx }" id="ywlxh" name="ywlx">
			<input type="hidden" value="${obj.ywyy }" id="ywyyh" name="ywyy">
			<input type="hidden" value="${obj.glbm }" id="glbmh" name="glbm">
			<input type="hidden" value="${obj.sqry }" id="sqryh" name="sqry">
			<input type="hidden" value="${obj.syry }" id="syryh" name="syry">
			<input type="hidden" value="${obj.syrs }" id="syrsh" name="syrs">
			<input type="hidden" value="${obj.rwnr }" id="rwnrh" name="rwnr">
			<input type="hidden" value="${obj.ksdz }" id="ksdzh" name="ksdz">
			<input type="hidden" value="${obj.dddz }" id="dddzh" name="dddz">
			<input type="hidden" value="${obj.tjdz }" id="tjdzh" name="tjdz">
			<input type="hidden" value="${obj.sxsj }" id="sxsjs">
			<input type="hidden" value="${obj.kssj }" id="kssjh" name="kssj">
			<input type="hidden" value="${obj.jssj }" id="jssjh" name="jssj">
			<input type="hidden" value="${obj.wxdwbh }" id="wxdwbhh" name="wxdwbh">
			<input type="hidden" value="${obj.wxdwmc }" id="wxdwmch" name="wxdwmc">
			<input type="hidden" value="${obj.xgfy }" id="xgfyh" name="xgfy">
			<div style="margin-top: 10px;color: #3C8DBC;border-bottom: 1px solid #3C8DBC;line-height: 10px;height: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;业务信息</div>
			<div style="height:200px;position:relative;margin-top:0px;overflow-x:hidden;">
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
			<div class="frm-row">
				<label class="frm-label frm-col-3 colmr">开始时间</label>
				<div class="frm-col-5 frm-text" id="kssj">
				</div>
				<label class="frm-label frm-col-3 colmr">结束时间</label>
				<div class="frm-col-5 frm-text" id="jssj"></div>
				<label class="frm-label frm-col-3 colmr">需要用时</label>
				<div class="frm-col-4 frm-text">${obj.sxsj }小时</div>
			</div>
			<c:if test="${obj.ywlx=='A' }">
				<div class="frm-row">
					<label class="frm-label frm-col-3 colmr">出发地</label>
					<div class="frm-col-5 frm-text">${obj.ksdz }</div>
					<label class="frm-label frm-col-3 colmr">途径地</label>
					<div class="frm-col-5 frm-text">${obj.tjdz }</div>
					<label class="frm-label frm-col-3 colmr">到达地</label>
					<div class="frm-col-4 frm-text">${obj.dddz }</div>
				</div>
				
				<div class="frm-row" style="margin-top: 10px;">
					<label class="frm-label  frm-col-3 colmr">使用人数</label>
					<div class="frm-col-5 frm-text">${obj.syrs }人</div>
					<label class="frm-label frm-col-3">车辆类型</label>
					<div class="frm-col-5 frm-text" id="car-cllx1"></div>
					<label class="frm-label frm-col-3">号牌号码</label>
					<div class="frm-col-4 frm-text">${obj.hphm }</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3">驾驶员证件号码</label>
					<div class="frm-col-5 frm-text">${obj.jsryzjhm }</div>
					<label class="frm-label frm-col-3">驾驶员姓名</label>
					<div class="frm-col-5 frm-text">${obj.jsry }</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3 colmr">使用人员</label>
					<div class="frm-col-20 frm-text">${obj.syry }</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3 colmr">任务内容</label>
					<div class="frm-col-20 frm-textS">${obj.rwnr }</div>
				</div>
			</c:if>
			<c:if test="${obj.ywlx=='B' }">
				<c:if test="${obj.ywyy=='B'||obj.ywyy=='A' }">
					<div class="frm-row">
						<label class="frm-label frm-col-3">维修单位编号</label>
						<div class="frm-col-5 frm-text">${obj.wxdwbh }</div>
						<label class="frm-label frm-col-3">维修单位名称</label>
						<div class="frm-col-5 frm-text">${obj.wxdwmc }</div>
	<!-- 					<label class="frm-label frm-col-3">相关费用</label> -->
	<!-- 					<div class="frm-col-4 frm-text">${obj.xgfy }元</div> -->
					</div>
				</c:if>
				<div class="frm-row">
					<label class="frm-label frm-col-3">驾驶员证件号码</label>
					<div class="frm-col-5 frm-text">${obj.jsryzjhm }</div>
					<label class="frm-label frm-col-3">驾驶员姓名</label>
					<div class="frm-col-5 frm-text">${obj.jsry }</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3">车辆类型</label>
					<div class="frm-col-5 frm-text" id="car-cllx2"></div>
					<label class="frm-label frm-col-3">号牌号码</label>
					<div class="frm-col-5 frm-text">${obj.hphm }</div>
				</div>
				<div class="frm-row">
					<label class="frm-label frm-col-3 colmr">原因说明</label>
					<div class="frm-col-20 frm-textS">${obj.rwnr }</div>
				</div>
			</c:if>
		<div class="frm-row">
		  <div class="frm-col-22" style="height:150px; /* border:1px solid red; */  margin-left:46px;">
		     <fieldset class="layui-elem-field">
				<div class="layui-field-box layui-form">
					<table id="theadTable" class="layui-table admin-table">
						<thead>
							<tr>
						        <th class="td1">序号</th>
								<th class="td2">流水号</th>
								<th class="td3">号牌种类</th>
								<th class="td4">号牌号码</th>
								<th class="td5">费用类型</th>
								<th class="td6">费用金额</th>
								<th class="td7">经办人</th>
							</tr>
						</thead>
					</table>
					<div id="contentDiv">
						<table id="tbodyTable" class="layui-table admin-table">
							<tbody id="content">
							</tbody>
						</table>
					</div>
				</div>
			</fieldset>
			  <div class="admin-table-page">
				<div id="paged" class="page">
				</div>
			  </div>
			  	<!--模板-->
		 <script type="text/html" id="tpl">
			{{# layui.each(d.list, function(index, item){ }}
			<tr data-lsh="{{ item.lsh }}" data-fylx="{{item.fylx}}">
				<td class="td1">{{ index+1 }}</td>
				<td class="td2">{{item.lsh}}</td>
				<td class="td3">{{formateHpzl(item.hpzl)}}</td>
				<td class="td4">{{item.hphm}}</td>
				<td class="td5">{{formateFylx(item.fylx)}}</td>
				<td class="td6">{{item.fyje}}</td>
                <td class="td7">{{item.jbr}}</td>
			</tr>
			{{# }); }}
		 </script>
		  </div>
		 </div>
		  <div class="frm-row  layer-photos-demo"  id="tpxq">
		      
		      
		  </div>
		</div>
		 <div style="color: #3C8DBC;border-bottom: 1px solid #3C8DBC;line-height: 10px;height: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;车辆回场信息</div>
		 	<div class="div1" id="div1" style=" height:230px;float:left;/*  border:2px solid red; */ width:33%;margin-top:10px;">
<!-- 			  <div calss="frm-row" style="height:100px; margin-top:10px;margin-bottom:10px;">
 -->
          	<div class="frm-row" style="margin-top:25px;">
			    <label class="frm-label frm-col-8">随车工具情况</label>
					<div class="frm-col-8" >
						<input type="checkbox" id="gjbqk"  lay-filter="fitergjb" lay-skin="switch" lay-text="完整|不完整" checked value="1">
						<input type="hidden" name="gjbqk" value="1" id="gjbqkh">
			    </div>
			 </div>
			 <div class="frm-row" style="margin-top:25px;">
			  	<div class="frm-row">
			    <label class="frm-label frm-col-8">车辆外观情况</label>
				<div class="frm-col-8">
					<input type="checkbox"  id="wgqk"  lay-filter="fiterwg" lay-skin="switch" lay-text="完整|不完整" checked value="1">
					<input type="hidden" name="wgqk" value="1" id="wgqkh">
				</div>
			   </div>
			 </div>
			</div>
			<div class="div1" style="height:200px;float:right; /* border:2px solid red; */ width:66%;margin-top:7px;">
			<div class="frm-row" style="margin-top: 25px;" >
					 
					 <label class="frm-label frm-col-4">停车场编号</label>
					 <div class="frm-col-8">
							<select id="back-pak" name="tccbh" >
					        	<option value="">请选择</option>
							</select>
					 </div>
					 <label class="frm-label frm-col-4">实际用时</label>
				     <div class="frm-col-7">
				      <input  type="text"   id="car-sxsj"    lay-verify="float10"  class="layui-input cle" value="" placeholder="请输入实际用时" style="width: 75%;float:left;">
				      <input  type="hidden" id="car-sxsjs" name="sxsj" value="" >
				      <input  type="text" value="小时" readonly style="width: 25%;float:left;" class="layui-input">
				    </div>
			  </div>

				<div class="frm-row" style="margin-top:25px;">
					<label class="frm-label frm-col-4">初始里程</label>
					<div class="frm-col-8">
						<input type="text" id="car-cslc" name="kslc" maxlength="8" class="layui-input cle" value=""  placeholder="请输入行驶里程" style="width: 75%;float:left;">
						<input type="text"  value="千米" readonly style="width: 25%;float:left;" class="layui-input">
					</div>
					<label class="frm-label frm-col-4">终止里程</label>
					<div class="frm-col-7">
						<input type="text" id="car-zzlc" name="jslc" maxlength="8" class="layui-input cle" value=""  placeholder="请输入行驶里程" style="width: 75%;float:left;">
						<input type="text"  value="千米" readonly style="width: 25%;float:left;" class="layui-input">
					</div>
				</div>
				 <div class="frm-row" id="id1">
					<div class="frm-col-23" style="text-align: right">
						<a href="javascript:;" class="layui-btn layui-btn-small" id="car-save" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#xe605;</i> 车辆回场</a>
						<a href="javascript:;" class="layui-btn layui-btn-small" id="car-close" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#x1006;</i> 关闭</a>
				    </div>
				  </div>
				</div>
		</form>
		<!--  <div id="imacom" style='position:absolute; z-index:3; width:300px; height:300px; right:50px; top:30px;border:1px solid gray;margin-right:300px; display:none;'>
			<img id="Imga7"  src="" style="width: 300px;height:300px;">
		 </div> -->
		 	<script type="text/javascript">
			layui.config({
				base: '',
				version: new Date().getTime()
			}).extend({
			    paging:'frm/js/paging',
				ajaxTools:	'common/js/ajaxTools',
				glbmSelect:	'common/js/glbmSelect',
				domTools:	'common/js/domTools',
				imageTools:	'common/js/imageTools',
				hrefTools:	'common/js/hrefTools',
				Tools:	'common/js/Tools',
				jqueryform:	'common/js/jquery.form'
			}).use(['element','form','laydate','paging','imageTools','ajaxTools','glbmSelect','domTools','hrefTools','jqueryform','Tools'],function(){
				var $ = jquery = layui.jquery,
				element = layui.element(),
				paging=layui.paging(),
				ajaxTools  = layui.ajaxTools,
				domTools = layui.domTools,
				imageTools=layui.imageTools,
				hrefTools = layui.hrefTools,
				Tools = layui.Tools,
				layer = layui.layer, //获取当前窗口的layer对象
				form = layui.form();
				
				//定义一个刷新列表的方法，方便子iframe页面刷新父页面列表
	                  window.refreshExpensesList = function(){
		                 paging.reload();
	                   }
	                 window.reQueryExpensesList = function(){
		                queryExpensesList();
	                   }
				
				ajaxTools.loadpak($('#back-pak'),{ssdw:'${obj.glbm}'},false,'','pak.do?method=selectListpak&t='+new Date().getTime(),'请选择停车场');
				form.render('select')
				//车辆类型选择下拉框事件
				$(function (){
					$("#ywlx").html(formateYwlx('${obj.ywlx}'));
					$("#ywyy").html(formateYwYy('${obj.ywyy}','${obj.ywlx}'));
					$("#glbm").html(formateGlbm_jc('${obj.glbm}'));
					$("#sqrq").html(formateShortDate('${obj.sqrq}'));
					$("#kssj").html(formateLongDate('${obj.kssj}'));
					$("#jssj").html(formateLongDate('${obj.jssj}'));
					if('${obj.ywlx}'=="A"){
						$("#car-cllx1").html(formateCllx('${obj.cllx}'));
					}else{
						$("#car-cllx2").html(formateCllx('${obj.cllx}'));
					}
				})
				//辅助判断标记
				var bj="";
				$('#car-save').on('click', function() {
				//alert("bj::"+bj);
				if(bj=="a"){
				  saveflow();
				}else{
				 if($('#car-save').attr('disabled')=="disabled"){
						return;
					}
				  layeropen();
				}
				});
				$('#car-close').on('click', function() {
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭
				});
				form.on('switch(fitergjb)', function(data){
					if(data.elem.checked){
						$('#gjbqkh').val("1");
					}else{
						$('#gjbqkh').val("0");
					}
				})
				form.on('switch(fiterwg)', function(data){
					if(data.elem.checked){
						$('#wgqkh').val("1");
					}else{
						$('#wgqkh').val("0");
					}
				})
				function layeropen(){
				  layer.confirm('此次出车是否产生费用？', {
                        btn: ['是','否'] //按钮
                    }, function(){
                        /* 关闭当前页面层 */
                        layer.closeAll('dialog');
                        var lsh=$('#lshh').val();
						var hpzl=$('#hpzlh').val();
						var hphm=$('#hphmh').val();
                       	layer.open({
			                 type: 2,
			                 id:'UserEdit',
			                 content:['exp.do?method=getBackEnses&lsh='+lsh+'&hpzl='+hpzl+'&hphm='+hphm],
			                 title: '费用信息编辑',/*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
							 shade: 0.2,
							 offset: 'auto',
							 area: ['1300px', '600px'],
							 zIndex: 10000000,
							 //fixed: false,
							 moveOut: true,
							 //scrollbar: false,
							 maxmin: false,
							 btn: 0 	//['新增','保存', '取消']
		                             });
		                   bj="a";          
                    }, function(){
                            saveflow()
                      });
				  }
		        function saveflow(){
					if($('#car-save').attr('disabled')=="disabled"){
						return;
					}
					var ywlx = $('#ywlxh').val();
					var ywyy =$('#ywyyh').val();
					var xgfy=$('#car-xgfy').val();
					var gnid="";
					var cslc=$('#car-cslc').val();
					var zzlc=$('#car-zzlc').val();
					var ac=zzlc-cslc;
					if(ac<0){
					  layer.alert("终止里程不能小于初始里程",{icon:5});
					  $('#car-cslc').val('');
					  $('#car-zzlc').val('');
				      return;
					}
				
					if('A'==ywlx){
						gnid="02010601";
					}else{
						gnid="02010602";
					}
					if($("#car-sxsj").val()==""){
						$("#car-sxsjs").val($("#sxsjs").val())
					}else{
						$("#car-sxsjs").val($("#car-sxsj").val())
					}
					
					var jbr=$('#jsryh').val();
					var hpzl=$('#hpzlh').val();
				   
					if(form.verifyForm(mainForm)){
						$(mainForm).ajaxSubmit({
							type:'POST',
							url:'flow.do',
							data:{
								method:'saveGovArchive',
								//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
								cxdh:'020106',
								gnid:gnid,
								jbr:jbr
							},
							dataType:'json',
							success:function(rlt){
								if(rlt.code=='1'){
									$('#car-save').css({ background: "#F2F2F2",color:"gray"});
									$('#car-save').attr('disabled',true);
									layer.alert(rlt.mess, {icon: 6});
									parent.refreshBackList();
								}else{
									layer.alert(rlt.mess, {icon: 5});
								}
                             }
						});
					}
				}
				/*自动加载页面*/
				$(document).ready(function(){
				    //alert("加载了");
                    queryExpensesList(); 
                  }); 
				
		//分页查询
	    function queryExpensesList(){
	    var params = {};
	     params.lsh=$('#lshh').val();
        //初始化
		paging.init({
			url:'exp.do?method=govVehexpEnsesListPage', //地址
			elem: '#content', //内容容器
			params: params, //发送到服务端的参数
			type: 'POST',
			tempElem: '#tpl', //模块容器
			pageConfig: { //分页参数配置
				elem: '#paged', //分页容器
				pageSize:100//分页大小
			},
			success: function() { //渲染成功的回调
				//alert('渲染成功');
			},
			fail: function(msg) { //获取数据失败的回调
				//layer.alert(msg.mess, {icon: 5});
			},
			complate: function() { //完成的回调
				//绑定窗口调整事件
				$(window).off('resize',domTools.resizeTableHeight).on('resize', domTools.resizeTableHeight).resize();
			}
		});
	} 
  });
   /*    	//两张图片上传
	   $('#pic').change(function(){
		imageTools.previewImage($('#pic')[0],'PreviewImg','PreviewDiv');
		var browserVersion = window.navigator.userAgent.toUpperCase();
		if(browserVersion.indexOf("MSIE")>-1)
			document.getElementById('pic').style.marginTop="-150";
	   });
	    $('#pic1').change(function(){
		imageTools.previewImage($('#pic1')[0],'PreviewImg1','PreviewDiv1');
		var browserVersion = window.navigator.userAgent.toUpperCase();
		if(browserVersion.indexOf("MSIE")>-1)
			document.getElementById('pic1').style.marginTop="-150";
	   });
	   //四张图片上传
	     $('#pica').change(function(){
		imageTools.previewImage($('#pica')[0],'PreviewImga','PreviewDiva');
		var browserVersion = window.navigator.userAgent.toUpperCase();
		if(browserVersion.indexOf("MSIE")>-1)
			document.getElementById('pica').style.marginTop="-130";
	   });
	     $('#pica1').change(function(){
		imageTools.previewImage($('#pica1')[0],'PreviewImga1','PreviewDiva1');
		var browserVersion = window.navigator.userAgent.toUpperCase();
		if(browserVersion.indexOf("MSIE")>-1)
			document.getElementById('pica1').style.marginTop="-130";
	   });
	   
	     $('#picb').change(function(){
		imageTools.previewImage($('#picb')[0],'PreviewImgb','PreviewDivb');
		var browserVersion = window.navigator.userAgent.toUpperCase();
		if(browserVersion.indexOf("MSIE")>-1)
			document.getElementById('picb').style.marginTop="-130";
	   });
	   
	     $('#picb1').change(function(){
		imageTools.previewImage($('#picb1')[0],'PreviewImgb1','PreviewDivb1');
		var browserVersion = window.navigator.userAgent.toUpperCase();
		if(browserVersion.indexOf("MSIE")>-1)
			document.getElementById('picb1').style.marginTop="-130";
	           });
        }); */
   /*      function yincang(id){
              var src1=document.getElementById(id).src; 
              var inpu=document.getElementById("pic"); 
              var inpu1=document.getElementById("pic1"); 
           /*    var inpua=document.getElementById("pica"); 
              var inpua1=document.getElementById("pica1"); 
              var inpub=document.getElementById("picb");
              var inpub1=document.getElementById("picb1");  */
               
      /*          if(src1.indexOf("common/pictures/01.jpg")>0){
                
	   		   }else{
	   		    if(id=="PreviewImg"){
                    inpu.setAttribute("type","hidden");
                 }else if(id=="PreviewImg1"){
                  	inpu1.setAttribute("type","hidden");
                 };/* else if(id=="PreviewImga"){
                   inpua.setAttribute("type","hidden");
                 }else if(id=="PreviewImga1"){
                 	inpua1.setAttribute("type","hidden");
                 }else if(id=="PreviewImgb"){
                 	inpub.setAttribute("type","hidden");
                 }else if(id=="PreviewImgb1"){
                 	inpub1.setAttribute("type","hidden");
                 } */
	   	/* 	   }
	        }*/
		 </script>
	</body>
</html>
