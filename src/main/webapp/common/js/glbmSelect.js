var _o;
layui.define(['jquery','layer','tree'],function(exports){
  "use strict";
  
  var win = window
  	  ,$ = layui.jquery;
  
  var config =  {
	url:'dep.do',
	method:'getDeparmentTreeJson',
	bgColor:'white',
	area:['300px','300px'],
	shade:0,
	shadeClose:true,
	click:function(node){
		writeMsg('请传入click事件');
		return;
	}
  };
  
  win.glbmSelect = function(options){
	  options = options || {};
	  createGlbmSelect(options);
	  return glbmSelect;
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
  
  glbmSelect.show = function(elem,clickEvt_,currSelectedNodeGlbm){
	  if(!elem) {
		  writeMsg('elem参数不可为空，请传一个对象');
		  return;
	  }
	  
	  if(!glbmData){
		  writeMsg('glbmData为空，无法显示');
		  return;
	  }
	  
	  var layerFlag = $(elem).attr('id') || $(elem).attr('name');
	  if($layerHistory.layerFlag){
		  layer.close($layerHistory.layerFlag);
		  $layerHistory.layerFlag = false;
		  return;
	  }
	  
	  var $layerid = "DepLayer"+new Date().getTime();
	  var $treedivid = "DepDivTree"+new Date().getTime();
	  var $treeid = "DepTree"+new Date().getTime();
	  var $tree = '<div id="'+$treedivid+'"><ul id="'+$treeid+'"></ul><div>';
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
				
				//通过遍历得出上级部门，牺牲丁点性能，少传个参数
				/*var currSelectedNodeSjbm;
				if(currSelectedNodeGlbm){
					_o = glbmData;
					
					var roop1 = function(childrenElems,currGlbm){
						if(!childrenElems.length){
							childrenElems = [childrenElems];
						}
					    for(var i in childrenElems){
					       if(childrenElems[i].tags.glbm==currGlbm){
					           return true;
					       }
					    }
					    return false;
					}
					,roop2 = function(elem,currGlbm){
						if(!elem.length){
							elem = [elem];
						}
						for(var i in elem){
							if(elem[i].children){
								if(roop1(elem[i].children,currGlbm)){
									return elem[i].tags.glbm;
								}else{
									var rlt = roop2(elem[i].children,currGlbm);
									if(rlt!='not found'){
										return rlt;
									}
								}
							}
						}
						return 'not found';
					};
					
					currSelectedNodeSjbm = roop2(glbmData,currSelectedNodeGlbm);
				}

				if(!currSelectedNodeSjbm||currSelectedNodeSjbm=='not found'){
					currSelectedNodeSjbm = '';
				}*/
				
				layui.tree({
				  elem: '#'+$treeid
				  ,nodes: [glbmData]
				  ,click:function(node){
					  clickEvt(node);
					  glbmSelect.hide(elem);
				  }
				  ,currSelectedNodeGlbm:currSelectedNodeGlbm
				});
				
				$('#'+$treedivid).css({'height':'100%','overflow':'hidden'});
				$('#'+$treeid).css({'height':'100%','overflow':'auto','width':(parseInt($('#'+$treeid).css('width'))+18)+'px'});
				
				//模拟点击，展开至当前选中树
				var cli = $('#'+$treeid).find('li.my-tree-node-clicked');
				if(cli&&cli.length>0){
					var lis = cli.parentsUntil($('#'+$treeid),'li');
					lis.children('i.layui-tree-spread').click();
					
					//滚动至选中元素
					//console.log($('#'+$treeid)[0].scrollTop);
					//console.log(cli.offset().top);
					var tp = parseInt(cli.offset().top);
					//$('#'+$treeid)[0].scrollTop = (tp>90)?(tp-90):tp;
					$('#'+$treeid).animate({
						scrollTop:(tp>90)?(tp-90):tp
				    },500);
					//console.log($treeid);
				}
	
				
				if(options.padding){
					$('#'+$layerid).css({'padding':options.padding});
					if(parseInt(options.padding)==0){
						$('#'+$treeid).css({'width':(parseInt($('#'+$treeid).css('width'))+18)+'px'});
					}
				}
				
				var mouseleaveEvt = function(){
					glbmSelect.hide(elem);
				}
				$('#'+$treedivid).off('mouseleave',mouseleaveEvt).on('mouseleave',mouseleaveEvt);
				
				$layerHistory.layerFlag = true;
			}
	  });
	  if($layerHistory.layerFlag){
		  $layerHistory.layerFlag = treeLayer;
	  }else{
		  layer.close(treeLayer);
	  }
  }
  
  glbmSelect.hide = function(elem){
	  var layerFlag = $(elem).attr('id') || $(elem).attr('name');
	  if($layerHistory.layerFlag){
		  layer.close($layerHistory.layerFlag);
		  $layerHistory.layerFlag = false;
		  return;
	  }
  }
  
  exports('glbmSelect', glbmSelect);
});
