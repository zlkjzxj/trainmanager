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
	
	
	//登陆模式
	$('#ue-dlms-div').html('');
	var dlmsCode = ajaxTools.getCodeData({dmmc:'dlms'})
		,tempDlmsStr = ''
		,dlmsVal = $('#ue-dlms').data('value').toString();
	
	for(var dc in dlmsCode){
		tempDlmsStr += '<input lay-filter="DlmsCheckbox" type="checkbox" '+((dlmsVal!=undefined&&dlmsVal!=''&&dlmsVal!=null&&dlmsVal.indexOf(dlmsCode[dc].dm.toString())>-1)?'checked':'')+' value="'+dlmsCode[dc].dm+'" data-value="'+dlmsCode[dc].dm+'"  title="'+dlmsCode[dc].mc+'">';
	}
	$('#ue-dlms-div').html(tempDlmsStr);
	
	
	//登陆模式事件
	$('#ue-dlms').parent().on('mouseleave',function(){
		$('#ue-dlms-div').removeClass('layui-show').addClass('layui-hide');
	});
	
	form.on('checkbox(DlmsCheckbox)', function(data){
		var t = [],v = [];
		$('#ue-dlms-div input:checked').each(function(){
			t.push($(this).attr('title'));
			v.push($(this).data('value'));
		});
		$('#ue-dlms').val(t.join(', '));
		$('#hidden-ue-dlms').val(v.join(','));
	});
	
	
	//用户权限
	renderQx();
	
	
	var opr = $('#opr').val();	//e:编辑  a:新增
	if(opr=='e'){
		//较为特殊的字段无法直接el表达式赋值，js处理下
		$('#ue-yhdh').attr('readonly','readonly');
		$('#ue-glbm').val(formateGlbm_jc($('#ue-glbm').data('value')));
		$('#ue-yhyxq').val(formateShortDate($('#ue-yhyxq').data('value')));
		$('#ue-mmyxq').val(formateShortDate($('#ue-mmyxq').data('value')));
		$('#ue-dlms').val(formateDlms($('#ue-dlms').data('value')));
		$('#ue-sfqy')[0].checked=($('#ue-sfqy').data('value')=='0');
		$('#ue-sfgly')[0].checked=($('#ue-sfgly').data('value')=='1');
		reloadYhjb();
		reloadYhlb();
		reloadQxms();
		form.render('select');
	}
	
	
	//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
	domTools.createBtnsAtBottom([{
		name:'<i class="layui-icon">&#xe654;</i> 新增', id:'ue-add', style:'border-color: deepskyblue;background-color: deepskyblue;color: #fff;'},{
		name:'<i class="layui-icon">&#xe605;</i> 保存', id:'ue-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
		name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'ue-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
	]);
	
	
	//渲染
	element.init();
	form.render();
	
	
//	var glbmSelect = layui.glbmSelect({bgColor:'#F9FAFC',area:['200px','100px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
//	$('#ue-glbm').on('click',function(){
//		glbmSelect.show($('#ue-glbm'),function(node){
//			$('#ue-glbm').val(node.name);
//			$('#hidden-ue-glbm').val(node.tags.glbm);
//			$('#hidden-ue-bmjb').val(node.tags.bmjb);
//			reloadYhjb();
//			reloadYhlb();
//			reloadQxms();
//			form.render('select');
//		});
//	});
	//初始换管理部门下拉选择框
	var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['280px','280px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
	//管理部门选择下拉框事件
	$('#ue-glbm').on('click',function(){
		glbmSelectByZTree.show($('#ue-glbm'),function(event, treeId, treeNode){
			$('#ue-glbm').val(treeNode.name);
			$('#hidden-ue-glbm').val(treeNode.tags.glbm);
			$('#hidden-ue-bmjb').val(treeNode.tags.bmjb);
			reloadYhjb();
			reloadYhlb();
			reloadQxms();
			form.render('select');
		});
	});
	
	//绑定用户级别select事件
	form.on('select(UserJbSelect)',function(data){
		reloadYhlb();
		reloadQxms();
		form.render('select');
	});
	
	
	//绑定是否管理员switch事件
	form.on('switch(SfglySwitch)',function(data){
		reloadQxms();
		form.render('select');
	});
	
	
	//绑定权限模式select事件
	form.on('select(QxmsSelect)',function(data){
		refreshQx();
	});
	
	
	//新增
	$('#ue-add').click(function(){
		location.href='user.do?method=forwardUserEditPage';
	});
	
	
	//提交
	$('#ue-save').click(function(){
		if(form.verifyForm(mainUserEditForm)){//form.verifyForm返回ture表示表单验证成功
			var sfgly = $('#ue-sfgly')[0].checked?'1':'0';
			var zt = $('#ue-sfqy')[0].checked?'0':'1';
			var gnid = opr==='e'?'01010302':'01010301';
			if($('#hidden-ue-dlms').val().toString().indexOf('9')>-1){
				$('#hidden-ue-dlms').val('9');
			}
			
			var qxms = $('#ue-qxms').val(),cxdhs = [],cxdh = '';
			if(qxms==='@'){
				var cks = $('#ue-yhqx input[lay-filter=CzqxCheckBox]:checked').not(':disabled');
				if(!cks||cks.length==0){
					layer.msg('请选择用户操作权限，或分配角色', {icon: 5,shift: 6});
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
			}
			
			$(mainUserEditForm).ajaxSubmit({
				type:'POST',
				url:'user.do',
				data:{
					method:'processingUser',
					
					//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
					cxid:hrefTools.getLocationParam('cxdh',parent),
					gnid:gnid,
					cxdh:cxdh,
					sfgly:sfgly,
					zt:zt
				},
				dataType:'json',
				success:function(rlt){
					if(rlt.code=='1'){
						opr = 'e';
						$('#opr').val(opr);
						$('#ue-yhdh').attr('readonly',true);
						layer.alert(rlt.mess, {icon: 6});
					}else{
						layer.alert(rlt.mess, {icon: 5});
					}
					
					try {
						//刷新父页面列表
						if(opr=='e'){
							parent.refreshUserList();
						}else{
							parent.reQueryUserList();
						}
					} catch (e) {}
				}
			});
		}
	});
	
	
	function reloadYhjb(defaultJb){
		var bmjb = $('#hidden-ue-bmjb').val() || $('#ue-yhjb').data('value');
		if(!bmjb){
			return;
		}
		if(bmjb>4){bmjb=4}
		ajaxTools.loadCodeData($('#ue-yhjb'),{dmmc:'yhjb',gldmmc:'bmjb',gldm:bmjb},false,($('#ue-yhjb').data('value')||''));
		form.render('select');
	}
	
	function reloadYhlb(){
		ajaxTools.loadCodeData($('#ue-yhlb'),{dmmc:'yhlb',gldmmc:'yhjb',gldm:$('#ue-yhjb').val()},false,($('#ue-yhlb').data('value')||''));
	}
	
	function reloadQxms(){
		if($('#ue-yhjb').val().toString()){
			ajaxTools.loadQxgroupData($('#ue-qxms'),{sfgly:($('#ue-sfgly')[0].checked?'1':'0'),qxsyjb:$('#ue-yhjb').val()},false,($('#ue-qxms').data('value')||''));
			refreshQx();
		}
	}
	
	function refreshQx(){
		var cxqxData
			,qxms = $('#ue-qxms').val()
			,yhdh = $('#ue-yhdh').val()
			,yhjb = $('#ue-yhjb').val()
			,sfgly = ($('#ue-sfgly')[0].checked?'1':'0');
		
		if(!qxms){
			clearQx();
			//domTools.printMsgToConsole('error','');
			return;
		}
		
		if(qxms==='@'&&opr=='e'){
			cxqxData = ajaxTools.getAllMenuStr({yhdh:yhdh});
		}else if(qxms==='@'){
			clearQx(qxms);
		}else{
			cxqxData = ajaxTools.getQxgroupMenuStr({qxgroup:qxms});
		}
		
		if(!cxqxData){
			clearQx();
			//domTools.printMsgToConsole('error','');
			return;
		}
		
		if(cxqxData.code||cxqxData.mess){
			clearQx();
			//domTools.printMsgToConsole('error',(cxqxData.mess||'发生错误'));
			return;
		}
		
		$('#ue-yhqx .callcxmenus').each(function(){
			this.disabled = (qxms!='@');
		});
		$('#ue-yhqx .cxmenus').each(function(){
			this.checked = (cxqxData.toString().indexOf($(this).data('cxdh').toString())>-1);
			this.disabled = !(($(this).data('sfgly').toString().indexOf(sfgly)>-1)&&($(this).data('syjb').toString().indexOf(yhjb)>-1)&&qxms=='@');
		});
		refreshCheckNum();
		
		form.render('checkbox');
		
		//列表无默认：数据错误
		if($('#ue-yhqx .cxmenus:checked:disabled').length>0){
			//数据中存在错误的权限
		}
	}

	function clearQx(qxms){
		var qxms = $('#ue-qxms').val()
			,yhjb = $('#ue-yhjb').val()
			,sfgly = ($('#ue-sfgly')[0].checked?'1':'0');
		$('#ue-yhqx .callcxmenus').each(function(){
			this.disabled = (qxms!='@');
		});
		$('#ue-yhqx .cxmenus').each(function(){
			this.checked = false;
			
			if(($(this).data('sfgly').toString().indexOf(sfgly)>-1)
					&&($(this).data('syjb').toString().indexOf(yhjb)>-1)
					&&qxms=='@'){
				this.disabled = false;
			}else{
				this.disabled = true;
			}
		});
		clearCheckNum();
		
		form.render('checkbox');
	}
	
	function renderQx(){
		var menuCode = ajaxTools.getUserAllMenu();
		$('#ue-yhqx').html('');
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
		$('#ue-yhqx').html(tempMenuStr);
		
		clearCheckNum();
		
		form.on('checkbox(CzqxCheckAllBox)',function(data){
			if(event.stopPropagation){
			    event.stopPropagation();	//阻止事件继续传播  
			}else{
			    event.cancelBubble=true;	//ie8
			}

			$('#ue-yhqx .cxmenus-'+$(data.elem).data('i')+' input[type=checkbox]').each(function(){
				this.checked = !this.disabled;
			});
			
			refreshCheckNum();
		});
		
		form.on('checkbox(CzqxCheckBox)',function(data){
			refreshCheckNum();
		});
	}
	
	function clearCheckNum(){
		$('#ue-yhqx .layui-colla-content').each(function(){
			$(this).prev().find('span.allNum').text('0/'+($(this).find('input[type=checkbox]').length));
			try{
				$(this).prev().find(':checked')[0].checked=false;
				form.render('checkbox');
			}catch(e){}
		});
	}
	
	function refreshCheckNum(){
		$('#ue-yhqx .layui-colla-content').each(function(){
			var n1 = ($(this).find('input:checked').length);
			var n2 = ($(this).find('input[type=checkbox]').length);
			$(this).prev().find('span.allNum').text(n1+'/'+n2);
			$(this).prev().find('input[type=checkbox]')[0].checked=(n1==n2);
			form.render('checkbox');
		});
	}
});
