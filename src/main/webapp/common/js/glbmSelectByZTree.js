var _o;
var timeOutCount = 0;
layui.extend({ztree:'common/js/zTree_v3-master/js/jquery.ztree.core'}).define(['jquery','layer','ztree'],function(exports){
  "use strict";
  
  var win = window
  	  ,$ = layui.jquery;
  
  var config =  {
	url:'dep.do',
	method:'getDeparmentTreeJson',
	bgColor:'white',
	area:['300px','300px'],
	shade:0.01,
	shadeClose:true,
	click:function(node){
		writeMsg('请传入click事件');
		return;
	}
  };
  
  win.glbmSelectByZTree = function(options){
	  options = options || {};
	  createGlbmSelect(options);
	  return glbmSelectByZTree;
  }
  
  var glbmData,options
  	  ,$layerHistory = [];
  
  var createGlbmSelect = function(options_){
	  options = options_;
	  
	  var data = options.data;
	  if(!data){
		  writeMsg('data参数不可为空，请传入查询参数');
		  return;
	  }
	  if(!data.rootBmdm){
		  writeMsg('data参数中缺失rootBmdm参数，请传入部门根节点');
		  return;
	  }
	  
	  $.ajax({
			url:(options.url || config.url) + '?method=' + (options.method || config.method),
			dataType:'json',
			type:'POST',
			data:data,
			success:function(data){
				glbmData = data;
			},
			error:function(xhr,mess,e){
				writeMsg('Ajax查询部门json字符串发生错误');
			}
	  });
  }
  
  var writeMsg = function(msg){
	  try {
		  console.error('创建管理部门下拉选择框发生错误:'+msg);
	  } catch (e) { }
  }
  
  glbmSelectByZTree.show = function(elem,clickEvt_,currSelectedNodeGlbm){
	  if(!elem) {
		  writeMsg('elem参数不可为空，请传一个对象');
		  return;
	  }
	  
	  /*if(!glbmData){
		  writeMsg('glbmData为空，无法显示');
		  return;
	  }*/
	  
	  var layerFlag = $(elem).attr('id') || $(elem).attr('name');
	  if($layerHistory.layerFlag){
		  layer.close($layerHistory.layerFlag);
		  $layerHistory.layerFlag = false;
		  return;
	  }
	  
	  var $layerid = "DepLayer"+new Date().getTime();
	  var $treedivid = "DepDivTree"+new Date().getTime();
	  var $treeid = "DepTree"+new Date().getTime();
	  var $tree = '<div id="'+$treedivid+'"><ul id="'+$treeid+'" class="ztree"><li><i style="display:inline-block" class="layui-icon layui-anim layui-anim-rotate layui-anim-loop">&#xe63d;</i> 正在加载……</li></ul><div>';
	  var treeLayer = layer.open({
			type: 4,
			id:$layerid,
			tips:[3, (options.bgColor || config.bgColor)],
			title: false,
			closeBtn: 0,
			area: (options.area || config.area),
			skin: 'layui-layer-nobg',
			shade: (options.shade || config.shade),
			shadeClose: (options.shadeClose || config.shadeClose),
			content: [$tree,elem],
			success: function(){
				var clickEvt = clickEvt_;
				if(typeof clickEvt != 'function'){
					clickEvt = config.click;
				}
				
				window.waitFun = function(){
					if(!glbmData&&timeOutCount<30){
						timeOutCount++;
						setTimeout("waitFun();",500);
					}else{
						var ztreeObj = $.fn.zTree.init($("#"+$treeid), {
							callback: {
								beforeExpand : function(treeId, treeNode){
									//$.fn.zTree.getZTreeObj(treeId).expandNode($.fn.zTree.getZTreeObj(treeId).getNodes().not(treeNode),true,false);
								},
								onClick: function(event, treeId, treeNode){
									clickEvt(event, treeId, treeNode);
									glbmSelectByZTree.hide(elem);
								}
							}
						}, [glbmData]);
						
						if(currSelectedNodeGlbm){
							var ztreeCurNode = ztreeObj.getNodeByParam("name",currSelectedNodeGlbm);
							//console.log(ztreeObj.expandNode(ztreeCurNode,true,false));
							ztreeObj.selectNode(ztreeCurNode);
							
							var jCurNode = $('#'+ztreeCurNode.tId+'_span');
							var tp = parseInt(jCurNode.offset().top);
							$('#'+$treeid).animate({
								scrollTop:(tp>90)?(tp-90):tp
						    },500);
						}
					}
				}
				waitFun();
				
				$('#'+$treedivid).css({'height':'100%','overflow':'hidden'});
				$('#'+$treeid).css({'height':'100%','overflow':'auto','width':(parseInt($('#'+$treeid).css('width'))+18)+'px'});
				
				/*$.fn.zTree.init($("#"+$treeid), {
					async: {
						enable: true,
						type: "get",
						url: "dep.do?method=getDeparmentTreeJson&rootBmdm="+options.data.rootBmdm
					}
				});*/
	
				$layerHistory.layerFlag = true;
			},
			end:function(){
				$layerHistory.layerFlag = false;
			}
	  });
	  if($layerHistory.layerFlag){
		  $layerHistory.layerFlag = treeLayer;
	  }else{
		  layer.close(treeLayer);
	  }
  }
  
  glbmSelectByZTree.hide = function(elem){
	  var layerFlag = $(elem).attr('id') || $(elem).attr('name');
	  if($layerHistory.layerFlag){
		  layer.close($layerHistory.layerFlag);
		  $layerHistory.layerFlag = false;
		  return;
	  }
  }
  
  exports('glbmSelectByZTree', glbmSelectByZTree);
});
