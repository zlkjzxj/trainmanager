<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		 <meta http-equiv="pragma" content="no-cache">  
		<meta http-equiv="cache-control" content="no-cache">  
		<meta http-equiv="expires" content="0">
		<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="frm/css/global.css" media="all">
		<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
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
			.drv-l{
				width: 76%;
				float:left;
			}
			.drv-lr{
				width: 50%;
				float:left;
			}
			.drv-mid{
				width: 50%;
				float:left;
			}
			.drv-m{
				width: 100%;
				float:left;
			}
			.drv-rr{
				width: 18%;
				float:left;
			}
			.drv-r .layui-form-item{
				clear: none;
			}
			.drv-r .layui-form-item:after{
				clear: none;
			}
			.drv-r .layui-form-label{
				width: 80px;
			}
			.drv-r .layui-input-block{
				margin-left: 105px;
				margin-right: 10px;
			}
			.layui-form-select dl{
				max-height: 200px;
			}
			.layui-anim-upbit{
				top: 42px;
				height: auto;
				bottom: auto;
				max-height: 200px;
			}
			.drv-r #drv-dlms-div{
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
		<form id="mainForm" name="mainForm" class="layui-form" method="post" enctype="multipart/form-data">
			<input type="hidden" id="opr" name="opr" value="${opr }"/>
			<input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }"/>
			<input type="hidden" id="hidden-drv-glbm" name="glbm" value="${drv.glbm }"/>
			<input type="hidden" id="hidden-drv-jszh" name="sfzmhm"/>
			<input type="hidden" id="hidden-drv-csrq" value="${drv.csrq }"/>
			<input type="hidden" id="hidden-drv-yxqz" value="${drv.yxqz }"/>
			
			<div style="margin-top:10px;">
			  	<div class="drv-r drv-l">
				  	<div class="drv-r drv-lr">
				  		<div class="layui-form-item">
							<label class="layui-form-label">姓名</label>
							<div class="layui-input-block">
								<input type="text" id="drv-xm" name="xm" value="${drv.xm }" lay-verify="required" maxlength="15" placeholder="请输入姓名" class="layui-input" >
							</div>
						</div>
		  				<div class="layui-form-item">
							<label class="layui-form-label">身份证号</label>
							<div class="layui-input-block">
								<input type="text" id="drv-jszh" name="jszh" value="${drv.jszh }" maxlength="18" lay-verify="identity" placeholder="请输入身份证号" class="layui-input" >
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">手机号码</label>
							<div class="layui-input-block">
								<input type="text" id="drv-sjhm" name="sjhm" value="${drv.sjhm }" maxlength="11" lay-verify="phone" placeholder="请输入手机号码" class="layui-input" >
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">所属部门</label>
							<div class="layui-input-block">
								<input type="text" id="drv-glbm" data-value="${drv.glbm }" readonly lay-verify="required" placeholder="请选择所属部门" class="layui-input" >
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">人员属性</label>
							<div class="layui-input-block">
								<select id="drv-rysx" name="rysx" placeholder="请选择人员属性" data-value="${drv.rysx }" lay-verify="required">
							        <option value="">请选择人员属性</option>
								</select>
							</div>
						</div>
		  			</div>
				  	<div class="drv-r drv-mid">
						<div class="layui-form-item">
							<label class="layui-form-label">性别</label>
							<div class="layui-input-block">
								<select id="drv-xb" name="xb" placeholder="请选择性别" data-value="${drv.xb }" lay-verify="required">
							        <option value="">请选择性别</option>
								</select>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">出生日期</label>
							<div class="layui-input-block">
								<input type="text" id="drv-csrq" name="csrq" lay-verify="required" class="layui-input" placeholder="yyyy-mm-dd" value="${drv.csrq }" onclick="layui.laydate({elem: this, istime: false, format: 'YYYY-MM-DD'})">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">准驾车型</label>
							<div class="layui-input-block" style="max-height:200px;">
								<select id="drv-zjcx" name="zjcx" placeholder="请选择准驾车型" data-value="${drv.zjcx }" lay-verify="required">
							        <option value="">请选择准驾车型</option>
								</select>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">有效期至</label>
							<div class="layui-input-block" style="max-height:200px;">
								<input type="text" id="drv-yxqz" name="yxqz" lay-verify="required" class="layui-input" placeholder="yyyy-mm-dd" value="" onclick="layui.laydate({elem: this, istime: false, format: 'YYYY-MM-DD'})">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">联系地址</label>
							<div class="layui-input-block">
								<input type="text" id="drv-lxdz" name="lxdz" value="${drv.lxdz }" maxlength="64" lay-verify="required" placeholder="请输入联系地址" class="layui-input" >
							</div>
						</div>
				  	</div>
				  	<div class="drv-r drv-m">
					  	
					</div>
			  	</div>
				<div class="drv-r drv-rr">
					<div class=""  style="width:200px;height:220px;margin-left: 15px;margin-bottom: 10px;float:left;">
						<div id="PreviewDiv" style="width:190px;height:190px;position: absolute;overflow: hidden;">
							<img id="PreviewImg" src="driving.do?method=printGovDrvPhoto&sfzmhm=${drv.jszh }&zpzl=1" onerror="this.src='common/pictures/drv.png'" style="width: 200px;">
						</div>
						<input id="pic" name="pic" type="file" class="layui-input layui-upload-file" style="position:relative;width:100%;height:100%;top:0;left:0;z-index:999;opacity:0;" />
					</div>	
				</div>
				</div>
			</form>
		</div>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript">
		layui.config({
				base: ''
			}).extend({
				ajaxTools:	'common/js/ajaxTools',
				glbmSelectByZTree:'common/js/glbmSelectByZTree',
				domTools:	'common/js/domTools',
				hrefTools:	'common/js/hrefTools',
				imageTools:	'common/js/imageTools',
				jqueryform:	'common/js/jquery.form'
			}).use(['form','laydate','ajaxTools','glbmSelectByZTree','domTools','hrefTools','imageTools','jqueryform'], function() {
			
				var $ = jquery = layui.jquery,
				ajaxTools  = layui.ajaxTools,
				domTools = layui.domTools,
				hrefTools = layui.hrefTools,
				imageTools = layui.imageTools,
				form = layui.form();
				
				var opr = $('#opr').val();	//e:编辑  a:新增
				if(opr=='e'){
					//较为特殊的字段无法直接el表达式赋值，js处理下
					$('#drv-xm').attr('readonly','readonly');
					$('#drv-jszh').attr('readonly','readonly');
					$('#drv-glbm').val(formateGlbm_jc($('#drv-glbm').data('value')));
					form.render('select');
				}
				
				$('#pic').change(function(){
					imageTools.previewImage($('#pic')[0],'PreviewImg','PreviewDiv');
					var browserVersion = window.navigator.userAgent.toUpperCase();
					//alert(browserVersion);
					if(browserVersion.indexOf("MSIE")>-1)
						document.getElementById('pic').style.marginTop="-200";
				});
				
				
				var csrq = $('#hidden-drv-csrq').val();
				$('#drv-csrq').val(formateShortDate(csrq));
				var yxqz = $('#hidden-drv-yxqz').val();
				$('#drv-yxqz').val(formateShortDate(yxqz));
				
				//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
				domTools.createBtnsAtBottom([{
					name:'<i class="layui-icon">&#xe654;</i> 新增', id:'drv-add', style:'border-color: deepskyblue;background-color: deepskyblue;color: #fff;'},{
					name:'<i class="layui-icon">&#xe605;</i> 保存', id:'drv-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
					name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'drv-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
				]);
				
				//新增
				$('#drv-add').click(function(){
					location.href='driving.do?method=forwardDrvEditPage';
				});
				
				//自动填出生日期
				$('#drv-jszh').blur(function(){
					var sfzh = $('#drv-jszh').val();
					var reg = /(^\d{15}$)|(^\d{17}(x|X|\d)$)/;
					if(!reg.test(sfzh)){
						layer.msg('请输入正确的身份证号', {icon: 5,shift: 6});
						return;
					}else{
						var length=sfzh.length;
						if(length==18){
							var rq = sfzh.substring(6,14);
							var str = rq.substring(0,4)+"-"+rq.substring(4,6)+"-"+rq.substr(6, 8);
							$('#drv-csrq').val(str);
						}else{
							var rq1 = "19"+sfzh.substring(6,12);
							var strs = rq1.substring(0,4)+"-"+rq1.substring(4,6)+"-"+rq1.substr(6, 8);
							$('#drv-csrq').val(strs);
						}
					}
				});
				
				var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['255px','240px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
				$('#drv-glbm').on('click',function(){
					glbmSelectByZTree.show($('#drv-glbm'),function(event, treeId, treeNode){
						$('#drv-glbm').val(treeNode.name);
						$('#hidden-drv-glbm').val(treeNode.tags.glbm);
						form.render('select');
					});
				});
				
				//提交
				$('#drv-save').click(function(){
					$('#hidden-drv-jszh').val($('#drv-jszh').val());
					if(form.verifyForm(mainForm)){//form.verifyForm返回true表示表单验证成功
						var oprs = $('#opr').val()
						var gnid = oprs==='e'?'02090202':'02090201';
						$(mainForm).ajaxSubmit({
							type:'POST',
							url:'driving.do',
							data:{
								method:'updateDrvPhoto',
								
								//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
								cxdh:'020902',
								gnid:gnid
							},
							dataType:'json',
							success:function(rlt){
								if(rlt.code=='1'){
									$('#opr').val('e')
									$('#drv-jszh').attr('readonly',true);
									$('#drv-glbm').attr('readonly',true);
									layer.alert(rlt.mess, {icon: 6});
								}else{
									layer.alert(rlt.mess, {icon: 5});
								}
								
								try {
									//刷新父页面列表
									if(opr=='e'){
										parent.refreshDrvList();
									}else{
										parent.reQueryDrvList();
									}
								} catch (e) {}
							}
						});
					}
				});
				
				//车辆类型选择下拉框事件
				ajaxTools.loadCodeDataKK($('#drv-xb'),{dmmc:'xb'},false,($('#drv-xb').data('value')||''),'code.do?method=selectListCode','请选择性别');
				form.render('select')
				//车辆类型选择下拉框事件
				ajaxTools.loadCodeDataKK($('#drv-zjcx'),{dmmc:'zjcx'},false,($('#drv-zjcx').data('value')||''),'code.do?method=selectListCode','请选择准驾车型');
				form.render('select')
				//车辆类型选择下拉框事件
				ajaxTools.loadCodeDataKK($('#drv-rysx'),{dmmc:'vehdrvsx'},false,($('#drv-rysx').data('value')||''),'code.do?method=selectListCode','请选择人员属性');
				form.render('select')
			})
		</script>
	</body>
</html>
