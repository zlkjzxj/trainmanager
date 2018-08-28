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
	hrefTools= layui.hrefTools,
	ajaxTools=layui.ajaxTools,
	domTools=layui.domTools;
	
	//定义一个刷新列表的方法，方便子iframe页面刷新父页面列表
	window.refreshShopList = function(){
		paging.reload();
	}
	window.reQueryShopList = function(){
		queryshopList();
	}
	
	//单位类型选择下拉框事件
	ajaxTools.loadCodeDataDWX($('#Dwlx'),{dmmc:'dwlx'},false,($('#Dwlx').data('value')||''),'repairShop.do?method=selectListRepairShop','请选择单位类型');
	form.render('select');
	
	//关闭按钮
	$('#closeym').on('click',function(){
		top.closeTab(hrefTools.getLocationParam('cxdh'));
	});
	
	//重置按钮
	$('#reset').click(function(){

		//$('#repair-dwlx').ch
		$('#dwmc').val('');
		$('#Dwlx').val('');
		form.render('select')
	});
	
	//查询按钮
	$('#query').on('click',function(){
		queryshopList();
	});
	
	//新增按钮
	$('#add').on('click', function() {
		openshopEdit();
	});
	
	function queryshopList(){
		var params = {};
		params.dwlx=$('#Dwlx option:selected').val();
		params.dwmc= $('#dwmc').val();
		
		//初始化
		paging.init({
			url:'repairShop.do?method=selectPateRepairShop', //地址
			elem: '#content', //内容容器
			params: params, //发送到服务端的参数
			type: 'POST',
			tempElem: '#tpl', //模块容器
			pageConfig: { //分页参数配置
				elem: '#paged', //分页容器
				pageSize: 10//分页大小
			},
			success: function() { //渲染成功的回调
				//alert('渲染成功');
			},
			fail: function(msg) { //获取数据失败的回调
				layer.open({
		    		   title: '友情提示'
		    		  ,content: '获取数据失败！'
		    		});   
			},
			complate: function() { //完成的回调
				//alert('处理完成');
				
				//绑定窗口调整事件
				$(window).off('resize',domTools.resizeTableHeight).on('resize', domTools.resizeTableHeight).resize();
				
				
				
				$('#content').children('tr').each(function() {
					var $that = $(this);
					
					//绑定所有编辑按钮事件
					$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
						openshopEdit($(this).data('dwbh'));
					});
					
					//绑定所有删除按钮事件
					$that.children('td:last-child').children('a[data-opt=del]').on('click', function() {
						delShop($(this).data('dwbh'),$(this).data('dwmc'));
					});
					
				});
				
				$('#content').children('tr').on('dblclick',function() {
					if(!$(this).data('dwbh')){
						//error
						return;
					}
					openshopEdit($(this).data('dwbh'));
				});
				
			}
		});
	}
	function openshopEdit(dwbh){
		var condition = (!dwbh)?'':'&dwbh='+dwbh;

		layer.open({
			type: 2,
			id:'UserEdit',
			content:['repairShop.do?method=forwardShopEditPage'+condition],
			title: '单位信息编辑', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			offset: ['30px', '25%'],
			area: ['800px', '380px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0 	//['新增','保存', '取消']
		
		});
	}
	
	function delShop(dwbh,dwmc){
		layer.confirm('确认要删除单位“'+dwmc+'”吗？', {icon: 3, title:'提示'}, function(index){
			var glbm=$('#curr-dep-glbm').val();
			var jbr=$('#curr-user-xm').val();
			var gnid='02090503';
			var cxdh='020905';
			$.ajax({
				type:'post',
				url: 'repairShop.do?method=processingRepairShop&gnid='+gnid+'&cxdh='+cxdh,
				data:{'dwbh':dwbh,'jbr':jbr,'glbm':glbm},
				dataType: 'json',
				success: function(result) {
					
					paging.reload();
				},
				error: function() {
				
				}
			});
			layer.close(index);
		});
	}
	
});