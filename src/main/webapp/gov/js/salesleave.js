layui.config({
	base: '',
	version: new Date().getTime()
}).extend({
	paging:'frm/js/paging',
	glbmSelect:'common/js/glbmSelect',
	hrefTools:'common/js/hrefTools',
	ajaxTools:'common/js/ajaxTools',
	domTools:'common/js/domTools'
}).use(['element','laydate','paging','form','tree','glbmSelect','hrefTools','ajaxTools','domTools'], function() {
	var $ = layui.jquery,
		paging = layui.paging(),
		layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
		layer = layui.layer, //获取当前窗口的layer对象
		form = layui.form(),
		hrefTools = layui.hrefTools,
		domTools = layui.domTools,
		ajaxTools = layui.ajaxTools;
	
	
	//查询按钮
	$('#query').on('click',function(){
		queryFlowList();
	});
	
	
	//重置按钮
	$('#reset').on('click',function(){
		$('#dis-sqrq').val('');
		$('#lsh').val('');
	});
	
	
	//关闭按钮
	$('#close').on('click',function(){
		top.closeTab(hrefTools.getLocationParam('cxdh'));
	});
	
	//定义一个刷新列表的方法，方便子iframe页面刷新父页面列表
	window.refreshFlowList = function(){
		paging.reload();
	}
	
	function queryFlowList(){
		var params = {};
		params.sqbm = $('#curr-user-glbm').val();
		params.ywlx = 'C';
		params.ywgw = '6';
		params.sqrq = $('#dis-sqrq').val();
		params.bhxj = '0';
		params.lszt = '1';
		params.lsh = $('#lsh').val();
		
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
					
					//编辑按钮事件
					$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
						openFlowEdit($(this).data('lsh'));
					});
					
				});
				$('#content').children('tr').on('dblclick',function(){
					if(!$(this).data('lsh')){
						//error
						return;
					}
					openFlowEdit($(this).data('lsh'));
				});
			}
		});
	}
	
	function openFlowEdit(lsh){
		var condition = (!lsh)?'':'&lsh='+lsh;
		layer.open({
			type: 2,
			id:'flowEdit',
			content:['flow.do?method=forwardFlowEditPage&ymmc=salesleave_edit'+condition],
			title: '请假休假信息', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			offset: ['5px', '100px'],
			area: ['1000px', '435px'],
			zIndex: 999,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0 	//['新增','保存', '取消']
		});
	}
});