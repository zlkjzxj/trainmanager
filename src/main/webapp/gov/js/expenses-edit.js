layui.config({
	base: ''
		
}).extend({
	ajaxTools:	'common/js/ajaxTools',
	glbmSelect:	'common/js/glbmSelect',
	domTools:	'common/js/domTools',
	hrefTools:	'common/js/hrefTools',
	imageTools:	'common/js/imageTools',
	jqueryform:	'common/js/jquery.form'
		
}).use(['element','form','laydate','ajaxTools','imageTools','glbmSelect','domTools','hrefTools','jqueryform'],function(){
	
	var $ = jquery = layui.jquery,
		element = layui.element(),
		ajaxTools  = layui.ajaxTools,
		domTools = layui.domTools,
		hrefTools = layui.hrefTools,
		imageTools = layui.imageTools,
		laydate=layui.laydate,
		form = layui.form();
	//创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
	domTools.createBtnsAtBottom([{
		name:'<i class="layui-icon">&#xe654;</i> 新增', id:'expenses-add', style:'border-color: deepskyblue;background-color: deepskyblue;color: #fff;'},{
		name:'<i class="layui-icon">&#xe605;</i> 保存', id:'expenses-save', style:'border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
		name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'ue-cancel', type:'cancel'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
	]);
	 
	//用来清空上传照片的显示区域的内容
	var bjzp=""; 
	
	//绑定select事件
		var hphm = $('#hidden-ince-hphm').val();
		if(hphm!=null&&hphm!=""){
			var hm = hphm.substring(2);
			var hp = hphm.substr(0, 2);
			$('#ince-bdfzjg').val(hp);
			$('#hm').val(hm);
		}
		var fyje=$('#expense-fyje').val();
		if(fyje!=null&&fyje!=""){
			$('#je').val(fyje);
		}
	
	//渲染
	element.init();
	form.render();
	var opr = $('#opr').val();	//e:编辑  a:新增
	var fzbl=$('#fzbl').val();//操作费用类型
	if(opr=='e'){
		//较为特殊的字段无法直接el表达式赋值，js处理下
		$('#expenses-save').css({ background:"",color:"gray"});
		$('#expenses-save').attr('disabled',true);
	}else if(opr=='a'){
		$('#expenses-save').attr('disabled',false);
	}
	
	//号牌种类选择下拉框事件
	ajaxTools.loadCodeDataKK($('#hpzl'),{dmmc:'hpzl'},false,($('#hpzl').data('value')||''),'code.do?method=selectListCode','请选择号牌种类');
	form.render('select')
	
	//费用类型选择下拉框事件
	ajaxTools.loadCodeDataFYLX($('#fylx'),{dmmc:'clfylx'}, false,($('#fylx').data('value')||''),'exp.do?method=selectExpensesFylx', '请选择费用类型');
	form.render('select');
	
	//选择流水号页面跳转
	$("#lsh-select").click(function(){
		layer.open({
			type: 2,
			id:'UserEdit',
			content:['exp.do?method=getExpensesLsh'],
			title: '流水号信息列表', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
			shade: 0.2,
			area: ['900px', '500px'],
			zIndex: 10000000,
			//fixed: false,
			moveOut: true,
			//scrollbar: false,
			maxmin: false,
			btn: 0 	//['新增','保存', '取消']
		});
	});
	//把流水号页面的值赋给编辑页面对应的input;
	window.setZs=function(zs1,zs2,zs3){
	  $('#ince-lsh').val(zs1);
	//绑定select事件
		if(zs3!=null&&zs3!=""){
			var hm = zs3.substring(2);
			var hp = zs3.substr(0, 2);
			$('#ince-bdfzjg').val(hp);
			$('#hm').val(hm);
		}
	  $('#hpzl').val(zs2);
	  form.render('select')
	  form.render('checkbox');
	}
    //新增
	$('#expenses-add').click(function(){
		var lsh=$("#ince-lsh").val();
		if(opr=='e'||lsh!=''){
			 $("#cs").empty();
			ajaxTools.loadCodeDataFYLX($('#fylx'),{dmmc:'clfylx'}, false,($('#fylx').data('value')||''),'exp.do?method=selectExpensesFylx', '请选择费用类型');
			$('#fylx').val('');
			form.render('select');
			
            $('#je').val('');
		    $('#expenses-save').attr('disabled',false);
		    $('#expenses-save').attr('style','border-color: #4898d5;background-color: #2e8ded;color: #fff;');
		}else if(opr=='a'){
			location.href="exp.do?method=getExpenses";
		}
	});
	//保存按钮
	$('#expenses-save').click(function(){
		if(form.verifyForm(mainForm)){//form.verifyForm返回ture表示表单验证成功
			if($('#expenses-save').attr('disabled')=="disabled"){
				return;
			}
			var gnid ='02080301';
			var jbr=$('#curr-user-xm').val();
			
			var hphm = $('#ince-bdfzjg').val()+$('#hm').val();
			$('#hphm').val(hphm);
			var glbm=$('#curr-user-glbm').val();
			$(mainForm).ajaxSubmit({
				type:'POST',
				url:'exp.do?method=saveExpenses',
				data:{
					//这里是一些表单之外，额外的参数，无法通过表单直接上传的参数值，也就是页面上没有这些name。
					cxdh:hrefTools.getLocationParam('cxdh',parent),
					gnid:gnid,
					hphm:hphm,
					glbm:glbm,
					jbr:jbr
				},
				dataType:'json',
				success:function(rlt){
					if(rlt.code=='1'){
						$('#opr').val('e');
						$('#lsh').val(rlt.backValueMap.lsh);
						layer.alert(rlt.mess, {icon: 6});
					}else{
						layer.alert(rlt.mess, {icon: 5});
					}
					try {
						//刷新父页面列表
						if(opr=='e'){
							parent.reQueryExpensesList();
						}else{
							parent.refreshExpensesList();
						}
					} catch (e) {}
				}
			});
		}
	});
	//票据上传添加
	var src1="";
	var count=1;
	$('#addc').click(function(){
	    if(bjzp=="e"){
	       $("#cs").empty();
	       bjzp="";
	     }
	    src1="";
	    src1+="<div class=\"frm-col-8\" style=\"height:160px; position: relative; width:180px; border:1px solid black;  flaot:right; margin-left:55px; margin-top:23px;\">"
	        src1+="<div id=\"PreviewDiv"+count+"\" style=\"width:180px;position:absolute; height:160px;overflow: hidden;\">"
	        src1+="<img id=\"PreviewImg"+count+" imgbig\" src=\"\" onerror=\"this.src='common/pictures/01.jpg'\" style=\"width: 180px;height:160px;\" style=\"width: 180px;height:160px\">"
	        src1+="</div>"
	        src1+= "<input id=\"pic"+count+"\" name=\"pic"+(count++)+"\"   type=\"file\" class=\"layui-input layui-upload-file\" style=\"position:relative;width:160px;height:160px;top:0;left:0;z-index:999;opacty:0;\"/>" 
	        src1+="</div>"
	        src1+="<div class=\"frm-col-8\" style=\"height:160px; width:180px; position: relative; margin-left:2px; border:1px solid black; float:left;margin-top:22px;\">"
	        src1+="<div id=\"PreviewDiv"+count+"\"  style=\"width:180px;height:160px; position:absolute; margin-right:1px;overflow: hidden;\">"
	        src1+="<img id=\"PreviewImg"+count+" imgbig\"  src=\"\" onerror=\"this.src='common/pictures/01.jpg'\" style=\"width: 180px;height:160px\">"
	        src1+="</div>"
            src1+="<input id=\"pic"+count+"\" name=\"pic"+(count++)+"\" type=\"file\" class=\"layui-input layui-upload-file\" style=\"position:relative;width:160px;height:160px;top:0;left:0;z-index:999;opacty:0;\"/>" 
	        src1+="</div>"
	     $('#cs').append(src1); 
	     for (var i=0;i<count;i++){
              change(i);
          }
	    });
	   function change(count){
           $('#pic'+count).change(function(){
			imageTools.previewImage($(this)[0],'PreviewImg'+count,'PreviewDiv'+count);
			var browserVersion = window.navigator.userAgent.toUpperCase();
			if(browserVersion.indexOf("MSIE")>-1)
			document.getElementById('pic'+count).style.marginTop="-160";
            });
          }
	   
	     //费用类型内容改变事件
       form.on('select(fylxSelect)', function(data){
    	   fyzpxs();
		});
       //当点编辑按钮的时候,用来查看照片是否已经上传
       $(function(){
    	   //alert("进来了");
    	   fyzpxs();
       });
       
       function fyzpxs(){
    	   $("#cs").empty();
 		  var fylx=$('#fylx').val();
 		  var lsh=$('#ince-lsh').val();
 		 
 		 if(fylx==''||lsh==''){
 			 return;
 		 } 
 		$.ajax({
 		url:'govPhoto.do?method=selectGovPhotoListzp&lsh='+lsh+'&zplx='+fylx+'&t='+new Date().getTime(),
 		async:false,
 		dataType:'json',
 		success:function(rlt){
 			$('#je').val('0');
 		    var stringdiv="";
 			for(var i in rlt){
 		        var lsh=rlt[i].lsh;
 		        var zplx=rlt[i].zplx;
 		        var fyje=rlt[i].fyje;
 			 	var fyje1 = fyje===null?'0':fyje;
 			 	//alert("费用金额:"+fyje1);
 		        $('#je').val(fyje1);
 		        i++;
 	            stringdiv+="<div class=\"frm-col-8\" style=\"height:160px; position: relative; width:180px; border:1px solid black;  flaot:right; margin-left:20px; margin-top:23px;\">"
 				stringdiv+="<img src=\"flow.do?method=printGovPhotos&lsh="+lsh+"&zplx="+zplx+"&zpbh="+(i)+"\" onerror=\"this.src='common/pictures/01.jpg'\" style=\"width: 180px;height:160px;\">";
 				stringdiv+="</div>";
 				/* stringdiv+="<div class=\"frm-col-8\" style=\"height:160px; position: relative; width:180px; border:1px solid black;  flaot:right; margin-left:20px; margin-top:23px;\">"
 				stringdiv+="<img src=\"flow.do?method=printGovPhotos&lsh="+lsh+"&zpzl="+zpzl+"&zpbh="+(i++)+"\" onerror=\"this.src='common/pictures/01.jpg'\" style=\"width: 180px;height:160px;\">";
 				stringdiv+="</div>"; */
 				bjzp="e";
 			}
 			$('#cs').append(stringdiv);	
 		  }
 	   });
     
    }
       
       
       
       
});
