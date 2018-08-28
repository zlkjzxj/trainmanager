layui.config({
	base: ''
		
}).extend({
	paging:'frm/js/paging',
	glbmSelect:	'common/js/glbmSelect',
	domTools:	'common/js/domTools',
	ajaxTools:'common/js/ajaxTools',
	hrefTools:	'common/js/hrefTools',
	jqueryform:	'common/js/jquery.form'
		
}).use(['element','form','laydate','glbmSelect','domTools','hrefTools','jqueryform','paging','ajaxTools'],function(){
	var $ = jquery = layui.jquery,
	element = layui.element(),
	domTools = layui.domTools,
	hrefTools = layui.hrefTools,
	ajaxTools=layui.ajaxTools,
	form = layui.form(),
	paging=layui.paging;
	
	//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
	domTools.createBtnsAtBottom([{
		name:'<i class="layui-icon">&#xe654;</i> 新增', id:'add', style:'border-color: deepskyblue;background-color: deepskyblue;color: #fff;'},{
		name:'<i class="layui-icon">&#xe605;</i> 保存 ', id:'save', style:'border-color: #4898d5;background-color:#009688;color: #fff;'},{
		name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'close', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
	]);
	
	//单位类型选择下拉框事件
	ajaxTools.loadCodeDataDWX($('#Dwlx'),{dmmc:'dwlx'},false,($('#Dwlx').data('value')||''),'repairShop.do?method=selectListRepairShop','请选择单位类型');
	form.render('select')
	
	//翻译单位类型
	var opr = $('#opr').val();	//e:编辑  a:新增
	//if(opr=='e'){
	     //$('#Dwlx').val(formateDwlx($('#Dwlx').data('value')));
		 //form.render('select');
	//}
	
	//新增按钮（插入）
	$('#add').click(function(){
		location.href='repairShop.do?method=forwardShopEditPage';
	});
		
	//保存按钮(修改的意思)
	$('#save').click(function(){
		if(form.verifyForm(mainForm)){//form.verifyForm返回ture表示表单验证成功
			var gnid = opr==='e'?'02090502':'02090501';
			var glbm=$('#curr-user-glbm').val();
			var jbr=$('#curr-user-xm').val();
			
			$(mainForm).ajaxSubmit({
				type:'POST',
				url:'repairShop.do?method=processingRepairShop',
				data:{//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
					cxdh:hrefTools.getLocationParam('cxdh',parent),
					gnid:gnid,
					glbm:glbm,
				     jbr:jbr
				},
				dataType:'json',
				success:function(rlt){
					if(rlt.code=='1'){
						opr = 'e';
						$('#opr').val(opr);
						$('#dwbh').val(rlt.backValueMap.dwbh);
						layer.alert(rlt.mess, {icon: 6});
					}else{
						layer.alert(rlt.mess, {icon: 5});
					}
					try {
						//刷新父页面列表
						if(opr=='e'){
							parent.refreshShopList();
						}else{
							parent.reQueryShopList();
						}
					} catch (e) {}
				}
			});
		}
	});
});
