<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>快捷菜单编辑</title>
		<meta name="renderer" content="webkit">
		 <meta http-equiv="pragma" content="no-cache">  
		<meta http-equiv="cache-control" content="no-cache">  
		<meta http-equiv="expires" content="0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		
		<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="frm/css/frmColors.css" type="text/css">
		<link rel="stylesheet" href="frm/css/global.css" media="all">
		<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
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
			common:'frm/js/common',
			glbmSelect:'common/js/glbmSelect',
			hrefTools:'common/js/hrefTools',
			domTools:'common/js/domTools',
			ajaxTools:'common/js/ajaxTools',
			tab:'frm/js/tab'
		}).use(['element','laydate','paging','form','tree','glbmSelect','hrefTools','ajaxTools','domTools','common','tab'], function() {
			var $ = layui.jquery,
				paging = layui.paging(),
				layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
				layer = layui.layer, //获取当前窗口的layer对象
				form = layui.form(),
				element = layui.element(),
				hrefTools = layui.hrefTools,
				domTools = layui.domTools,
				ajaxTools = layui.ajaxTools;
				tab = layui.tab({
					elem: '.admin-nav-card' //设置选项卡容器
						,
					maxSetting: {
						max: 6,
						tipMsg: ''
					},
					contextMenu:true
				});
				element.init();
				$(function(){
					deskcreat();
				})
				function deskcreat(){
					$.ajax({
						url:'main.do?method=getSysProframListDesk&yhdh='+'${userSession.user.yhdh }'+'&t='+new Date(),
						async:false,
						dataType:'json',
						success:function(rlt){
							deskdata = rlt;
							var deskstr="";
							
							for(var i in deskdata){
								var str="";
								if(i%3==0){
									str+="<div class='frm-row' style='margin-top:3px;'>"
								}
								 str+="<div style='float:left;cursor:pointer' class='frm-col-8 tbdiv' data-cxdh='"+deskdata[i].cxdh+"' data-ymmc='"+deskdata[i].ymmc+"' data-cxmc='"+deskdata[i].cxmc+"'>\
								      <div style='width:100%;text-align: center'><i class='"+deskdata[i].cxtp+"' style='font-size: 40px;'></i></div>\
								      <div style='width:100%;text-align: center;margin-top:5px;'>"+deskdata[i].cxmc+"</div>\
								      </div>"
								 if((i+1)%3==0){
									str+="</div>"
								}
								deskstr+=str;
							}
 							$('#deskid').html(deskstr);
						}
					});
				}
				$('.tbdiv').on('click',function(data){
 					var cxdh=$(this).data('cxdh');
					var ymmc=$(this).data('ymmc');
					var title=$(this).data('cxmc');
					top.addTab(cxdh,ymmc,title,"");
				})
				$('#asfs').on('click',function(){
					opendeskEdit();
				});
				function opendeskEdit(){
					top.layer.open({
						type: 2,
						id:'deskEdit',
						content:['main.do?method=forwardPage&ymmc=deskEdit'],
						title: '快捷菜单编辑', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
						shade: 0.2,
						offset: ['50px', '25%'],
						area: ['1000px', '500px'],
						zIndex: 10000000,
						moveOut: true,
						maxmin: false,
						btn: 0 	//['新增','保存', '取消']
					});
				}
				top.window.refreshdesk=function(){location.reload() 
				}
		});
		</script>
	</head>
	<body>
		<ul class="layui-nav" style="height:30px;background-color:#3c8dbc;margin-left: 1px;margin-top: 2px;cursor:pointer" id="asfs" title="点击编辑">
		 <li style="line-height: 30px;">快捷菜单编辑<i class="layui-icon" style="margin-right: 10px" ></i></li>
		</ul>
		<div id="deskid">
		</div>
	</body>
</html>
