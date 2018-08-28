layui.define('jquery',function(exports){
	"use strict";
	
	var $ = layui.jquery
	
	,domTools = {
			
		/**
		 * 向web控制台输出信息
		 */
		printMsgToConsole : function(type,mess){
			try{
				if(type==='log'){
					console.log(mess);
				}else if(type==='error'){
					console.error(mess);
				}
			}catch(e){
				
			}
		}
	
		
		/**
		 * 自适应表格高度
		 */
		,resizeTimer:''
		,resizeTableHeight : function(){
			if (domTools.resizeTimer) clearTimeout(domTools.resizeTimer);
			domTools.resizeTimer = setTimeout(function(){
				if(
					(($(window).height()-206)<$('#contentDiv').height())
					||
					(($(window).height()-206)<($('#tbodyTable').height()+47))
					||
					($('#contentDiv').height()<($('#tbodyTable').height()))
				){
					$('#contentDiv').css('overflow','auto').height($(window).height()-$('blockquote').height()-206);
				}
				
				if(
					($('#contentDiv').height()<$('#tbodyTable').height())
					||
					($(window).width()<$('#contentDiv').width())
				){
					/*console.log($('blockquote',parent.document));
					console.log($('blockquote',parent.document).width());*/
					
					if($('blockquote').length>=1&&$('blockquote').width()>0){
						$('#theadTable').width($('blockquote').width()-($('#contentDiv').width()-$('#tbodyTable').width())-12);
					}else{
						if($('blockquote',parent.document).length>=1&&$('blockquote',parent.document).width()>0){
							$('#theadTable').width($('blockquote',parent.document).width()-($('#contentDiv').width()-$('#tbodyTable').width())-31);
						}
					}
				}else{
					$('#theadTable').width($('#theadTable').parent().width());
				}
			} , 100);
		}
	
		
		/**
		 * 在页面底部创建按钮，页面其它所有内容都要包含到“<div id="content"></div>”中
		 */
		,createBtnsAtBottom : function(btns){
			btns = btns || {};
			var divCls = 'btns-div'+new Date().getTime();
			var bstr = '';
			for(var i in btns){
				bstr += '<a id="'+(btns[i].id||'')+'" class="layui-layer-btn'+i+' '+(btns[i].className||'')+'"  data-type="'+(btns[i].type||'')+'" style="'+(btns[i].style||'')+'">'+(btns[i].name||'')+'</a>';
			}
			bstr = '<div style="position: fixed;bottom: 0;right: 0;" class="layui-layer-btn '+divCls+'">'+bstr+'</div>';
			$('body').append(bstr);
			var resizeWin = function(){
				var contentHeight = (parseInt($(window).height())-60)+'px';
				$(window).height(parseInt($(window).height())-60);
				$('body>div#content').css({'height':contentHeight,'overflow':'auto'});
			}
			$(window).on('resize',resizeWin).resize();
			
			$('.'+divCls+' a[data-type=cancel]').click(function(){
				domTools.closeThisIframeLayer();
			});
		}
	
	
		/**
		 * 在iframe内部关闭layer层
		 */
		,closeThisIframeLayer : function(){
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭
		}
	
		/**
		 * 添加号牌头
		 */
		,addHpt : function(elem,hpt){
			var ep = elem.parent();
			if(ep.css('position')!='absolute'||ep.css('position')!='relative'){
				ep.css('position','relative');
			}
			ep.append('<span class="frm-hpt">'+hpt+'</span>');
			elem.addClass('frm-hpt-input');
		}
		
		/**
		 * 清除select options
		 */
		,clearSelect : function(selectObj){
			selectObj.options.length = 0;
		}
	};
	
	exports('domTools', domTools);
});
