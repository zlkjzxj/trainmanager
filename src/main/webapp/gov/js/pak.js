layui.config({
	base: '',
	version: new Date().getTime()
}).extend({
	paging:'frm/js/paging',
	glbmSelectByZTree:'common/js/glbmSelectByZTree',
	hrefTools:'common/js/hrefTools',
	ajaxTools:'common/js/ajaxTools',
	domTools:'common/js/domTools'
}).use(['element','laydate','paging','form','tree','glbmSelectByZTree','hrefTools','ajaxTools','domTools'], function() {
	var $ = layui.jquery,
		paging = layui.paging(),
		layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
		layer = layui.layer, //获取当前窗口的layer对象
		form = layui.form(),
		hrefTools = layui.hrefTools,
		domTools = layui.domTools,
		ajaxTools = layui.ajaxTools;
	
	
	//初始换管理部门下拉选择框
	var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['300px','300px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
	//管理部门选择下拉框事件
	$('#pak-glbm').on('click',function(){
		glbmSelectByZTree.show($('#pak-glbm'),function(event, treeId, treeNode){
			$('#pak-glbm').val(treeNode.name);
			$('#hidden-pak-glbm').val(treeNode.tags.glbm);
		},$(this).val());
	});
	//场地分类下拉框事件
	ajaxTools.loadCodeDataKK($('#pak-cdfl'),{dmmc:'tccfl'},false,'','code.do?method=selectListCode','场地分类');
	form.render('select')
	
	
	//场地类型下拉框事件
	ajaxTools.loadCodeDataKK($('#pak-cdlx'),{dmmc:'tcclx'},false,'','code.do?method=selectListCode','场地类型');
	form.render('select')
	
	
	//场地性质下拉框事件
	ajaxTools.loadCodeDataKK($('#pak-cdxz'),{dmmc:'tccxz'},false,'','code.do?method=selectListCode','场地性质');
	form.render('select')
	
	//查询按钮
	$('#query').on('click',function(){
		queryPakList();
	});
	
	
	//重置按钮
	$('#reset').on('click',function(){
		$('#pak-glbm').val('');
		$('#hidden-pak-glbm').val('');
		$('#pak-cdfl').val('');
		$('#pak-cdlx').val('')
		$('#pak-cddz').val('')
		form.render('select')
		form.render('checkbox');
	});
	
	
	//新增按钮
	$('#add').on('click', function() {
		openPakEdit();
	});
	
	
	//关闭按钮
	$('#close').on('click',function(){
		top.closeTab(hrefTools.getLocationParam('cxdh'));
	});
	
	//定义一个刷新列表的方法，方便子iframe页面刷新父页面列表
	window.refreshPakList = function(){
		paging.reload();
	}
	window.reQueryPakList = function(){
		queryPakList();
	}
	
	function queryPakList(){
		if(form.verifyForm(mainPakEditForm)){//form.verifyForm返回ture表示表单验证成功
		var params = {};
		params.ssdw = $('#hidden-pak-glbm').val();
		params.cdfl = $('#pak-cdfl').val();
		params.cdlx = $('#pak-cdlx').val();
		params.cddz = $('#pak-cddz').val();
		
		//初始化
		paging.init({
			url: 'pak.do?method=selectListPagePak', //地址
			elem: '#content', //内容容器
			params: params, //发送到服务端的参数
			type: 'POST',
			tempElem: '#tpl', //模块容器
			pageConfig: { //分页参数配置
				elem: '#paged', //分页容器
				pageSize: 10 //分页大小
			},
			success: function() { //渲染成功的回调
				//alert('渲染成功');
			},
			fail: function(msg) { //获取数据失败的回调
				//alert('获取数据失败')
			},
			complate: function() { //完成的回调
				//alert('处理完成');
				//重新渲染复选框
				form.render('checkbox');
				
				//绑定窗口调整事件
				$(window).off('resize',domTools.resizeTableHeight).on('resize', domTools.resizeTableHeight).resize();
				
				
				$('#content').children('tr').each(function() {
					var $that = $(this);
					
					//绑定所有删除按钮事件
					$that.children('td:last-child').children('a[data-opt=del]').on('click', function() {
						delPak($(this).data('cdbh'));
					});
					//绑定所有编辑按钮事件
					$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
						openPakEdit($(this).data('cdbh'));
					});
				});
				$('#content').children('tr').on('dblclick',function(){
					if(!$(this).data('cdbh')){
						//error
						return;
					}
					openPakEdit($(this).data('cdbh'));
				});
			}
		});
		}
	}

	function openPakEdit(cdbh){
		var condition = (!cdbh)?'':'&cdbh='+cdbh;
		layer.open({
			type: 2,
			id:'PakEdit',
			content:['pak.do?method=forwardPakEditPage'+condition],
			title: '停车场信息编辑', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			offset: ['30px', '15%'],
			area: ['800px', '410px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0 	//['新增','保存', '取消']
		});
	}
	
	function delPak(cdbh){
		layer.confirm('确认要删除这条信息吗？', {icon: 3, title:'提示'}, function(index){
			$.getJSON('pak.do',{method:'processingPak',cdbh:cdbh,gnid:'02090303',cxid:hrefTools.getLocationParam('cxdh')},function(rlt){
				paging.reload();
			});
			layer.close(index);
		});
	}
});