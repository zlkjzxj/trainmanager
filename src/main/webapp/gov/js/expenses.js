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
	window.refreshExpensesList = function(){
		paging.reload();
	}
	window.reQueryExpensesList = function(){
		queryExpensesList();
	}
	//流水号选择定义的方法
	window.setZs=function(zs1,zs2,zs3){
	  $('#ince-lsh').val(zs1);
	//绑定select事件
		if(zs3!=null&&zs3!=""){
			var hp = zs3.substr(0, 2);
			var hm = zs3.substring(2);
			$('#ince-bdfzjg').val(hp);
			$('#ince-hphm').val(hm);
		}else{
			$('#ince-hphm').val('');
		}
	  $('#hpzl').val(zs2);
	  form.render('select')
	  form.render('checkbox');
	}
	//选择流水号页面跳转
	$("#lsh-select").click(function(){
		layer.open({
			type: 2,
			id:'UserEdit',
			content:['exp.do?method=getExpensesydj'],
			title: '流水号信息列表', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			offset: ['30px', '10%'],
			area: ['1000px', '550px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0 	//['新增','保存', '取消']
		});
	});
	//号牌种类选择下拉框事件
	ajaxTools.loadCodeDataKK($('#hpzl'),{dmmc:'hpzl'},false,($('#ince-hpzl').data('value')||''),'code.do?method=selectListCode','请选择号牌种类');
	form.render('select')
	//关闭按钮
	$('#close').on('click',function(){
		top.closeTab(hrefTools.getLocationParam('cxdh'));
	});
	//重置按钮
	$('#reset').on('click',function(){
		$('#ince-lsh').val('');
		$('#hidden-ince-glbm').val('');
		$('#ince-hphm').val('');
		$('#hpzl').val('')
		form.render('select')
		$('#lsh').val('')
		form.render('select')
		form.render('checkbox');
	});
	//查询按钮
	$('#query').on('click',function(){
		queryExpensesList();
	});
	//新增按钮
	$('#add').on('click', function() {
		openexpensesEdit();
	});
	//分页查询
	function queryExpensesList(){
		var params = {};
		    params.lsh=$('#ince-lsh').val();
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
			url:'exp.do?method=govVehexpEnsesListPage', //地址
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
				//绑定窗口调整事件
				$(window).off('resize',domTools.resizeTableHeight).on('resize', domTools.resizeTableHeight).resize();
				$('#content').children('tr').each(function() {
					var $that = $(this);
					//绑定所有编辑按钮事件
					$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
						openexpensesEdit($(this).data('lsh'),$(this).data('fylx'));
					});
				});
				  //绑定双击事件
				$('#content').children('tr').on('dblclick',function() {
					if(!$(this).data('fylx')&&!$(this).data('lsh')){
						//error
						return;
					}
					openexpensesEdit($(this).data('lsh'),$(this).data('fylx'));
				});
			}
		});
	}
	//页面跳转(费用信息编辑）
	function openexpensesEdit(lsh,fylx){
		var condhlsh= (!lsh)?'':'&lsh='+lsh;
		var condhhphm=(!fylx)?'':'&fylx='+fylx;
		layer.open({
			type: 2,
			id:'UserEdit',
			content:['exp.do?method=getExpenses'+condhlsh+condhhphm],
			title: '费用信息编辑', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			offset: '100px',
			area: ['1100px', '550px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0 	//['新增','保存', '取消']
		});
	}
});