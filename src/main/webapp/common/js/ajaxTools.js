layui.define('jquery',function(exports){
	"use strict";
	
	var $ = layui.jquery
	
	,ajaxTools = {
		loadCodeData: function(selectObj,data,async,defaultValue,url){
			$.ajax({
				url:(url||'code.do?method=selectListCode&ttt='+new Date().getTime()),
				data:data,
				async:async,
				dataType:'json',
				success:function(rlt){
					var hstr = '';
					for(var i in rlt){
						hstr += '<option value="'+rlt[i].dm+'" '+((defaultValue&&defaultValue==rlt[i].dm)?'selected="selected"':'')+' >'+rlt[i].mc+'</option>';
					}
					$(selectObj).html(hstr);
				}
			});
		}
		,loadCodeDataKK: function(selectObj,data,async,defaultValue,url,xz){// select加载有空选项
			$.ajax({
				url:(url||'code.do?method=selectListCode&ttt='+new Date().getTime()),	//如果url为空，则默认查询code
				data:data,
				async:async,
				dataType:'json',
				success:function(rlt){
					var hstr = '<option value="">'+(xz||'')+'</option>';
					for(var i in rlt){
						hstr += '<option value="'+rlt[i].dm+'" '+((defaultValue&&defaultValue==rlt[i].dm)?'selected="selected"':'')+' >'+rlt[i].mc+'</option>';
					}
					$(selectObj).html(hstr);
				}
			});
		}
		,loadCodeForRadio: function(radioObj,radioName,data,async,defaultValue,url,layFilter){
			$.ajax({
				url:(url||'code.do?method=selectListCode&ttt='+new Date().getTime()),	//如果url为空，则默认查询code
				data:data,
				async:async,
				dataType:'json',
				success:function(rlt){
					var hstr = '';
					for(var i in rlt){
						hstr += '<input name="'+radioName+'" title="'+rlt[i].mc+'" value="'+rlt[i].dm+'" type="radio" '+((!layFilter)?'':'lay-filter="'+layFilter+'"')+' '+((defaultValue&&defaultValue==rlt[i].dm)?'checked="checked"':'')+'>';
					}
					$(radioObj).html(hstr);
				}
			});
		}
		,loadCodeForCheckbox: function(areaObj,name,data,async,defaultValue,url,laySkin,layFilter){
			$.ajax({
				url:(url||'code.do?method=selectListCode&ttt='+new Date().getTime()),	//如果url为空，则默认查询code
				data:data,
				async:async,
				dataType:'json',
				success:function(rlt){
					var ds = (defaultValue||'').split(',');
					var hstr = '';
					for(var i in rlt){
						var dstr = '';
						for(var j in ds){
							if(ds[j]&&ds[j]==rlt[i].dm){
								dstr = 'checked="checked"';
								break;
							}
						}
						hstr += '<input name="'+name+'" title="'+rlt[i].mc+'" '+((!laySkin)?'':('lay-skin="'+laySkin+'"'))+' '+((!layFilter)?'':'lay-filter="'+layFilter+'"')+' value="'+rlt[i].dm+'" type="checkbox" '+dstr+'>';
					}
					$(areaObj).html(hstr);
				}
			});
		}
		,getCodeData: function(data){
			var result = '';
			$.ajax({
				url:'code.do?method=selectListCode&ttt='+new Date().getTime(),
				data:data,
				async:false,
				dataType:'json',
				success:function(rlt){
					result = rlt;
				}
			});
			return result;
		}
		
		,loadQxgroupData: function(selectObj,data,async,defaultValue){
			$.ajax({
				url:'menu.do?method=getQxgroupList&ttt='+new Date().getTime(),
				data:data,
				async:async,
				dataType:'json',
				success:function(rlt){
					rlt = rlt.excuteObjList;
					var hstr = '';
					for(var i in rlt){
						hstr += '<option value="'+rlt[i].qxgroup+'" '+((defaultValue&&defaultValue==rlt[i].qxgroup)?'selected="selected"':'')+' >'+rlt[i].qxgroupmc+'</option>';
					}
					hstr = '<optgroup label=""></optgroup><optgroup label="自由">'+''+'<option value="@" '+((defaultValue&&defaultValue=='@')?'selected="selected"':'')+'>自由授权</option></optgroup><optgroup label="角色">' + hstr+'</optgroup>';
					$(selectObj).html(hstr);
				}
			});
		}
		
		,getUserAllMenu: function(data){
			data = data || {};
			var result = '';
			$.ajax({
				url:'menu.do?method=getAllMenu&ttt='+new Date().getTime(),
				data:data,
				async:false,
				dataType:'json',
				success:function(rlt){
					result = rlt;
				}
			});
			return result;
		}
		
		,getAllMenuStr : function(data){
			data = data || {};
			var result = '';
			$.ajax({
				url:'menu.do?method=getAllMenuStr&ttt='+new Date().getTime(),
				data:data,
				async:false,
				dataType:'json',
				success:function(rlt){
					result = rlt;
				}
			});
			return result;
		}
		
		,getQxgroupAllMenu: function(data){
			var result = '';
			$.ajax({
				url:'menu.do?method=getQxgroupMenu&ttt='+new Date().getTime(),
				data:data,
				async:false,
				dataType:'json',
				success:function(rlt){
					result = rlt;
				}
			});
			return result;
		}
		
		,getQxgroupMenuStr : function(data){
			var result = '';
			$.ajax({
				url:'menu.do?method=getQxgroupMenuStr&ttt='+new Date().getTime(),
				data:data,
				async:false,
				dataType:'json',
				success:function(rlt){
					result = rlt;
				}
			});
			return result;
		}
		,loadRepairDataDWX : function(selectObj,data,async,defaultValue,url,xz){
			var result = '';
			$.ajax({
				url:'repairShop.do?method=selectRepairShopDwlxlist&ttt='+new Date().getTime(),
				data:data,
				async:async,
				dataType:'json',
				success:function(rlt){
					var hstr = '<option value="">'+xz+'</option>';
					for(var i in rlt){
						hstr += '<option  value="'+rlt[i].dwbh+':'+rlt[i].dwmc+'" '+((defaultValue&&defaultValue==rlt[i].dwbh)?'selected="selected"':'')+' >'+rlt[i].dwmc+'</option>';
					}
					$(selectObj).html(hstr);
				}
			});
		},
		loadCodeDataDWX: function(selectObj,data,async,defaultValue,url,xz){// select加载有空选项
			$.ajax({
				url:(url||'repairShop.do?method=selectListRepairShop&ttt='+new Date().getTime()),	//如果url为空，则默认查询code
				data:data,
				async:async,
				dataType:'json',
				success:function(rlt){
					var hstr = '<option value="">'+xz+'</option>';
					for(var i in rlt){
						hstr += '<option value="'+rlt[i].dm+'" '+((defaultValue&&defaultValue==rlt[i].dm)?'selected="selected"':'')+' >'+rlt[i].mc+'</option>';
					}
					$(selectObj).html(hstr);
				}
			});
		},
		loadCodeDataFYLX: function(selectObj,data,async,defaultValue,url,xz){
			$.ajax({
				url:(url||'exp.do?method=selectExpensesFylx&ttt='+new Date().getTime()),
				data:data,
				async:async,
				dataType:'json',
				success:function(rlt){
					var hstr='<option value="">'+xz+'</option>';
					for(var i in rlt){
						hstr += '<option value="'+rlt[i].dm+'" '+((defaultValue&&defaultValue==rlt[i].dm)?'selected="selected"':'')+' >'+rlt[i].mc+'</option>';
					}
					$(selectObj).html(hstr);
				}
				
			});
		},
		loadpak: function(selectObj,data,async,defaultValue,url,xz){// select加载有空选项
			$.ajax({
				url:url,	//如果url为空，则默认查询code
				data:data,
				async:async,
				dataType:'json',
				success:function(rlt){
					var hstr = '<option value="">'+(xz||'')+'</option>';
					for(var i in rlt){
						hstr += '<option value="'+rlt[i].cdbh+'" '+((defaultValue&&defaultValue==rlt[i].cdbh)?'selected="selected"':'')+' >'+rlt[i].cddz+'</option>';
					}
					$(selectObj).html(hstr);
				}
			});
		}
	};
	
	exports('ajaxTools', ajaxTools);
});
