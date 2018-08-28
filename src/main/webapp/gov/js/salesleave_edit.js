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
	
	//业务类型
	$('#ywlxs').text(formateYwlx($('#ywlx').val()));
	//业务原因
	var lx = $('#ywlx').val();
	var yy = $('#ywyy').val();
	$('#ywyys').text(formateYwYy(yy,lx));
	//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
	domTools.createBtnsAtBottom([{
		name:'<i class="layui-icon">&#xe605;</i> 销假', id:'archive-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
		name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'archive-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
	]);
	
	//开始时间
	$('.kssj').text(formateLongDate($('#kssj').val()));
	//结束时间
	$('.jssj').text(formateLongDate($('#jssj').val()));
	//申请日期
	$('.sqrq').text(formateLongDate($('#sqrq').val()));
	
	//提交
	$('#archive-save').click(function(){
		if($('#archive-save').attr('disabled')=="disabled"){
			return;
		}
		if(form.verifyForm(mainForm)){//form.verifyForm返回true表示表单验证成功
			$(mainForm).ajaxSubmit({
				type:'POST',
				url:'flow.do',
				data:{
					method:'saveGovArchive',
					
					//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
					cxdh:'020802',
					gnid:'02080201'
				},
				dataType:'json',
				success:function(rlt){
					if(rlt.code=='1'){
						$('#archive-save').css({ background: "",color:"gray"});
						$('#archive-save').attr('disabled',true);
						layer.alert(rlt.mess, {icon: 6});
					}else{
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
	$('#close').on('click',function(){
		top.closeTab(hrefTools.getLocationParam('cxdh'));
	});
});