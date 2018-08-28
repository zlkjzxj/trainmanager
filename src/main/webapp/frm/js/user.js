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
	window.refreshUserList = function(){
		paging.reload();
	}
	window.reQueryUserList = function(){
		queryuserList();
	}
	
	
	//初始换管理部门下拉选择框
	var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['300px','300px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
	//管理部门选择下拉框事件
	$('#us-glbm').on('click',function(){
		glbmSelectByZTree.show($('#us-glbm'),function(event, treeId, treeNode){
			$('#us-glbm').val(treeNode.name);
			$('#hidden-us-glbm').val(treeNode.tags.glbm);
		});
	});
	
	//查询按钮
	$('#query').on('click',function(){
		queryuserList();
	});
	
	
	//重置按钮
	$('#reset').on('click',function(){
		$('#us-glbm').val($('#curr-user-bmjc').val());
		$('#hidden-us-glbm').val($('#curr-user-glbm').val());
		$('#us-bhxj')[0].checked = false;
		$('#us-xm').val('');
		$('#us-sfgly')[0].checked = false;
		form.render('checkbox');
	});
	
	
	//新增按钮
	$('#add').on('click', function() {
		openUserEdit();
	});
	
	
	//关闭按钮
	$('#close').on('click',function(){
		top.closeTab(hrefTools.getLocationParam('cxdh'));
	});
	
	
	function queryuserList(){
		var params = {};
		params.glbm = $('#hidden-us-glbm').val();
		params.bhxj = $('#us-bhxj')[0].checked?'1':'0';
		params.xm = $('#us-xm').val();
		params.sfgly = $('#us-sfgly')[0].checked?'1':'0';
		
		//初始化
		paging.init({
			url: 'user.do?method=selectListPageUser', //地址
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
					
					//绑定所有重置密码按钮事件
					$that.children('td:last-child').children('a[data-opt=resetmm]').on('click', function() {
						resetUserPwd($(this).data('yhdh'));
					});
					
					//绑定所有编辑按钮事件
					$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
						openUserEdit($(this).data('yhdh'));
					});
					
					//绑定所有删除按钮事件
					$that.children('td:last-child').children('a[data-opt=del]').on('click', function() {
						delUser($(this).data('yhdh'));
					});
				});
				
				$('#content').children('tr').on('dblclick',function(){
					if(!$(this).data('yhdh')){
						//error
						return;
					}
					openUserEdit($(this).data('yhdh'));
				});
			}
		});
	}
	

	function resetUserPwd(yhdh){
		layer.confirm('确认要重置用户密码吗？', {icon: 3, title:'提示'}, function(index){
			$.getJSON('user.do',{method:'processingUser',yhdh:yhdh,gnid:'01010304',cxid:hrefTools.getLocationParam('cxdh')},function(rlt){
				if(rlt.code=='1'){
					layer.msg(rlt.mess, {icon: 6});
				}else{
					layer.msg(rlt.mess, {icon: 5});
				}
			});
			layer.close(index);
		});
	}
	
	
	function openUserEdit(yhdh){
		var condition = (!yhdh)?'':'&yhdh='+yhdh;
		condition += '&t='+new Date().getTime();
		layer.open({
			type: 2,
			id:'UserEdit',
			content:['user.do?method=forwardUserEditPage'+condition],
			title: '用户编辑', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			offset: ['30px', '25%'],
			area: ['800px', '500px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0 	//['新增','保存', '取消']
			/*yes: function(index,layero) {
				console.log('yes');
				console.log(index);
				console.log(layero);
			},
			btn2: function(index,layero){
				console.log('btn2');
				console.log(index);
				console.log(layero);
			},*/
			/*full: function(elem) {
				var win = window.top === window.self ? window : parent.window;
				$(win).on('resize', function() {
					var $this = $(this);
					elem.width($this.width()).height($this.height()).css({
						top: 0,
						left: 0
					});
					elem.children('div.layui-layer-content').height($this.height() - 95);
				});
			},*/
			/*success: function(layero, index) {
				console.log('success');
				console.log(index);
				console.log(layero);
			},*/
			/*end: function() {
				console.log('end');
			}*/
		});
	}
	
	
	function delUser(yhdh){
		layer.confirm('确认要删除用户“'+yhdh+'”吗？', {icon: 3, title:'提示'}, function(index){
			$.getJSON('user.do',{method:'processingUser',yhdh:yhdh,gnid:'01010303',cxid:hrefTools.getLocationParam('cxdh')},function(rlt){
				paging.reload();
			});
			layer.close(index);
		});
	}
});
