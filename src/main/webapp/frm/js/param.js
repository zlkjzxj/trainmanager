layui.config({
	base: '',
	version: new Date().getTime()
	
}).extend({
	paging:'frm/js/paging',
	domTools:'common/js/domTools',
	ajaxTools:'common/js/ajaxTools',
	hrefTools:'common/js/hrefTools',
	jqueryform:	'common/js/jquery.form',
	ztree:'common/js/zTree_v3-master/js/jquery.ztree.core'
		
}).use(['element','laydate','paging','form','tree','domTools','ajaxTools','hrefTools','jqueryform','ztree'], function() {
	var $ = layui.jquery,
		element = layui.element(),
		paging = layui.paging(),
		layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
		layer = layui.layer, //获取当前窗口的layer对象
		form = layui.form(),
		domTools = layui.domTools,
		ajaxTools = layui.ajaxTools,
		hrefTools = layui.hrefTools;
	
	
	window.refreshParamList = function(){
		var index = $('#paramQuery div.layui-tab>ul.layui-tab-title li.layui-this').index();
		queryParamList(index,$('#hidden-ps-glbm').val());
	}
	
	
	var currGlbm = $('#curr-user-glbm').val()
		,currBmjb = $('#curr-user-bmjb').val();
	if(currGlbm){
		queryTree();
	}else{
		domTools.printMsgToConsole('error','当前用户管理部门错误');
	}
	
	form.render();
	
	queryParamList('0',currGlbm);//默认查系统参数
	
	element.on('tab(ParamTab)',function(data){
		queryParamList(data.index,currGlbm);
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
				rootBmdm:currGlbm
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
		$('#depTree').html('');
		if(data){
			var ztreeObj = $.fn.zTree.init($("#depTree"), {
				callback: {
					onClick: function(event, treeId, treeNode){
						$('#hidden-ps-glbm').val(treeNode.tags.glbm);
						$('#hidden-ps-bmjc').val(treeNode.name);
						
						var index = $('#paramQuery div.layui-tab>ul.layui-tab-title li.layui-this').index();
						queryParamList(index,treeNode.tags.glbm);
					}
				}
			}, [data]);
			
		}else{
			domTools.printMsgToConsole('error','数据查询错误');
		}
	}
	
	function renderTree_bak(data){
		$('#depTree').html('');
		if(data){
			layui.tree({
				elem: '#depTree'
				,nodes: [data]
				,click:function(node){
					$('#hidden-ps-glbm').val(node.tags.glbm);
					$('#hidden-ps-bmjc').val(node.name);
					
					var index = $('#paramQuery div.layui-tab>ul.layui-tab-title li.layui-this').index();
					queryParamList(index,node.tags.glbm);
				}
			});
		}else{
			domTools.printMsgToConsole('error','数据查询错误');
		}
	}
	
	function queryParamList(index,glbm){
		var cslx = index=='0'?'1':index=='1'?'2':'-1'
			,contentElem = index=='0'?'#content1':index=='1'?'#content2':'#content-1'
			,pageElem = index=='0'?'#paged1':index=='1'?'#paged2':'#paged-1';
		
		var params = {};
		params.glbm = glbm;
		params.bmjb = currBmjb;
		params.cslx = cslx;
		params.cssx = '2';
		
		//初始化
		paging.init({
			url: 'param.do?method=selectListPageParam&t='+new Date().getTime(), //地址
			elem: contentElem, //内容容器
			params: params, //发送到服务端的参数
			type: 'POST',
			tempElem: '#tpl', //模块容器
			pageConfig: { //分页参数配置
				elem: pageElem, //分页容器
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
				$(window).off('resize',resizeTableHeight).on('resize', resizeTableHeight).resize();
				
				$(contentElem).children('tr').on('dblclick',function(){
					if(!$(this).data('gjz')){
						//error
						return;
					}
					if(!$(this).data('xtlb')){
						//error
						return;
					}
					openParamEdit($(this).data('gjz'),$(this).data('xtlb'));
				});
				
				$(contentElem).children('tr').each(function(){
					var $that = $(this);
					
					//绑定所有编辑按钮事件
					$that.children('td:last-child').children('a[data-opt=edit]').on('click', function() {
						if(!$(this).data('gjz')){
							//error
							return;
						}
						if(!$(this).data('xtlb')){
							//error
							return;
						}
						openParamEdit($(this).data('gjz'),$(this).data('xtlb'));
					});
				});
			}
		});
	}
	
	function openParamEdit(gjz,xtlb){
		var condition = (!gjz)?'':'&gjz='+gjz;
		condition += (!xtlb)?'':'&xtlb='+xtlb;
		var glbm = $('#hidden-ps-glbm').val();
		condition += (!glbm)?'':'&glbm='+glbm;
		condition += '&t='+new Date().getTime();
		layer.open({
			type: 2,
			id:'ParamEdit',
			content:'param.do?method=forwardParamEditPage'+condition,
			title: '参数编辑',
			shade: 0.2,
			offset: ['30px', '25%'],
			area: ['600px', '500px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0
		});
	}
	
	var resizeTimer;
	function resizeTableHeight(){
		if (resizeTimer) clearTimeout(resizeTimer);
		resizeTimer = setTimeout(function(){
			var index = $('#paramQuery div.layui-tab>ul.layui-tab-title li.layui-this').index();
			var contentDiv = index=='0'?'#contentDiv1':index=='1'?'#contentDiv2':'#contentDiv-1'
				,tbodyTable = index=='0'?'#tbodyTable1':index=='1'?'#tbodyTable2':'#tbodyTable-1'
				,theadTable = index=='0'?'#theadTable1':index=='1'?'#theadTable2':'#theadTable-1';
				
			
			if(
				(($(window).height()-100)<$(contentDiv).height())
				||
				(($(window).height()-100)<($(tbodyTable).height()+50))
				||
				($(contentDiv).height()<$(tbodyTable).height())
			){
				$(contentDiv).css('overflow','auto').height($(window).height()-140);
			}
			if($(contentDiv).height()<$(tbodyTable).height()){
				$('#theadTable').width($(window).width()-12-($(contentDiv).width()-$(tbodyTable).width()));
			}else{
				$(theadTable).width($(theadTable).parent().width());
			}
		} , 100);
	}
});
