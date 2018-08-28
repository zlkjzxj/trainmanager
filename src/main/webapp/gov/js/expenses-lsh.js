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
	
	//重置按钮
	$('#reset').on('click',function(){
		$('#lsh').val('');
	});
	
	$(function (){
		var params = {}
	    params.glbm=$('#curr-user-glbm').val();
		getFlowlist(params);
		
	})
	//禁止回车事件
	$('#mainVehEditForm').on('submit',function(ev){
		ev.stopPropagation();
		ev.preventDefault();
	});
  
  //页面局部查询
 /*$('#query').on('click',function(){
	  var params = {}
	  params.lsh=$('#lsh').val();
	  getFlowlist(params);
  });*/
  
  function getFlowlist(param){
	  paging.init({
			url:'exp.do?method=getFlowLshListPag', //地址
			elem: '#content', //内容容器
			params: param, //发送到服务端的参数
			type: 'POST',
			tempElem: '#tpl', //模块容器
			pageConfig: { //分页参数配置
				elem: '#paged', //分页容器
				pageSize: 10//分页大小
			},
			complate: function() { //完成的回调
				$(window).off('resize',domTools.resizeTableHeight).on('resize', domTools.resizeTableHeight).resize();
				$('#content').children('tr').each(function() {
					var $that = $(this);
					//绑定所有选择按钮事件
					$that.children('td:last-child').children('a[data-opt=edit2]').on('click', function() {
						parent.setZs($(this).data('lsh'),$(this).data('hpzl'),$(this).data('hphm'));
						var index = parent.layer.getFrameIndex(window.name); 
	 					parent.layer.close(index);
					});
				});
				  //绑定双击事件
				$('#content').children('tr').on('dblclick',function() {
					parent.setZs($(this).data('lsh'),$(this).data('hpzl'),$(this).data('hphm'));
					var index = parent.layer.getFrameIndex(window.name); 
 					parent.layer.close(index);
				});
			}
		});
  }
});
