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
	hrefTools= layui.hrefTools,
	ajaxTools=layui.ajaxTools,
	domTools=layui.domTools;
	
	//定义一个刷新列表的方法，方便子iframe页面刷新父页面列表
	window.refreshInsuranceList = function(){
		paging.reload();
	}
	window.reQueryInsuranceList = function(){
		queryinsuranceList();
	}
	//号牌种类选择下拉框事件
	ajaxTools.loadCodeDataKK($('#hpzl'),{dmmc:'hpzl'},false,($('#ince-hpzl').data('value')||''),'code.do?method=selectListCode','请选择号牌种类');
	form.render('select')
	
	//初始换管理部门下拉选择框
	var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['300px','300px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
	
	//管理部门选择下拉框事件
	$('#ince-glbm').on('click',function(){
		glbmSelectByZTree.show($('#ince-glbm'),function(event, treeId, treeNode){
			$('#ince-glbm').val(treeNode.name);
			$('#hidden-ince-glbm').val(treeNode.tags.glbm)
	});
	});
	
	//关闭按钮
	$('#close').on('click',function(){
		top.closeTab(hrefTools.getLocationParam('cxdh'));
	});
	
	//重置按钮
	$('#reset').on('click',function(){
		$('#ince-glbm').val('');
		$('#hidden-ince-glbm').val('');
		$('#ince-hphm').val('');
		$('#hpzl').val('')
		form.render('select')
		form.render('checkbox');
	});
	
	//查询按钮
	$('#query').on('click',function(){
		queryinsuranceList();
	});
	
	//新增按钮
	$('#add').on('click', function() {
		openinsuranceEdit();
	});
	
	//分页查询
	function queryinsuranceList(){
		var params = {};
		    params.glbm=$('#hidden-ince-glbm').val();
		    params.hpzl=$('#hpzl').val();
		var fzig=$('#ince-bdfzig').val();
		var hphm =$('#ince-hphm').val();
		if(hphm!=""&&hphm!=null){
			var reg=/^[A-Z_0-9]{5}$/
		    if(!reg.test(hphm)){
		    	layer.msg("号牌号码必须为数字或数字与字母的组合！",{icon:5,shift:6});
		    }
			params.hphm=fzjg+hphm;
		}else{
			    params.hphm='';
		}
		
		//初始化
		paging.init({
			url:'insurance.do?method=selectPateInsurance', //地址
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
				layer.alert(msg.mess, {icon: 5});
			},
			complate: function() { //完成的回调
				//alert('处理完成');
				
				//绑定窗口调整事件
				$(window).off('resize',domTools.resizeTableHeight).on('resize', domTools.resizeTableHeight).resize();
				
				$('#content').children('tr').each(function() {
					var $that = $(this);
					
					//绑定所有编辑按钮事件
					$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
						openinsuranceEdit($(this).data('hphm'),$(this).data('bxdh'));
					});
					
				});
				  //绑定双击事件
				$('#content').children('tr').on('dblclick',function() {
					if(!$(this).data('hphm')&&!$(this).data('bxdh')){
						//error
						return;
					}
					openinsuranceEdit($(this).data('hphm'),$(this).data('bxdh'));
				});
			}
		});
	}
	//页面跳转
	function openinsuranceEdit(hphm,bxdh){
		var condhphm= (!hphm)?'':'&hphm='+hphm;
		var condbxdh=(!bxdh)?'':'&bxdh='+bxdh;

		layer.open({
			type: 2,
			id:'UserEdit',
			content:['insurance.do?method=forwardInsuranceEdit'+condhphm+condbxdh],
			title: '保险信息编辑', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			offset: ['30px', '15%'],
			area: ['950px', '470px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0 	//['新增','保存', '取消']
		
		});
	}
});