layui.config({
	base: ''
}).extend({
	ajaxTools:	'common/js/ajaxTools',
	glbmSelectByZTree:'common/js/glbmSelectByZTree',
	domTools:	'common/js/domTools',
	hrefTools:	'common/js/hrefTools',
	imageTools:	'common/js/imageTools',
	jqueryform:	'common/js/jquery.form'
}).use(['element','form','laydate','ajaxTools','glbmSelectByZTree','domTools','hrefTools','imageTools','jqueryform'],function(){
	
	var $ = jquery = layui.jquery,
		element = layui.element(),
		ajaxTools  = layui.ajaxTools,
		domTools = layui.domTools,
		hrefTools = layui.hrefTools,
		imageTools = layui.imageTools,
		form = layui.form();
	
	//自定义验证规则  
	  form.verify({  
		  hphm: [/^[A-Z_0-9]{5}$/, '号牌号码必须为5位数字或数字与字母组合！']
	  });
	
	
	
	$('#car-nssjq').val(formateLongDate($('#yxqsh').val()));
	$('#car-nssjz').val(formateLongDate($('#yxqzh').val()));
	
	//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
	domTools.createBtnsAtBottom([{
		name:'<i class="layui-icon">&#xe654;</i> 新增', id:'veh-add', style:'border-color: deepskyblue;background-color: deepskyblue;color: #fff;'},{
		name:'<i class="layui-icon">&#xe605;</i> 保存', id:'veh-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
		name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'veh-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
	]);
	
	
	//初始换管理部门下拉选择框
	var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['255px','200px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
	//管理部门选择下拉框事件
	$('#veh-glbm').on('click',function(){
		glbmSelectByZTree.show($('#veh-glbm'),function(event, treeId, treeNode){
			$('#veh-glbm').val(treeNode.name);
			$('#hidden-veh-glbm').val(treeNode.tags.glbm);
		},$(this).val());//第三个参数传一个bmjc，打开管理部门下拉选择树后，会默认展开到该部门，并添加选中样式
	});
	
	//车辆类型选择下拉框事件
	ajaxTools.loadCodeDataKK($('#veh-hpzl'),{dmmc:'hpzl'},false,($('#veh-hpzl').data('value')||''),'code.do?method=selectListCode','请选择号牌种类');
	form.render('select')
	
	//车辆类型选择下拉框事件
	ajaxTools.loadCodeDataKK($('#veh-cllx'),{dmmc:'cllx'},false,($('#veh-cllx').data('value')||''),'code.do?method=selectListCode','请选择车辆类型');
	form.render('select')
	
	//车辆类型选择下拉框事件
	ajaxTools.loadCodeDataKK($('#veh-vehdrvsx'),{dmmc:'vehdrvsx'},false,($('#veh-vehdrvsx').data('value')||''),'code.do?method=selectListCode','请选择车辆属性');
	form.render('select')
	
	
	//绑定权限模式select事件
	var hphm = $('#hidden-veh-hphm').val();
	if(hphm!=null&&hphm!=""){
		var hm = hphm.substring(2);
		var hp = hphm.substr(0, 2);
		$('#veh-bdfzjg').val(hp);
		$('#hm').val(hm);
	}
	
	
	//新增
	$('#veh-add').click(function(){
		location.href='veh.do?method=forwardVehEditPage';
	});
	
	//alert(window.navigator.userAgent.toUpperCase());
	$('#pic').change(function(){
		imageTools.previewImage($('#pic')[0],'PreviewImg','PreviewDiv');
		var browserVersion = window.navigator.userAgent.toUpperCase();
		if(browserVersion.indexOf("MSIE")>-1)
			document.getElementById('pic').style.marginTop="-200";
	});
//	$('#pics').change(function(){
//		imageTools.previewImage($('#pics')[0],'previews','previewDivs');
//	});
	
	var opr = $('#opr').val();	//e:编辑  a:新增
	if(opr=='e'){
		//较为特殊的字段无法直接el表达式赋值，js处理下
		$('#veh-hpzl').attr('disabled', true);
		$('#hm').attr('readonly','readonly');
		$('#veh-glbm').val(formateGlbm_jc($('#veh-glbm').data('value')));
		form.render('select');
	}
	
	//提交
	$('#veh-save').click(function(){
		if(form.verifyForm(mainVehEditForm)){//form.verifyForm返回true表示表单验证成功
			//将初始里程赋值给累计里程的初始值(方便计算)
			$('#veh-ljlc').val($('#veh-cslc').val());
			var oprs = $('#opr').val()
			var gnid = oprs==='e'?'02090102':'02090101';
			var hphm = $('#veh-bdfzjg').val()+$('#hm').val();
			$('#hphm').val(hphm);
			var hpzls=$("#veh-hpzl").val();
			$('#hpzl').val(hpzls);
			$(mainVehEditForm).ajaxSubmit({
				type:'POST',
				url:'veh.do',
				data:{
					method:'updateVehPhoto',
					
					//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
					cxdh:'020901',
					gnid:gnid
				},
				dataType:'json',
				success:function(rlt){
					if(rlt.code=='1'){
						$('#opr').val('e');
						$('#veh-hpzl').attr('readonly',true);
						$('#veh-hm').attr('readonly',true);
						$('#veh-glbm').attr('readonly',true);
						layer.alert(rlt.mess, {icon: 6});
					}else{
						layer.alert(rlt.mess, {icon: 5});
					}
					
					try {
						//刷新父页面列表
						if(opr=='e'){
							parent.refreshVehList();
						}else{
							parent.reQueryVehList();
						}
					} catch (e) {}
				}
			});
		}
	});	
});