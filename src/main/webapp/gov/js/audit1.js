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
	$('#flow-glbm').on('click',function(){
		glbmSelectByZTree.show($('#flow-glbm'),function(event, treeId, treeNode){
			$('#flow-glbm').val(treeNode.name);
			$('#hidden-flow-glbm').val(treeNode.tags.glbm);
		});
	});
	//业务类型下拉框事件
	ajaxTools.loadCodeDataKK($('#flow-ywlx'),{dmmc:'ywlx'},false,'','code.do?method=selectListCode','请选择业务类型');
	form.render('select')
	
	//查询按钮
	$('#query').on('click',function(){
		queryFlowList();
	});
	
	
	//重置按钮
	$('#reset').on('click',function(){
		$('#flow-glbm').val('');
		$('#hidden-flow-glbm').val('');
		$('#flow-ywlx').val('');
		form.render('select')
	});
	
	
	//关闭按钮
	$('#close').on('click',function(){
		top.closeTab(hrefTools.getLocationParam('cxdh'));
	});
	
	//定义一个刷新列表的方法，方便子iframe页面刷新父页面列表
	window.refreshFlowList = function(){
		paging.reload();
	}
	window.reQueryflowList = function(){
		queryFlowList();
	}
	
	function queryFlowList(){
		$('#hidden-flow-ywlx').val($('#flow-ywlx').val());
		if(form.verifyForm(mainflowEditForm)){//form.verifyForm返回ture表示表单验证成功
		var params = {};
		params.sqbm = $('#curr-user-glbm').val();
		params.ywlx = $('#flow-ywlx').val();
		params.bhxj = '0';
		params.ywgw = '1';
		params.lszt = '1';
		
		//初始化
		paging.init({
			url: 'flow.do?method=selectListPageFlow', //地址
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
						delflow($(this).data('lsh'));
					});
					//绑定所有编辑按钮事件
					$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
						openFlowEdit($(this).data('ywlx'),$(this).data('lsh'));
					});
				});
				$('#content').children('tr').on('dblclick',function(){
					if(!$(this).data('lsh')){
						//error
						return;
					}
					openFlowEdit($(this).data('ywlx'),$(this).data('lsh'));
				});
			}
		});
		}
	}

	function openFlowEdit(ywlx,lsh){
		var condition = (!lsh)?'':'&lsh='+lsh;
		var condition1 = (!ywlx)?'':'&ywlx='+ywlx;
		layer.open({
			type: 2,
			id:'flowEdit',
			content:['flow.do?method=forwardFlowEditPage&ymmc=audit1_edit'+condition+condition1],
			title: '业务审批', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			offset: ['30px', '15%'],
			area: ['1000px', '535px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0 	//['新增','保存', '取消']
		});
	}
});