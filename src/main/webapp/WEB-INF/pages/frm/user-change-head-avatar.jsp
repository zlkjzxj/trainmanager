<%@page import="com.zlkj.frm.bean.FrmSyspara"%>
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
<link rel="stylesheet" href="common/css/imgAreaSelect/imgareaselect-default.css">
<style type="text/css">
#mainUserChangeHeadAvatarForm{
	padding-top: 3px;
}
#leftDiv{
	position: absolute;
	top: 3px;
	left: 0;
	width: 390px;
	height: 390px;
	margin-left: 10px;
}
#previewDiv{
	width: 100%;
	height: 100%;
	position: relative;
}
#previewImg{
	width: 100%;
	height: 100%;
}

#rightDiv{
	margin-left: 420px;
	height: 390px;
}
#selectDiv,#selectDivNew{
	width: 200px;
	height: 200px;
	overflow: hidden;
	position: relative;
	margin-bottom: 10px;
}
#selectImg{
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<div id="content"><!-- 页面所有内容都要放到这个div中，方便后面调方法创建layer底部按钮 -->
		<form id="mainUserChangeHeadAvatarForm" name="mainUserChangeHeadAvatarForm" class="layui-form" method="post">
			<input type="hidden" id="ucha-size" name="size" />
			
			<div id="leftDiv">
				<div id="previewDiv">
					<img id="previewImg" src="common/pictures/boxed-bg.png">
				</div>
			</div>
			<div id="rightDiv">
				<div id="selectDiv">
					<img id="selectImg" src="common/pictures/boxed-bg.png">
				</div>
				
				<!-- 建立一个放置clone file input的容器，upload组件已被修改，上传成功后，会将有东西的file input移动到这里，方便后面继续提交 -->
				<!-- 如果没有该元素，则是upload组件本身的行为，上传成功后清空file input -->
				<div id="ucha-f-div" style="display: none;" class="layui-upload-file-clone"></div>
				<input type="file" name="f" class="layui-upload-file" lay-verify="required" >
			</div>
		</form>
	</div>

	<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
	<script type="text/javascript" src="common/js/translation.js"></script>
	<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
	<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
	<script type="text/javascript">
		layui.config({
			base: ''
				
		}).extend({
			ajaxTools:		'common/js/ajaxTools',
			domTools:		'common/js/domTools',
			hrefTools:		'common/js/hrefTools',
			jqueryform:		'common/js/jquery.form',
			imgAreaSelect: 	'common/js/jquery.imgareaselect'
			
				
		}).use(['element','form','upload','ajaxTools','domTools','hrefTools','jqueryform','imgAreaSelect'],function(){
			
			var $ = jquery = layui.jquery,
				element = layui.element(),
				ajaxTools  = layui.ajaxTools,
				domTools = layui.domTools,
				hrefTools = layui.hrefTools,
				form = layui.form();
			
			
			//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
			domTools.createBtnsAtBottom([
				{name:'<i class="layui-icon">&#xe605;</i> 保存', id:'ucha-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},
				{name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'ucha-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
			]);

			var previewImg = function(img, selection){
				var rate = 200 / selection.width;
			  
			    $('#selectImg').css({
			        width: Math.round(rate * 390) + 'px',
			        height: Math.round(rate * 390) + 'px',
			        marginLeft: '-' + Math.round(rate * selection.x1) + 'px',
			        marginTop: '-' + Math.round(rate * selection.y1) + 'px'
			    });
			    
			    var sstr = [];
			    sstr.push(selection.x1);
			    sstr.push(selection.y1);
			    sstr.push(selection.width);
			    sstr.push(selection.height);
			    sstr.push('390');
			    sstr.push('390');
			    $('#ucha-size').val(sstr.join(','));
			}
			$('#previewImg').imgAreaSelect({ aspectRatio: '1:1', minWidth: 50, minHeight:50, maxWidth: 200, handles: true, onSelectChange: previewImg });
			
			var hasSelectImg = false;
			layui.upload({
				url: 'user.do?method=updateHeadPortrait'
				,success: function(res,input){
					$('#previewImg').attr('src','user.do?method=printHeadPortrait&t='+new Date().getTime());
					$('#selectImg').attr('src','user.do?method=printHeadPortrait&t='+new Date().getTime());
					hasSelectImg = true;
					//console.log(input.value);
				}
			});      
			
			$('#ucha-save').on('click',function(){
				//var f = $('#ucha-f');
				
				if(!hasSelectImg){//!f.val()
					layer.msg('请选择头像图片', {icon: 5,shift: 6});
					return;
				}
				
				$(mainUserChangeHeadAvatarForm).ajaxSubmit({
					type:'POST',
					url:'user.do',
					data:{
						method:'updateHeadPortrait'
					},
					dataType:'json',
					success:function(rlt){
						if(rlt.code=='1'){
							$('.userHeadPortrait',top.document).attr('src','user.do?method=printHeadPortrait&t='+new Date().getTime());
							//layer.alert(rlt.mess, {icon: 6});
						}else{
							layer.alert(rlt.mess, {icon: 5});
						}
					}
				});
			});
		});
	</script>
</body>
</html>
