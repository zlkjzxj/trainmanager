/**
 * 自定义表单验证组件
 * 
 *   既支持函数式的方式，也支持数组的形式
 *   数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
 */
layui.define('jquery',function(exports){
	"use strict";
	
	var $ = layui.jquery
	
	,VerifyTools = function(){
		
		/**
		 * 定义一个verify变量，类型为json对象，
		 * 里面可以存放两种类型的验证
		 * 
		 * Function[自定义方法]:
		 * 		如果验证不通过，直接返回提示字符串
		 * 		如果返回true，则不通过，但是页面会提示‘true’
		 * 		如果返回false或者undefined，则表示验证通过
		 * 
		 * 		所以只能返回提示字符按串，不要返回其它东西，比如数值或者布尔值
		 * 
		 * RegExp[正则表达式]:
		 * 		给一个json对象，存放两个值，
		 * 		第一个值是要匹配的正则表达式，
		 * 		第二个值是如果不匹配，提示的字符串
		 * 		示例:[/(.+){6,12}$/, '密码必须6到12位']
		 * 		示例说明(‘,’前是正则表达式【不要用引号包住，不然就是字符串】，后面是提示字符串)
		 * 
		 * 
		 * 
		 * 通用长度验证
		 * maxN、minN、eqN
		 * N代表一个数字，比如max5表示最大不能超过5位，eq5表示只能为5位
		 * 尽量不要用max、min、eq开头命名规则
		 * 
		 * 
		 * 
		 * 注意：最好不要和layui form组件内置的验证名称相同，避免冲突覆盖等麻烦！
		 * 内置验证：required（必填项）、phone（手机号）、email（邮箱）、url（网址）、number（数字）、date（日期）、identity（身份证）
		 * 内置验证定义如下：
		 * verify: {
		 *       required: [
		 *         /[\S]+/
		 *         ,'必填项不能为空'
		 *       ]
		 *       ,phone: [
		 *         /^1\d{10}$/
		 *         ,'请输入正确的手机号'
		 *       ]
		 *       ,email: [
		 *         /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
		 *         ,'邮箱格式不正确'
		 *       ]
		 *       ,url: [
		 *         /(^#)|(^http(s*):\/\/[^\s]+\.[^\s]+)/
		 *         ,'链接格式不正确'
		 *       ]
		 *       ,number: [
		 *         /^\d+$/
		 *         ,'只能填写数字'
		 *       ]
		 *   	,money: [
		 *          /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/
		 *          ,'只能填写正确的人民币格式,如:99.99'
		 *       ]
		 *       ,date: [
		 *          /^(\d{4})[-\/](\d{1}|0\d{1}|1[0-2])([-\/](\d{1}|0\d{1}|[1-2][0-9]|3[0-1]))*$/
		 *         ,'日期格式不正确'
		 *       ]
		 *       ,identity: [
		 *         /(^\d{15}$)|(^\d{17}(x|X|\d)$)/
		 *         ,'请输入正确的身份证号'
		 *       ]
		 *     }
		 * 
		 */
		this.verify = {
			/*
			 * 通用长度验证
			 * maxN、minN、eqN
			 * N代表一个数字，比如max5表示最大不能超过5位，eq5表示只能为5位
			 * 尽量不要用max、min、eq开头命名规则
			 */
				
			//非空
			notNull : [/[\S]+/,'必填项不能为空']
				
			//严格的身份证明号码验证
			,strictId : function(value){
				var aCity={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"};
				var iSum=0 ;  
			    var info="" ;  
			    if(!/^\d{17}(\d|x)$/i.test(value)) return "你输入的身份证长度或格式错误";
			    value=value.replace(/x$/i,"a");   
			    if(aCity[parseInt(value.substr(0,2))]==null) return "你的身份证地区非法";   
			    var sBirthday=value.substr(6,4)+"-"+Number(value.substr(10,2))+"-"+Number(value.substr(12,2));   
			    var d=new Date(sBirthday.replace(/-/g,"/")) ;  
			    if(sBirthday!=(d.getFullYear()+"-"+ (d.getMonth()+1) + "-" + d.getDate()))return "身份证上的出生日期非法";   
			    for(var i = 17;i>=0;i --) iSum += (Math.pow(2,i) % 11) * parseInt(value.charAt(17 - i),11) ;  
			    if(iSum%11!=1) return "你输入的身份证号非法";
			    //return true;//aCity[parseInt(sId.substr(0,2))]+","+sBirthday+","+(sId.substr(16,1)%2?"男":"女")
			}
			
			//严格的手机号码验证
			,strictPhone : [/^(13|15|18|14|17)\d{9}$/,'手机号码格式不正确']
			
			//.....
			
			
			//nullable 可空，有字符才校验
			,naNumber : [/^\d*$/,'只能填写数字']
		};
	};
	
	
	VerifyTools.prototype.runVerify = function(verstr,value,elem){
		var that = this;
		if(!verstr){
			//error
			return false;
		}
		
		var vers =  verstr.split('|');
		for(var i in vers){
			var ver = vers[i];
			
			if(elem&&elem.length&&elem.length>0){
				elem.removeClass('layui-form-danger');
			}
			var tips = ''
				,isFn = typeof that.verify[ver] === 'function';
			if(that.verify[ver] && (isFn ? tips = that.verify[ver](value) : !that.verify[ver][0].test(value)) ){
				layer.msg(tips || that.verify[ver][1], {
					icon: 5
					,shift: 6
				});
				
				if(elem&&elem.length&&elem.length>0){
					 try{
						 elem.focus();
		        	  }catch(e){ }
					elem.addClass('layui-form-danger');
				}
				return false;
			}
			
			var le = (value+'').length,tipMess = ''; 
			if(ver.indexOf('max')===0){
				var n = parseInt(ver.replace('max',''));
				tipMess = (le <= n ? '' : '值过长，最大长度'+n+'位');
			}else if(ver.indexOf('min')===0){
				var n = parseInt(ver.replace('min',''));
				tipMess = (le >= n ? '' : '值过短，最小长度'+n+'位');
			}else if(ver.indexOf('eq')===0){
				var n = parseInt(ver.replace('eq',''));
				tipMess = (le === n ? '' : '值错误，限制长度'+n+'位');
			}
			
			if(tipMess){
				layer.msg(tipMess, {
					icon: 5
					,shift: 6
				});
				
				if(elem&&elem.length&&elem.length>0){
					 try{
						 elem.focus();
		        	  }catch(e){ }
					elem.addClass('layui-form-danger');
				}
				return false;
			}
			
		}
		
		return true;
	}
	
	
	VerifyTools.prototype.set = function(form){
		var that = this;
		form.verify(that.verify);
		return that;
	}
	
	
	var verifyTools = new VerifyTools();
	
	exports('verifyTools', function(form){
		return verifyTools.set(form);
	});
});
