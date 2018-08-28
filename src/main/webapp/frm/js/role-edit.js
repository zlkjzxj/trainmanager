layui.config({
	base: ''
		
}).extend({
	ajaxTools:	'common/js/ajaxTools',
	glbmSelect:	'common/js/glbmSelect',
	domTools:	'common/js/domTools',
	hrefTools:	'common/js/hrefTools',
	jqueryform:	'common/js/jquery.form'
		
}).use(['element','form','laydate','ajaxTools','glbmSelect','domTools','hrefTools','jqueryform'],function(){
	
	var $ = jquery = layui.jquery,
		element = layui.element(),
		ajaxTools  = layui.ajaxTools,
		domTools = layui.domTools,
		hrefTools = layui.hrefTools,
		form = layui.form();
	
	
	var opr = $('#opr').val();	//e:编辑  a:新增  v:查看
	
	
	//用户权限
	renderQx();
	
	
	//权限使用级别
	$('#re-qxsyjb-div').html('');
	var qxsyjbData = ajaxTools.getCodeData({dmmc:'yhjb'});
	var qxsyjbStr = '';
	for(var i in qxsyjbData){
		qxsyjbStr += '<input type="checkbox" lay-filter="qxsyjbCheckbox" data-value="'+qxsyjbData[i].dm+'" title="'+qxsyjbData[i].mc+'" lay-skin="primary" />';
	}
	$('#re-qxsyjb-div').html(qxsyjbStr);
	
	form.on('checkbox(qxsyjbCheckbox)',function(data){
		var v = [];
		$('#re-qxsyjb-div input[type=checkbox]').each(function(){
			if($(this)[0].checked){
				v.push($(this).data('value'));
			}
		});
		$('#hidden-re-qxsyjb').val(v.join(','));
		refreshQx();
	});
	
	
	//是否管理员
	form.on('switch(SfglySwitch)',function(data){
		refreshQx();
	});
	
	
	//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
	domTools.createBtnsAtBottom([{
		name:'<i class="layui-icon">&#xe654;</i> 新增', id:'re-add', style:'border-color: deepskyblue;background-color: deepskyblue;color: #fff;'},{
		name:'<i class="layui-icon">&#xe605;</i> 保存', id:'re-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
		name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'re-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
	]);
	
	
	if(opr=='v'||opr=='e'){
		$('#re-sfgly')[0].checked=($('#re-sfgly').data('value')=='1');
		
		$('#re-qxsyjb-div input[type=checkbox]').each(function(){
			var v = $('#hidden-re-qxsyjb').val().toString();
			if(v&&v.indexOf($(this).data('value'))>-1){
				$(this).attr('checked',true);
			}
		});

		refreshQx();
		
		if(opr=='v'){
			$('#re-add,#re-save').addClass('layui-hide');
			$('#re-cancel').css({'border-color':'#4898d5','background-color':'#2e8ded','color':'#fff'});
		}
	}
	
	
	//渲染
	element.init();
	form.render();
	
	
	//新增
	$('#re-add').click(function(){
		location.href='role.do?method=forwardRoleEditPage';
	});
	
	
	//提交
	$('#re-save').click(function(){
		if(form.verifyForm(mainRoleEditForm)){//form.verifyForm返回ture表示表单验证成功
			var sfgly = $('#re-sfgly')[0].checked?'1':'0';
			var gnid = opr==='e'?'01010202':'01010201';
			
			if(!$('#hidden-re-qxsyjb').val()){
				layer.msg('请选择权限使用级别', {icon: 5,shift: 6});
				return;
			}
			
			var cxdhs = [],cxdh = '';
			var cks = $('#re-czqx input[lay-filter=CzqxCheckBox]:checked').not(':disabled');
			if(!cks||cks.length==0){
				layer.msg('请选择角色操作权限', {icon: 5,shift: 6});
				return;
			}
			
			cks.each(function(){
				cxdhs.push($(this).data('cxdh'));
			});
			
			cxdh = cxdhs.join(',');
			
			if(!cxdh){
				layer.msg('选取用户操作权限发生未知错误', {icon: 5,shift: 6});
				return;
			}
			
			$(mainRoleEditForm).ajaxSubmit({
				type:'POST',
				url:'role.do',
				data:{
					method:'processingRole',
					
					//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
					cxid:hrefTools.getLocationParam('cxdh',parent),
					gnid:gnid,
					cxdh:cxdh,
					sfgly:sfgly
				},
				dataType:'json',
				success:function(rlt){
					if(rlt.code=='1'){
						opr = 'e';
						$('#opr').val(opr);
						$('#hidden-re-qxgroup').val(rlt.mess);//情况特殊，存储过程直接将主键返到了mess里，所以不是backValueMap字段取值
						layer.alert('操作成功', {icon: 6});
					}else{
						layer.alert(rlt.mess, {icon: 5});
					}
					
					try {
						//刷新父页面列表
						if(opr=='e'){
							parent.refreshRoleList();
						}else{
							parent.reQueryRoleList();
						}
					} catch (e) {}
				}
			});
		}
	});
	
	
	function refreshQx(){
		var cxqxData = $('#hidden-re-cxdh').val()
			,opr = $('#opr').val()
			,qxgroup = $('#hidden-re-qxgroup').val()
			,yhjb = $('#hidden-re-qxsyjb').val()
			,yhjbs = yhjb.split(',')
			,sfgly = ($('#re-sfgly')[0].checked?'1':'0');
		
		
		$('#re-czqx .cxmenus').each(function(){
			var jbFlag = false;
			for(var i in yhjbs){
				if(yhjbs[i]!=''&&$(this).data('syjb').toString().indexOf(yhjbs[i])>-1){
					jbFlag = true; //符合所选级别
					break;
				}
			}
			this.checked = (cxqxData.toString().indexOf($(this).data('cxdh').toString())>-1);
			this.disabled = !(($(this).data('sfgly').toString().indexOf(sfgly)>-1)&&jbFlag); 
		});
		refreshCheckNum();
		
		form.render('checkbox');
		
		if($('#re-czqx .cxmenus:checked:disabled').length>0){
			//数据中存在错误的权限
		}
	}

	
	function renderQx(){
		var menuCode = ajaxTools.getUserAllMenu();
		$('#re-czqx').html('');
		var tempMenuStr = '';
		for(var i in menuCode){
			var lbmenus = menuCode[i].programLbList;
			var mlstr = '';
			for(var j in lbmenus){
				var cxmenus = lbmenus[j].programList;
				var cxstr = '';
				for(var k in cxmenus){
					cxstr += '<input class="cxmenus" type="checkbox" lay-filter="CzqxCheckBox" data-cxdh="'+(cxmenus[k].cxdh)+'" data-sfgly="'+(cxmenus[k].sfgly)+'" data-syjb="'+(cxmenus[k].syjb)+'" disabled lay-skin="primary" title="'+cxmenus[k].cxmc+'">';
				}
				mlstr += '<div class="layui-form-item">\
							<label class="layui-form-label">'+lbmenus[j].lbmc+'</label>\
				    		<div class="layui-input-block">'+cxstr+'</div>\
						  </div>';
				
				if(j<lbmenus.length-1){
					mlstr += '<hr>';
				}
			}
			tempMenuStr += '<div class="layui-colla-item">\
					  			<h2 class="layui-colla-title">\
									<span class="'+menuCode[i].mltp+'"></span> '+menuCode[i].mlmc+'\
									<span class="all"><span class="allNum">0/0</span><input class="callcxmenus" data-i="'+i+'"  type="checkbox" lay-filter="CzqxCheckAllBox" lay-skin="primary" title="全选" /></span>\
								</h2>\
					  			<div class="layui-colla-content cxmenus-'+i+'">'+mlstr+'</div>\
							</div>';
		}
		$('#re-czqx').html(tempMenuStr);
		
		clearCheckNum();
		
		form.on('checkbox(CzqxCheckAllBox)',function(data){
			if(event.stopPropagation){
			    event.stopPropagation();	//阻止事件继续传播  
			}else{
			    event.cancelBubble=true;	//ie8
			}

			$('#re-czqx .cxmenus-'+$(data.elem).data('i')+' input[type=checkbox]').each(function(){
				this.checked = !this.disabled;
			});
			
			refreshCheckNum();
		});
		
		form.on('checkbox(CzqxCheckBox)',function(data){
			refreshCheckNum();
		});
	}
	
	function clearCheckNum(){
		$('#re-czqx .layui-colla-content').each(function(){
			$(this).prev().find('span.allNum').text('0/'+($(this).find('input[type=checkbox]').length));
			try{
				$(this).prev().find(':checked')[0].checked=false;
				form.render('checkbox');
			}catch(e){}
		});
	}
	
	function refreshCheckNum(){
		$('#re-czqx .layui-colla-content').each(function(){
			var n1 = ($(this).find('input:checked').length);
			var n2 = ($(this).find('input[type=checkbox]').length);
			$(this).prev().find('span.allNum').text(n1+'/'+n2);
			$(this).prev().find('input[type=checkbox]')[0].checked=(n1==n2);
			form.render('checkbox');
		});
	}
});
