layui.define('jquery',function(exports){
	"use strict";
	
	var $ = layui.jquery
	
	,Tools = {
			getsjc : function(dt1,dt2,id){
				var regTime = /(\d{4})-(\d{1,2})-(\d{1,2})( \d{1,2}:\d{1,2})/g;
				var interval = Math.abs(Date.parse(dt1.replace(regTime, "$2/$3/$1$4")) - Date.parse(dt2.replace(regTime, "$2/$3/$1$4")))/1000;
				var sjc=Tools.stringToTime(dt2)-Tools.stringToTime(dt1);
				if(sjc<0){
					layer.alert("结束时间不可小于开始时间", {icon: 5});
					return;
				}
				var h = Math.floor(interval / 3600);
				var m = Math.floor(interval % 3600 / 60)/60;
				var hm=h+m;
			    hm=hm.toFixed(2);
			    if(hm!='NaN'){
			    	$("#"+id).val(hm);
			    }
			}
			,stringToTime:function(string) {
	            var f = string.split(' ', 2);
	            var d = (f[0] ? f[0] : '').split('/', 3);
	            var t = (f[1] ? f[1] : '').split(':', 3);
	            return (new Date(
	           parseInt(d[0], 10) || null,
	           (parseInt(d[1], 10) || 1) - 1,
	            parseInt(d[2], 10) || null,
	            parseInt(t[0], 10) || null,
	            parseInt(t[1], 10) || null,
	            parseInt(t[2], 10) || null
	            )).getTime();
	
	        }
	};
	
	exports('Tools', Tools);
});