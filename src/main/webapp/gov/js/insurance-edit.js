layui.config({
	base: ''
		
}).extend({
	ajaxTools:	'common/js/ajaxTools',
	glbmSelect:	'common/js/glbmSelect',
	domTools:	'common/js/domTools',
	hrefTools:	'common/js/hrefTools',
	jqueryform:	'common/js/jquery.form',
	Tools:	'common/js/Tools'
		
}).use(['element','form','laydate','ajaxTools','glbmSelect','domTools','hrefTools','jqueryform','Tools'],function(){
	
	var $ = jquery = layui.jquery,
		element = layui.element(),
		ajaxTools  = layui.ajaxTools,
		domTools = layui.domTools,
		hrefTools = layui.hrefTools,
		laydate=layui.laydate,
		form = layui.form(),
		Tools = layui.Tools;
	
	//日期选择
	 var start = {
		    min: laydate.now()
		    ,max: '2099-06-16 23:59:59'
		    ,istoday: true
		   
		  };
	 var end = {
		    min: laydate.now(365)
		    ,max: '2099-06-16 23:59:59'
		    ,istoday: false
		   
		  };
		  
		  $('#bxyxqs').click(function(){
		    start.elem = this;
		    laydate(start);
		  });
		  $('#bxyxqz').click(function(){
		    end.elem = this
		    laydate(end);
		  });
		//验证时间
		 /* $('#bxgsmc').on('click',function(){
				Tools.getsjc($('#bxyxqs').val(),$('#bxyxqz').val(),'jbr');
			});*/
		  
	
	//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
	domTools.createBtnsAtBottom([{
		name:'<i class="layui-icon">&#xe654;</i> 新增', id:'insurance-add', style:'border-color: deepskyblue;background-color: deepskyblue;color: #fff;'},{
		name:'<i class="layui-icon">&#xe605;</i> 保存', id:'insurance-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
		name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'ue-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
	]);
	//绑定select事件
		var hphm = $('#hidden-ince-hphm').val();
		if(hphm!=null&&hphm!=""){
			var hm = hphm.substring(2);
			var hp = hphm.substr(0, 2);
			$('#ince-bdfzjg').val(hp);
			$('#hm').val(hm);
		}
		var bxje=$('#Insurance-bxje').val();
		if(bxje!=null&&bxje!=""){
			$('#je').val(bxje);
		}
	//渲染
	element.init();
	form.render();
	
	var opr = $('#opr').val();	//e:编辑  a:新增
	if(opr=='e'){
		//较为特殊的字段无法直接el表达式赋值，js处理下
		$('#bxyxqz').val(formateShortDate($('#bxyxqz').data('value')));
		$('#bxyxqs').val(formateShortDate($('#bxyxqs').data('value')));
		$('#bxzl').attr('disabled',true);
		$('input[name=bxdh]').attr("readonly","readonly")//将input元素设置为readonly
		$('input[name=bxdh]').attr("UNSELECTABLE","on" )//光标消失
	}else if(opr=='a'){
		$('input[name=bxdh]').removeAttr("readonly");//去除input元素的readonly属性
		$('#bxzl').attr('disabled',false);
	}
	
	//号牌种类选择下拉框事件
	ajaxTools.loadCodeDataKK($('#hpzl'),{dmmc:'hpzl'},false,($('#hpzl').data('value')||''),'code.do?method=selectListCode','请选择号牌种类');
	form.render('select')
	//保险种类选择下拉框事件
	ajaxTools.loadCodeDataKK($('#bxzl'),{dmmc:'bxzl'},false,($('#bxzl').data('value')||''),'code.do?method=selectListCode','请选择保险种类');
	form.render('select')
	
	//新增
	$('#insurance-add').click(function(){
		location.href='insurance.do?method=forwardInsuranceEdit';
	});
	
	//保存按钮(修改的意思)
	$('#insurance-save').click(function(){
		var s=$("#bxyxqs").val();
		var z=$("#bxyxqz").val();
		if(s>z){
		Tools.getsjc($('#bxyxqs').val(),$('#bxyxqz').val());
		 return false;
		}
		
		if(form.verifyForm(mainForm)){//form.verifyForm返回ture表示表单验证成功
		    var glbm=$("#curr-user-glbm").val();              	
		 	var gnid = opr==='e'?'02080402':'02080401';
			var hphm = $('#ince-bdfzjg').val()+$('#hm').val();
			$('#hphm').val(hphm);
			$(mainForm).ajaxSubmit({
				type:'POST',
				url:'insurance.do',
				data:{
					method:'saveGovFlow',
					//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
					cxdh:hrefTools.getLocationParam('cxdh',parent),
					gnid:gnid,
					hphm:hphm,
					glbm:glbm
				},
				dataType:'json',
				success:function(rlt){
					if(rlt.code=='1'){
						opr = 'e';
						$('#opr').val(opr);
						layer.alert(rlt.mess, {icon: 6});
					}else{
						layer.alert(rlt.mess, {icon: 5});
					}
					
					try {
						//刷新父页面列表
						if(opr=='e'){
							parent.reQueryInsuranceList();
						}else{
							parent.refreshInsuranceList();
						}
					} catch (e) {}
				}
			});
		}
	});
});
