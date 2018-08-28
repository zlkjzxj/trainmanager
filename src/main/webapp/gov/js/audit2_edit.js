layui.config({
	base: '',
	version: new Date().getTime()
}).extend({
	paging:'frm/js/paging',
	glbmSelectByZTree:'common/js/glbmSelectByZTree',
	hrefTools:'common/js/hrefTools',
	ajaxTools:'common/js/ajaxTools',
	domTools:'common/js/domTools',
	jqueryform:	'common/js/jquery.form'
}).use(['element','laydate','paging','form','tree','glbmSelectByZTree','hrefTools','ajaxTools','domTools','jqueryform'], function() {
	var $ = layui.jquery,
		paging = layui.paging(),
		layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
		layer = layui.layer, //获取当前窗口的layer对象
		form = layui.form(),
		hrefTools = layui.hrefTools,
		domTools = layui.domTools,
		ajaxTools = layui.ajaxTools;
		//禁用Enter键表单自动提交
		document.onkeydown = function(event) {
			var target, code, tag;
			if (!event) {
				event = window.event; //针对ie浏览器
				target = event.srcElement;
				code = event.keyCode;
				if (code == 13) {
					tag = target.tagName;
					if (tag == "TEXTAREA"){
						return true;
					}else{
						return false;
					}
				}
			}else{
				target = event.target; //针对遵循w3c标准的浏览器，如Firefox
				code = event.keyCode;
				if (code == 13) {
					tag = target.tagName;
					if (tag == "INPUT") { return false; }
						else { return true; }
					}
				}
		}
		var yl=$('#ywlx').val()
		if(yl=="A"){
			$('#gwycxx').attr('style','display:block;padding-top:0px;padding-bottom:0px;');
			
			var o = document.getElementById('gwycxx');
			if(o.offsetHeight > 176){
				$('#ywxxtop').attr('style','height:320px;position:relative;margin-top:0px;overflow-x:hidden;overflow-y:scroll;');
			}
		}else if(yl=="B"){
			$('#jdcbyxx').attr('style','display:block;padding-top:0px;padding-bottom:0px;');
			
			var o = document.getElementById('jdcbyxx');
			if(o.offsetHeight > 176){
				$('#ywxxtop').attr('style','height:320px;position:relative;margin-top:0px;overflow-x:hidden;overflow-y:scroll;');
			}
		}else if(yl=="C"){
			$('#qxjxx').attr('style','display:block;padding-top:0px;padding-bottom:0px;');
			
			var o = document.getElementById('qxjxx');
			if(o.offsetHeight > 176){
				$('#ywxxtop').attr('style','height:320px;position:relative;margin-top:0px;overflow-x:hidden;overflow-y:scroll;');
			}
		}else if(yl=="D"){
			$('#jdcczxx').attr('style','display:block;padding-top:0px;padding-bottom:0px;');
			
			var o = document.getElementById('jdcczxx');
			if(o.offsetHeight > 176){
				$('#ywxxtop').attr('style','height:320px;position:relative;margin-top:0px;overflow-x:hidden;overflow-y:scroll;');
			}
		}else{
			
		}
		
		//申请部门
		$('#sqbms').text(formateGlbm_jc($('#sqbm').val()));
		//业务类型
		$('#ywlxs').text(formateYwlx($('#ywlx').val()));
		//业务原因
		var lx = $('#ywlx').val();
		var yy = $('#ywyy').val();
		$('#ywyys').text(formateYwYy(yy,lx));
		
		//审核结果下拉框事件
		ajaxTools.loadCodeForRadio($('#audit-shjg'),'shjg',{dmmc:'shjg'},false,'1','');
		form.render('radio')
		//车辆类型
		$('.audit-cllx').html(formateCllx($('#audit-cllx').val()));
		//开始时间
		$('.kssj').text(formateLongDate($('#kssj').val()));
		//结束时间
		$('.jssj').text(formateLongDate($('#jssj').val()));
		//申请日期
		$('.sqrq').text(formateLongDate($('#sqrq').val()));
		//部门审批
		$('#bmsp').val(formateShjg($('#bmsp').val()));
	//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
//	domTools.createBtnsAtBottom([{
//		name:'<i class="layui-icon">&#xe605;</i> 保存', id:'audit-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
//		name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'audit-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
//	]);
	//提交
	$('#audit-save').click(function(){
		if($('#audit-save').attr('disabled')=="disabled"){
			return;
		}
		var shjg = $("input[name='shjg']:checked").val();
		if(shjg=="2"){
			var bzz = $('#bz').val(); 
			if(bzz==""){
				layer.alert("请输入审核意见！",{icon: 5});
				return;
			}
		}
		if(form.verifyForm(mainForm)){//form.verifyForm返回true表示表单验证成功
			$('#audit-save').css({ background: "#F2F2F2",color:"gray"});
			$('#audit-save').attr('disabled',true);
			$(mainForm).ajaxSubmit({
				type:'POST',
				url:'audit.do',
				data:{
					method:'saveGovAudit',
					
					//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
					cxdh:'020103',
					gnid:'02010301',
					shjg:shjg
				},
				dataType:'json',
				success:function(rlt){
					if(rlt.code=='1'){
						layer.alert(rlt.mess, {icon: 6});
					}else{
						$('#audit-save').css({ background: "#4F98C2",color:"#FEFEFE"});
						$('#audit-save').attr('disabled',false);
						layer.alert(rlt.mess, {icon: 5});
					}
					
					try {
						//刷新父页面列表
						parent.refreshFlowList();
					} catch (e) {}
				}
			});
		}
	});
	
	//关闭按钮
	$('#audit-cancel').on('click', function() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭
	});
});