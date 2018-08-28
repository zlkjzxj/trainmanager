<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%-- <%@ page import="java.util.Date"%> --%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>用户管理</title>
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
		.listy{
			height:28px;
		}
		</style>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script type="text/javascript">
			layui.config({
				base: '',
				version: new Date().getTime()
			}).extend({
				hrefTools:'common/js/hrefTools',
				ajaxTools:'common/js/ajaxTools'
			}).use(['element','form','ajaxTools','hrefTools'], function() {
				var $ = layui.jquery,
				hrefTools = layui.hrefTools;
				$(function(){
 				   getref();
					$.ajax({
						url:('carOnline.do?method=selectAllCarInfo&par=report'),
						async:false,
						dataType:'json',
						success:function(rlt){
 							 $("#dv2").html(rlt)
						}
					});
				})	
				function getref(){
					var wid=window.document.body.clientWidth;
					var hei=$(window).height();
				   $("#dv2").css('width',wid-10+'px');
				   $("#dv2").css('height',hei-10+'px');
// 				   $("#dv1").css('height',hei-10+'px');
				}
				window.onresize=function (){
					getref();
				}
			});
		</script>
	</head>
	<body>
	<div style="margin-top: 5px;">
		<div style="border: solid 1px gray;float: left;border-left: 0px;width:1500px;height:600px;" id="dv2" >
<!-- 			<iframe name="showcontent" width="100%" height="100%" frameborder="no" ></iframe> -->
<!--   		<iframe style="height:96%;width:100%;margin:0px;padding:0px;" name="newPage" frameborder="0" src="http://pageapi.gpsoo.net/third?method=jump&appkey=7decd3b2fac04c6c6e365671bf6b6893&account=18919888279&page=monitor&target=18919888279"></iframe>   -->
<!--   		跟踪	<iframe style="height:96%;width:100%;margin:0px;padding:0px;" name="newPage" frameborder="0" src="http://pageapi.gpsoo.net/third?method=jump&appkey=7decd3b2fac04c6c6e365671bf6b6893&account=18919888279&page=tracking&target=321116093996961"></iframe>  -->
<!--   		回放	<iframe style="height:96%;width:100%;margin:0px;padding:0px;" name="newPage" frameborder="0" src="http://pageapi.gpsoo.net/third?method=jump&appkey=7decd3b2fac04c6c6e365671bf6b6893&account=18919888279&page=playback&target=321116093996961"></iframe>  -->
<!-- <iframe style="height:96%;width:100%;margin:0px;padding:0px;" name="newPage" frameborder="0" src="http://pageapi.gpsoo.net/third?method=jump&appkey=7decd3b2fac04c6c6e365671bf6b6893&account=18919888279&page=report&target=18919888279"></iframe>  -->
<!--   	租赁黑名单	<iframe style="height:96%;width:100%;margin:0px;padding:0px;" name="newPage" frameborder="0" src="http://pageapi.gpsoo.net/third?method=jump&appkey=7decd3b2fac04c6c6e365671bf6b6893&account=18919888279&page=blacklist&target=18919888279"></iframe>  -->
<!--   	微信     	<iframe style="height:96%;width:100%;margin:0px;padding:0px;" name="newPage" frameborder="0" src="http://pageapi.gpsoo.net/third?method=jump&appkey=7decd3b2fac04c6c6e365671bf6b6893&account=18919888279&page=weixin&target=18919888279&time=<%=new Date().getTime()/1000 %>">"></iframe>  -->
		</div>
	</div>
	</body>
</html>
