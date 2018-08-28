layui.config({
	base: '',
	version: new Date().getTime()
	
}).extend({
	paging:'frm/js/paging',
	glbmSelectByZTree:'common/js/glbmSelectByZTree',
	hrefTools:'common/js/hrefTools',
	domTools:'common/js/domTools'
		
}).use(['element','laydate','paging','form','tree','glbmSelectByZTree','hrefTools','domTools'], function() {
	var $ = layui.jquery,
		element = layui.element(),
		paging = layui.paging(),
		layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
		layer = layui.layer, //获取当前窗口的layer对象
		form = layui.form(),
		hrefTools = layui.hrefTools,
		domTools = layui.domTools;
	
	
	//定义一个刷新列表的方法，方便子iframe页面刷新父页面列表
	window.refreshRoleList = function(){
		paging.reload();
	}
	window.reQueryRoleList = function(){
		queryRoleList();
	}
	
	
	//初始换管理部门下拉选择框
//	var glbmSelect = layui.glbmSelect({bgColor:'#F9FAFC',area:['200px','100px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
	var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['300px','300px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
	//管理部门选择下拉框事件
	$('#rs-qxcjbm').on('click',function(){
		glbmSelectByZTree.show($('#rs-qxcjbm'),function(event, treeId, treeNode){
			$('#rs-qxcjbm').val(treeNode.name);
			$('#hidden-rs-qxcjbm').val(treeNode.tags.glbm);
		});
	});
	
	//查询按钮
	$('#query').on('click',function(){
		queryRoleList();
	});
	
	
	//重置按钮
	$('#reset').on('click',function(){
		$('#rs-qxcjbm').val("");
		$('#hidden-rs-qxcjbm').val("");
		$('#rs-qxgroupmc').val('');
		$('#rs-sfgly')[0].checked = false;
		form.render('checkbox');
	});
	
	
	//新增按钮
	$('#add').on('click', function() {
		openRoleEdit();
	});
	
	
	//关闭按钮
	$('#close').on('click',function(){
		top.closeTab(hrefTools.getLocationParam('cxdh'));
	});
	
	
	function queryRoleList(){
		var params = {};
		params.qxcjbm = $('#hidden-rs-qxcjbm').val();
		params.qxgroupmc = $('#rs-qxgroupmc').val();
		params.sfgly = $('#rs-sfgly')[0].checked?'1':'0';
		params.qxsyjb = $('#curr-user-bmjb').val();
		
		//初始化
		paging.init({
			url: 'role.do?method=selectRoleList', //地址
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
				
				//绑定窗口调整事件
				$(window).off('resize',domTools.resizeTableHeight).on('resize', domTools.resizeTableHeight).resize();
				
				
				$('#content').children('tr').each(function() {
					var $that = $(this);
					
					//绑定所有编辑按钮事件
					$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
						openRoleEdit($(this).data('qxgroup'));
					});
				});
				
				$('#content').children('tr').on('dblclick',function(){
					if(!$(this).data('qxgroup')){
						//error
						return;
					}
					openRoleEdit($(this).data('qxgroup'));
				});
			}
		});
	}
	

	function openRoleEdit(qxgroup){
		var condition = (!qxgroup)?'':'&qxgroup='+qxgroup;
		condition += '&t='+new Date().getTime();
		layer.open({
			type: 2,
			id:'RoleEdit',
			content:'role.do?method=forwardRoleEditPage'+condition,
			title: '角色编辑', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			offset: ['30px', '25%'],
			area: ['800px', '500px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0
		});
	}
	
});
