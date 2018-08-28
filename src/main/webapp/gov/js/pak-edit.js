layui.config({
	base: ''
}).extend({
	ajaxTools:	'common/js/ajaxTools',
	glbmSelectByZTree:'common/js/glbmSelectByZTree',
	domTools:	'common/js/domTools',
	hrefTools:	'common/js/hrefTools',
	jqueryform:	'common/js/jquery.form'
}).use(['element','form','laydate','ajaxTools','glbmSelectByZTree','domTools','hrefTools','jqueryform'],function(){
	
	var $ = jquery = layui.jquery,
		element = layui.element(),
		ajaxTools  = layui.ajaxTools,
		domTools = layui.domTools,
		hrefTools = layui.hrefTools,
		form = layui.form();
	
	//自定义验证规则  
	  form.verify({  
		  hphm: [/^[A-Z_0-9]{5}$/, '号牌号码必须为5位数字或数字与字母组合！']
	  }); 
	
	
	var opr = $('#opr').val();	//e:编辑  a:新增
	if(opr=='e'){
		//较为特殊的字段无法直接el表达式赋值，js处理下
		$('#pak-cdfl').attr('readonly','readonly');
		$('#pak-cdlx').attr('readonly','readonly');
		$('#pak-cdxz').attr('readonly','readonly');
		$('#pak-ssdw').val(formateGlbm_jc($('#pak-ssdw').data('value')));
		form.render('select');
	}
	
	
	//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
	domTools.createBtnsAtBottom([{
		name:'<i class="layui-icon">&#xe654;</i> 新增', id:'pak-add', style:'border-color: deepskyblue;background-color: deepskyblue;color: #fff;'},{
		name:'<i class="layui-icon">&#xe605;</i> 保存', id:'pak-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
		name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'pak-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
	]);
	
	
	//渲染
	element.init();
	form.render();
	
	
	var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['300px','300px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
	$('#pak-ssdw').on('click',function(){
		glbmSelectByZTree.show($('#pak-ssdw'),function(event, treeId, treeNode){
			$('#pak-ssdw').val(treeNode.name);
			$('#hidden-pak-ssdw').val(treeNode.tags.glbm);
			form.render('select');
		});
	});
	
	//场地分类选择下拉框事件
	ajaxTools.loadCodeDataKK($('#pak-cdfl'),{dmmc:'tccfl'},false,($('#pak-cdfl').data('value')||''),'code.do?method=selectListCode','请选择场地分类');
	form.render('select')
	
	//场地类型选择下拉框事件
	ajaxTools.loadCodeDataKK($('#pak-cdlx'),{dmmc:'tcclx'},false,($('#pak-cdlx').data('value')||''),'code.do?method=selectListCode','请选择场地类型');
	form.render('select')
	
	//场地性质选择下拉框事件
	ajaxTools.loadCodeDataKK($('#pak-cdxz'),{dmmc:'tccxz'},false,($('#pak-cdxz').data('value')||''),'code.do?method=selectListCode','请选择场地性质');
	form.render('select')
	
	
	//新增
	$('#pak-add').click(function(){
		location.href='pak.do?method=forwardPakEditPage';
	});
	
	//提交
	$('#pak-save').click(function(){
		if(form.verifyForm(mainPakEditForm)){//form.verifyForm返回true表示表单验证成功
			var oprs = $('#opr').val()
			var gnid = oprs==='e'?'02090302':'02090301';
			$(mainPakEditForm).ajaxSubmit({
				type:'POST',
				url:'pak.do',
				data:{
					method:'processingPak',
					
					//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
					cxid:'020903',
					gnid:gnid
				},
				dataType:'json',
				success:function(rlt){
					if(rlt.code=='1'){
						$('#opr').val('e')
						$('#pak-ssdw').attr('readonly',true);
						layer.alert(rlt.mess, {icon: 6});
					}else{
						layer.alert(rlt.mess, {icon: 5});
					}
					
					try {
						//刷新父页面列表
						if(opr=='e'){
							parent.refreshPakList();
						}else{
							parent.reQueryPakList();
						}
					} catch (e) {}
				}
			});
		}
	});
	
	function reloadCdfl(){
		ajaxTools.loadCodeData($('#pak-cdfl'),{dmmc:'tccfl'},false,($('#pak-cdfl').data('value')||''));
	}
	
	function reloadCdlx(){
		ajaxTools.loadCodeData($('#pak-cdlx'),{dmmc:'tcclx'},false,($('#pak-cdlx').data('value')||''));
	}
	
	function reloadCdxz(){
		ajaxTools.loadCodeData($('#pak-cdxz'),{dmmc:'tccxz'},false,($('#pak-cdxz').data('value')||''));
	}
	
});