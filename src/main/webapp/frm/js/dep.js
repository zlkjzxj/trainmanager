layui.config({
	base: '',
	version: new Date().getTime()
	
}).extend({
	domTools:'common/js/domTools',
	ajaxTools:'common/js/ajaxTools',
	hrefTools:'common/js/hrefTools',
	jqueryform:	'common/js/jquery.form',
	verifyTools:'common/js/verifyTools',
	ztree:'common/js/zTree_v3-master/js/jquery.ztree.core'
		
}).use(['element','laydate','form','verifyTools','tree','domTools','ajaxTools','hrefTools','jqueryform','ztree'], function() {
	var $ = layui.jquery,
		element = layui.element(),
		layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
		layer = layui.layer, //获取当前窗口的layer对象
		form = layui.form(),
		verifyTools = layui.verifyTools(form),
		domTools = layui.domTools,
		ajaxTools = layui.ajaxTools,
		hrefTools = layui.hrefTools;
	
	
	if($('#curr-user-glbm').val()){
		queryTree();
	}else{
		domTools.printMsgToConsole('error','当前用户管理部门错误');
	}
	
	$('#de-sjbm').val(formateGlbm_jc($('#de-sjbm').data('value')));
	
	ajaxTools.loadCodeDataKK($('#de-gltz'),{dmmc:'gltz'},false,$('#de-gltz').data('value'),'','请选择管理体制');
	ajaxTools.loadCodeDataKK($('#de-jzjb'),{dmmc:'jzjb'},false,$('#de-jzjb').data('value'),'','请选择建制级别');
	ajaxTools.loadCodeDataKK($('#de-lsgx'),{dmmc:'lsgx'},false,$('#de-lsgx').data('value'),'','请选择隶属关系');
	
	var bmjb = $('#de-bmjb').data('value');
	if(bmjb){
		$('#de-bmjb').val(bmjb);
		$('#hidden-de-bmjb').val(bmjb);
		
//		if(bmjb=='3'){
//			$('#add').removeClass('layui-btn-disabled');
//		}else{
//			$('#add').addClass('layui-btn-disabled');
//		}
	}
	
	form.render();
	
	$('#add').on('click',function(){
		if($(this).hasClass('layui-btn-disabled')){
			return;
		}

		$(this).addClass('layui-btn-disabled');
		$('#seal-edit').addClass('layui-btn-disabled');
		
		$('#opr').val('a');
		var bmjb = '4';
		var sjbm = $('#hidden-de-glbm').val();
		
		$('#mainDepEditForm input,#mainDepEditForm select').each(function(){
			$(this).val('');
		});
		
		$('#de-sjbm').val(formateGlbm_jc(sjbm));
		$('#hidden-de-sjbm').val(sjbm);
		$('#de-bmjb').val(bmjb);
		$('#hidden-de-bmjb').val(bmjb);
		
		form.render('select');
	});
	
	$('#seal-edit').on('click',function(){
		if($('#seal-edit').hasClass('layui-btn-disabled')){
			return;
		}
		var glbm = $('#hidden-de-glbm').val();
		if(!glbm){
			layer.msg('发生未知错误，管理部门代码为空，无法进入印章维护');
			return;
		}
		
		layer.open({
			type: 2,
			id:'DepSealEdit',
			content:'dep.do?method=forwardDepSealEditPage&glbm='+glbm,
			title: '印章维护', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			offset: ['30px', '25%'],
			area: ['800px', '500px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: ['关闭']
		});
	});
	
	$('#save').on('click',function(){
		if(form.verifyForm(mainDepEditForm)){
			$(mainDepEditForm).ajaxSubmit({
				type:'POST',
				url:'dep.do',
				data:{
					method:'saveDep'
				},
				dataType:'json',
				success:function(rlt){
					if(rlt.code=='1'){
						$('#opr').val('e');
						$('#hidden-de-glbm').val(rlt.backValueMap['glbm']);
						$('#seal-edit').removeClass('layui-btn-disabled');
						layer.alert(rlt.mess, {icon: 6});
					}else{
						layer.alert(rlt.mess, {icon: 5});
					}
					queryTree();
				}
			});
		}
	});
	
	$('#close').on('click',function(){
		top.closeTab(hrefTools.getLocationParam('cxdh'));
	});
	
	function queryTree(){
		$.ajax({
			url:'dep.do',
			dataType:'json',
			type:'POST',
			data:{
				method:'getDeparmentTreeJson',
				rootBmdm:$('#curr-user-glbm').val()
			},
			success:function(data){
				renderTree(data);
			},
			error:function(xhr,mess,e){
				domTools.printMsgToConsole('error','Ajax查询部门json字符串发生错误');
			}
		});
	}
	
	function renderTree(data){
		var currSelectedNodeGlbm = $('#de-bmjc').val();
		$('#depTree').html('');
		if(data){
			var ztreeObj = $.fn.zTree.init($("#depTree"), {
				callback: {
					onClick: function(event, treeId, treeNode){
						var eg = $('#hidden-de-glbm').val();
						if(!eg||eg!=treeNode.tags.glbm){
							//赋值
							queryDep(treeNode.tags.glbm);
						}
					}
				}
			}, [data]);
			
			if(currSelectedNodeGlbm){
				var ztreeCurNode = ztreeObj.getNodeByParam("name",currSelectedNodeGlbm);
				//console.log(ztreeObj.expandNode(ztreeCurNode,true,false));
				ztreeObj.selectNode(ztreeCurNode);
				
				var jCurNode = $('#'+ztreeCurNode.tId+'_span');
				var tp = parseInt(jCurNode.offset().top);
				$('#depTree').animate({
					scrollTop:(tp>90)?(tp-90):tp
			    },500);
			}
		}else{
			domTools.printMsgToConsole('error','数据查询错误');
		}
	}
	
	function renderTree_bak(data){
		var currSelectedNodeGlbm = $('#hidden-de-glbm').val();
		$('#depTree').html('');
		if(data){
			layui.tree({
				elem: '#depTree'
				,nodes: [data]
				,click:function(node){
					var eg = $('#hidden-de-glbm').val();
					if(!eg||eg!=node.tags.glbm){
						//赋值
						queryDep(node.tags.glbm);
					}
				}
				,currSelectedNodeGlbm:currSelectedNodeGlbm
			});
			
			//模拟点击，展开至当前选中树
			var cli = $('#depTree').find('li.my-tree-node-clicked');
			if(cli&&cli.length>0){
				var lis = cli.parentsUntil($('#depTree'),'li');
				lis.children('i.layui-tree-spread').click();
				
				//滚动至选中元素
				var tp = parseInt(cli.offset().top);
				//tp += $('#depTree').offset().top;
				$('#depTree').animate({
					scrollTop:tp
			    },500);
			}
		}else{
			domTools.printMsgToConsole('error','数据查询错误');
		}
	}
	
	function queryDep(glbm){
		$.getJSON('dep.do?method=getDepartment',{glbm:glbm},function(result){
			for(var i in result.dep){
				$('#de-'+i).val((result.dep[i])||'');
			}
			$('#hidden-de-glbm').val(result.dep.glbm);
			$('#hidden-de-bmjb').val(result.dep.bmjb);
			$('#hidden-de-sjbm').val(result.dep.sjbm);
			$('#opr').val('e');
			$('#de-sjbm').val(formateGlbm_jc($('#de-sjbm').val()));
			
//			if(result.dep.bmjb=='3'){
				$('#add').removeClass('layui-btn-disabled');
//			}else{
//				$('#add').addClass('layui-btn-disabled');
//			}
			$('#seal-edit').removeClass('layui-btn-disabled');
			form.render('select');
		});
	}
});
