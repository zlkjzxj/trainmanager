<%@page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="frm/css/global.css" media="all">
	<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="frm/css/frmColors.css" type="text/css">
	<style type="text/css">
		html,body,div#content,#yzlist{
			height: 100%;
		}
		#yzlist{
			float: left;
			width: 150px;
			overflow: hidden;
			background-color: #F8F8F8;
		}
		#yzlist dl{
			width:168px;
			height:399px;
			overflow: auto;
		}
		#yzlist dd{
			text-align: center;
			margin-top: 2px;
			margin-bottom: 15px;
		}
		#preview{
			width:630px;
			height: 399px;
			margin-left: 150px;
			text-align: center;
			position: relative;
			overflow: hidden;
		}
		#preview img{
			margin-top:10px;
			width: 350px;
			height: 350px;
			cursor: pointer;
		}
	</style>
  </head>
  
  <body>
  		<form id="mainDepSealEditForm" name="mainDepSealEditForm" method="post">
  			<input type="hidden" id="glbm" name="glbm" value="${glbm }">
  			<input type="hidden" id="yzlx" name="yzlx">
			<div id="content">
				<div id="yzlist">
					<dl></dl>
				</div>
				<div id="preview">
					<img src="common/pictures/nophoto1.jpg" />
					<input type="file" id="dzyz" name="dzyzFile" style="position:absolute;right:140px;top:0;width:500px;height:100%;z-index:999;cursor: pointer;opacity:0;filter:Alpha(Opacity=0);" HIDEFOCUS><br><!--   -->
				</div>			
			</div>
  		</form>
  		  
	    <script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript">
			var _o1,_o2;
			layui.config({
				base: ''
				
			}).extend({
				domTools:'common/js/domTools',
				ajaxTools:'common/js/ajaxTools',
				hrefTools:'common/js/hrefTools',
				jqueryform:	'common/js/jquery.form'
					
			}).use(['element','form','domTools','ajaxTools','hrefTools','jqueryform'], function() {
				var $ = layui.jquery,
					element = layui.element(),
					layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
					layer = layui.layer, //获取当前窗口的layer对象
					form = layui.form(),
					domTools = layui.domTools,
					ajaxTools = layui.ajaxTools,
					hrefTools = layui.hrefTools;
					
				
				var glbm = $('#glbm').val();
				var yzlx = ajaxTools.getCodeData({dmmc:'yzlx'})||{};
				var bmyz;
				$.ajax({
					url:'dep.do?method=getDzyzByGlbm',
					data:{
						glbm:glbm
					},
					async:false,
					dataType:'json',
					success:function(rlt){
						bmyz = rlt;
					}
				});
				bmyz = bmyz||{};
				
				_o1 = yzlx;
				_o2 = bmyz;
				
				var shtml = '',url = '';
				for(var i in yzlx){
					url = 'common/pictures/nophoto1.jpg';
					if(bmyz.data&&bmyz.data.length>0){
						for(var j in bmyz.data){
							if(yzlx[i].dm==bmyz.data[j]['yzlx']){
								url = 'dep.do?method=writeDzyz&glbm='+glbm+'&yzlx='+yzlx[i].dm;
								break;
							}
						}
					}
					shtml += '<dt><img data-yzlx="'+yzlx[i].dm+'" style="width:120px;height: 120px;margin-left: 15px;" src="'+url+'" /></dt>\
						<dd>'+yzlx[i].mc+'</dd>';
				}
				$('#yzlist dl').html(shtml);
				$('#yzlist dl img').on('click',function(){
					$('#yzlx').val($(this).data('yzlx'));
					$('#preview img').attr('src',$(this).attr('src'));
				});
				$('#yzlist dl img:first').click();
				$('#preview img').on('click',function(){
					return $('#dzyz').click();	//
				});
				$('#dzyz').on('change',function(){
					$(mainDepSealEditForm).ajaxSubmit({
						type:'POST',
						url:'dep.do?method=updateDzyz',
						dataType:'json',
						success:function(rlt){
							if(rlt.code=='1'){
								layer.alert(rlt.mess, {icon: 6});
							}else{
								layer.alert(rlt.mess, {icon: 5});
							}
							
							try {
								var yzlx = $('#yzlx').val(),glbm = $('#glbm').val();
								var url = 'dep.do?method=writeDzyz&glbm='+glbm+'&yzlx='+yzlx+'&t='+(new Date().getTime());
								$('#yzlist dl img[data-yzlx='+yzlx+']').attr('src',url);
								$('#preview img').attr('src',url);
							} catch (e) {}
						}
					});
				});
			});
		</script>
  </body>
</html>
