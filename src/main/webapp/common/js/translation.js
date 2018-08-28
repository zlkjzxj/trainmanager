/**
 * 翻译管理部门名称
 */
function formateGlbm(value){
	try{
		for(var i=0; i<glbmcode.length; i++){
			if (glbmcode[i].glbm == value){
				return glbmcode[i].bmmc;
			} 
		}
	}catch(e){
		//alert('翻译管理部门发生异常:<br>管理部门:'+value+'<br>异常:'+e);
	}
	return value;
}

function formateSfgly(value){
	if(value=='1'){
		return '是';
	}else if(value=='0'){
		return '否';
	}
	return value;
}


function formateYhjb(value,split){
	try {
		split = split || ',';
		if (value && value.toString()) {
			var vs = value.split(split);
			var rs = [];
			for (var i = 0; i < yhjbcode.length; i++) {
				for ( var j in vs) {
					if (yhjbcode[i].dm == vs[j]) {
						rs.push(yhjbcode[i].mc);
						break;
					}
				}
			}
			return rs.join(split+' ');
		}
		return value;
	} catch (e) {
		//console.error(e);
	}
}

function formateCssx(value){
	if(value=='1'){
		return '固定';
	}else if(value=='2'){
		return '继承';
	}else{
		return value;
	}
}

function formateCslx(value){
	if(value=='1'){
		return '系统参数';
	}else if(value=='2'){
		return '业务参数';
	}else{
		return value;
	}
}

/**
 * 翻译管理部门名称(简称)
 */
function formateGlbm_jc(value){
	try{
		for(var i=0; i<glbmcode.length; i++){
			if (glbmcode[i].glbm == value){
				return glbmcode[i].bmjc;
			} 
		}
	}catch(e){
		//alert('翻译管理部门发生异常:<br>管理部门:'+value+'<br>异常:'+e);
	}
	return value;
}
/**
 * 翻译车辆类型名称
 */
function formateCllx(value){
	try{
		for(var i=0; i<cllxcode.length; i++){
			if (cllxcode[i].dm == value){
				return cllxcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}
/**
 * 翻译号牌种类
 * @param value
 * @returns
 */
function formateHpzl(value){
	try{
		for(var i=0; i<hpzlcode.length; i++){
			if (hpzlcode[i].dm == value){
				return hpzlcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}
/**
 * 翻译保险种类
 * @param value
 * @returns
 */
function formatebxzl(value){
	try{
		for(var i=0; i<bxzlcode.length; i++){
			if (bxzlcode[i].dm == value){
				return bxzlcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}


/**
 * 费用类型
 * @param value
 * @returns
 */
function formateFylx(value){
	try{
		for(var i=0; i<clfylxcode.length; i++){
			if (clfylxcode[i].dm == value){
				return clfylxcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}

/**
 * 日志类型
 */
function formateRzlx(value){
	try{
		for(var i=0; i<rzlxcode.length; i++){
			if (rzlxcode[i].dm == value){
				return rzlxcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}
/**
 * 准驾车型
 */
function formateZjcx(value){
	try{
		for(var i=0; i<zjcxcode.length; i++){
			if (zjcxcode[i].dm == value){
				return zjcxcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}
/**
 * 性别
 */
function formateXb(value){
	try{
		for(var i=0; i<xbcode.length; i++){
			if (xbcode[i].dm == value){
				return xbcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}
/**
 * 驾驶人本地状态
 */
function formateDrvbdzt(value){
	try{
		for(var i=0; i<drvbdztcode.length; i++){
			if (drvbdztcode[i].dm == value){
				return drvbdztcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}

/**
 * 时间截10位
 */
function formateShortDate(value){
	if(value!=null&&value!=''&&value.length>10){
		return value.substring(0,10);
	}
	return value;
}

/**
 * 时间截19位
 */
function formateLongDate(value){
	if(value!=null&&value!=''&&value.length>19){
		return value.substring(0,19);
	}
	return value;
}

/**
 * 翻译登陆模式
 */
function formateDlms(value,split){
	try {
		if(value==undefined||value==null||value==''){
			throw 'value is empty';
		}
		
		value = value.toString();
		split = (split == undefined || split == null || split == '') ? ',' : split;
		var values = value.split(split);
		var rlts = [];
		for (var i = 0; i < dlmscode.length; i++) {
			for(var j in values){
				if(dlmscode[i].dm == values[j]){
					rlts.push(dlmscode[i].mc);
				}
			}
		}
		return rlts.join(split);
	} catch (e) {
		alert(e.message);
	}
	return value;
}
/**
 * 翻译单位类型
 */
function formateDwlx(value){
	try{
		for(var i=0; i<dwlxcode.length; i++){
			if (dwlxcode[i].dm== value){
				return dwlxcode[i].mc;
			} 
		}
	}catch(e){
		//alert('翻译管理部门发生异常:<br>管理部门:'+value+'<br>异常:'+e);
	}
	return value;
}



/**
 * 翻译状态
 */
function formateZt(value){
	try{
		for(var i=0; i<ztcode.length;i++){
			if(ztcode[i].dm==value){
				return ztcode[i].mc;
			}
		}
	}catch(e){
    //alert('状态翻译异常')		
	}
	return value;
}







/**
 * 页面代码翻译通用方法 貌似不能用
 * @param codeName 需要翻译的代码名称，如翻译hpzl,则传入hpzlcode
 * @param codeValue 需要要翻译的代码值
 * @returns
 */
function formateCode(codeName,codeValue){
	var tempCode=codeName;
	for(var i=0; i<tempCode.length; i++){
		if (tempCode[i].dm == codeValue)  return tempCode[i].mc;
	}
	if(codeValue==undefined || codeValue=="null"){
		return "";
	}else{
		return codeValue;
	}
}
function formateYwlx(value){
	try{
		for(var i=0; i<ywlxcode.length; i++){
			if (ywlxcode[i].dm == value){
				return ywlxcode[i].mc;
			} 
		}
	}catch(e){
		return value;
	}
	return value;
}
/**
 * 业务岗位
 * @param value
 * @returns
 */
function formateYwgw(value){
	try{
		for(var i=0; i<ywgwcode.length; i++){
			if (ywgwcode[i].dm == value){
				return ywgwcode[i].mc;
			} 
		}
	}catch(e){
		return value;
	}
	return value;
}
/**
 * 业务岗位翻译并分隔
 */
function formateYwgwSplit(value,split){
	try {
		split = split || '';
		var vs = (value+'').split(split), rs = [];
		for ( var i in vs) {
			var f = false;
			for (var j = 0; j < ywgwcode.length; j++) {
				if (ywgwcode[j].dm == vs[i]) {
					rs.push(ywgwcode[j].mc);
					f = true;
				}
			}
			if (!f) {
				rs.push(vs[i]);
			}
		}
		return rs.join(split+' ');
	} catch (e) {throw e; }
	return value;
}

/**
 * 翻译车辆类型名称
 */
function formateBdzt(value){
	try{
		for(var i=0; i<vehbdztcode.length; i++){
			if (vehbdztcode[i].dm == value){
				return vehbdztcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}
/**
 * 翻译场地分类名称
 */
function formateCdfl(value){
	try{
		for(var i=0; i<tccflcode.length; i++){
			if (tccflcode[i].dm == value){
				return tccflcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}
/**
 * 翻译场地类型名称
 */
function formateCdlx(value){
	try{
		for(var i=0; i<tcclxcode.length; i++){
			if (tcclxcode[i].dm == value){
				return tcclxcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}
/**
 * 翻译场地性质名称
 */
function formateCdxz(value){
	try{
		for(var i=0; i<tccxzcode.length; i++){
			if (tccxzcode[i].dm == value){
				return tccxzcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}
/**
 * 翻译业务原因名称
 */
function formateYwyySplit(value,ywlx,split){
	try{
		split = split || '';
		var vs = value.split(split), rs = [];
		for(var vvv in vs){
			var f = false;
			
			if(ywlx=="A"){
				for(var i=0; i<gwycyycode.length; i++){
					if (gwycyycode[i].dm == vs[vvv]){
						rs.push(gwycyycode[i].mc);
						f = true;
					}
				}
			}else if(ywlx=="B"){
				for(var j=0; j<wxbyyycode.length; j++){
					if (wxbyyycode[j].dm == vs[vvv]){
						rs.push(wxbyyycode[j].mc);
						f = true;
					}
				}
			}else if(ywlx=='C'){
				for(var k=0; k<qjxjyycode.length; k++){
					if (qjxjyycode[k].dm == vs[vvv]){
						rs.push(qjxjyycode[k].mc);
						f = true;
					}
				}
			}else if(ywlx=='D'){
				for(var l=0; l<clczyycode.length; l++){
					if (clczyycode[l].dm == vs[vvv]){
						rs.push(clczyycode[l].mc);
						f = true;
					}
				}
			}
			//...
			
			if(!f){
				rs.push(vs[i]);
			}
		}
		return rs.join(split+' ');
	}catch(e){
	}
	return value;
}
/**
 * 翻译业务原因名称
 */
function formateYwYy(value,yy){
	try{
		if(yy=="A"){
			for(var i=0; i<gwycyycode.length; i++){
				if (gwycyycode[i].dm == value){
					return gwycyycode[i].mc;
				}
			}
		}else if(yy=="B"){
			for(var j=0; j<wxbyyycode.length; j++){
				if (wxbyyycode[j].dm == value){
					return wxbyyycode[j].mc;
				}
			}
		}else if(yy=='C'){
			for(var k=0; k<qjxjyycode.length; k++){
				if (qjxjyycode[k].dm == value){
					return qjxjyycode[k].mc;
				}
			}
		}else if(yy=='D'){
			for(var l=0; l<clczyycode.length; l++){
				if (clczyycode[l].dm == value){
					return clczyycode[l].mc;
				}
			}
		}
	}catch(e){
	}
	return value;
}
/**
 * 翻译审核结果
 */
function formateShjg(value){
	try{
		for(var i=0; i<shjgcode.length; i++){
			if (shjgcode[i].dm == value){
				return shjgcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}
/**
 * 翻译流水状态
 */
function formateLszt(value){
	try{
		for(var i=0; i<lsztcode.length; i++){
			if (lsztcode[i].dm == value){
				return lsztcode[i].mc;
			} 
		}
	}catch(e){
	}
	return value;
}