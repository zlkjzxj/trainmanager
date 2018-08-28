layui.define(['jquery'],function(exports){
	"use strict";
  
	var $ = layui.jquery
		,config = {
			margin: '70px 30px 30px'
		};

	var TimeLine = {
			create: function(options){
				options = options || {};
				
				var elem = options.elem;
				if(!elem){
					writeMsg('elem is empty');
					return;
				}
				
				var items = options.items;
				if(!items||!items.length||items.length==0){
					writeMsg('items is empty');
					return;
				}
				
				var items2 = options.items2;
				
				var currItem = options.currItem;
				if(!currItem){
					writeMsg('currItem is empty');
					return;
				}
				
				var isEnd = options.isEnd||false;
				
				var margin = options.margin||config.margin;
				
				var ITEMS_PER_WIDTH = (100/((items.length*2)+2));
				
				var itemshtml = '';
				var classstr = 'frm-time-line-on';
				var currItemIndex = -1;
				$.each(items,function(i){
					if(items[i]==currItem){
						classstr = 'frm-time-line-this';
						currItemIndex = i;
					}
					/*itemshtml += '<li style="left:'+((ITEMS_PER_WIDTH*(i+1)).toFixed(2))+'%" class="'+classstr+'">'+items[i]+'</li>';*/
					itemshtml += '<li class="line-flow '+classstr+'"><span class="line-above">'+items[i]+'</span><span class="line-point"></span><span class="line-under">'+((items2&&items2.length&&items2.length>i)?items2[i]:'')+'</span></li>';
					classstr = items[i]==currItem?'':classstr;
				});
				
				var idstr = 'frm-time-line-div'+new Date().getTime();
				
				$(elem).html('<div id="'+idstr+'" class="frm-time-line-div" style="margin:'+margin+';">\
		  			<div class="frm-time-line">\
						<span style="width:0%;" class="frm-time-line-filling"></span>\
		  				<ul>\
							<li class="line-head"></li>\
		  					'+itemshtml+'\
		  					<li class="line-toe"></li>\
		  				</ul>\
		  			</div>\
		  		</div>');
				
				var drawFillingLine = function(){
					$('#'+idstr+' .frm-time-line ul li.line-flow').css({'width':((ITEMS_PER_WIDTH*2).toFixed(2)+'%')});
					$('#'+idstr+' .frm-time-line ul li.line-head').css({'width':((ITEMS_PER_WIDTH).toFixed(2)+'%')});
					$('#'+idstr+' .frm-time-line ul li.line-toe').css({'width':((ITEMS_PER_WIDTH).toFixed(2)+'%')});
					
					var fillinglinewidth = 0;
					if(isEnd){
						fillinglinewidth = $('.frm-time-line').width();
					}else{
						fillinglinewidth = (($('.frm-time-line').width())*((ITEMS_PER_WIDTH*((currItemIndex+1)*2)).toFixed(2))/100);
					}
					$('span.frm-time-line-filling').width(fillinglinewidth);
				};
				$(window).off('resize',drawFillingLine).on('resize',drawFillingLine).resize();
			}
		};
	
	var writeMsg = function(msg){
		  try {
			  console.error('创建时间轴发生错误:'+msg);
		  } catch (e) { }
	}
  
	exports('timeline', TimeLine);
});
