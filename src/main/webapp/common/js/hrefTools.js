layui.define('jquery',function(exports){
	"use strict";
	
	var $ = layui.jquery
	
	,hrefTools = {
		getLocationParam : function(paramNme,win){
			var str = (win||window).location.search.split('&');
			for(var i in str){
				if(str[i].indexOf(paramNme)==0){
					return str[i].split('=')[1];
				}
			}
		}
	};
	
	exports('hrefTools', hrefTools);
});
