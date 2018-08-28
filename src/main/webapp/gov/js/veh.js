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
	$('#veh-glbm').on('click',function(){
		glbmSelectByZTree.show($('#veh-glbm'),function(event, treeId, treeNode){
			$('#veh-glbm').val(treeNode.name);
			$('#hidden-veh-glbm').val(treeNode.tags.glbm);
		},$(this).val());//第三个参数传一个bmjc，打开管理部门下拉选择树后，会默认展开到该部门，并添加选中样式
	});
	//车辆类型选择下拉框事件
	ajaxTools.loadCodeDataKK($('#veh-cllx'),{dmmc:'cllx'},false,'','code.do?method=selectListCode','请选择车辆类型');
	form.render('select')
	
	//查询按钮
	$('#query').on('click',function(){
		queryVehList();
	});
	
	
	//重置按钮
	$('#reset').on('click',function(){
		$('#veh-glbm').val('');
		$('#hidden-veh-glbm').val('');
		$('#veh-cllx').val('');
		$('#veh-hphm').val('')
		form.render('select')
		form.render('checkbox');
	});
	
	
	//新增按钮
	$('#add').on('click', function() {
		openVehEdit();
	});
	
	
	//关闭按钮
	$('#close').on('click',function(){
		top.closeTab(hrefTools.getLocationParam('cxdh'));
	});
	
	//定义一个刷新列表的方法，方便子iframe页面刷新父页面列表
	window.refreshVehList = function(){
		paging.reload();
	}
	window.reQueryVehList = function(){
		queryVehList();
	}
	
	function queryVehList(){
		if(form.verifyForm(mainVehEditForm)){//form.verifyForm返回ture表示表单验证成功
		var params = {};
		params.glbm = $('#hidden-veh-glbm').val();
		params.cllx = $('#veh-cllx').val();
		var fzjg = $('#veh-bdfzjg').val();
		var hphm = $('#veh-hphm').val();
		if(hphm!=""&&hphm!=null){
			var reg = /^[A-Z_0-9]{5}$/
			if(!reg.test(hphm)){
				layer.msg("号牌号码必须为数字或数字与字母组合！", {icon: 5,shift: 6});
			}
			params.hphm = fzjg+hphm;
		}else{
			params.hphm = '';
		}
		
		//初始化
		paging.init({
			url: 'veh.do?method=selectListPageVeh', //地址
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
					
					//绑定所有编辑按钮事件
					$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
						openVehEdit($(this).data('hpzl'),$(this).data('hphm'));
					});
					
					//绑定所有删除按钮事件
					$that.children('td:last-child').children('a[data-opt=del]').on('click', function() {
						delVeh($(this).data('hpzl'),$(this).data('hphm'));
					});
				});
				$('#content').children('tr').on('dblclick',function(){
					if(!$(this).data('hpzl')&&!$(this).data('hphm')){
						//error
						return;
					}
					openVehEdit($(this).data('hpzl'),$(this).data('hphm'));
				});
			}
		});
		}
	}

	function openVehEdit(hpzl,hphm){
		var condition = (!hpzl)?'':'&hpzl='+hpzl;
		var condition1 = (!hphm)?'':'&hphm='+hphm;
		layer.open({
			type: 2,
			id:'VehEdit',
			content:['veh.do?method=forwardVehEditPage'+condition+condition1],
			title: '机动车信息编辑', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			offset: ['30px', '15%'],
			area: ['1000px', '550px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0 	//['新增','保存', '取消']
		});
	}
	
	function delVeh(hpzl,hphm){
		layer.confirm('确认要删除这条信息吗？', {icon: 3, title:'提示'}, function(index){
			$.getJSON('veh.do',{method:'processingVeh',hpzl:hpzl,hphm:hphm,gnid:'02090103',cxid:hrefTools.getLocationParam('cxdh')},function(rlt){
				paging.reload();
			});
			layer.close(index);
		});
	}
});