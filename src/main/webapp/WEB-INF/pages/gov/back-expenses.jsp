<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
	<head>
	    <meta name="renderer" content="webkit">
		<meta charset="UTF-8">
		<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="frm/css/global.css" media="all">
		<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="frm/css/frmColors.css" type="text/css">
		<style type="text/css">
		#frm{
		Margin:15px;
		margin-left:65px;
		}
		.layui-input-block{
				margin-left:0px;
				margin-right:10px;
			}
		</style>
	<!-- 	<script type="text/javascript">
		function setZs(zs1,zs2,zs3){
				document.getElementById("ince-lsh").value=zs1;
			}
		</script> -->
	</head>
	<body>
	 <div id="content">
		<form id="mainForm" name="mainForm" class="layui-form" method="post" action="">
			   <input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }"/>
		       <input type="hidden" id="curr-user-xm"  value="${userSession.user.xm }"/>
			   <input type="hidden" id="hidden-ince-hphm" value="${hphm }" />
			   
			      <div class="frm-row" id="frm">
			        <label class="frm-label frm-col-4">流水号</label>
					<div class="layui-input-block frm-col-5" >
						<input type="text" id="ince-lsh"  name="lsh" value="${lsh}"lay-verify="number"  maxlength="13"  placeholder="请选择流水号" class="layui-input" >
					</div>
					 
					  <label class="frm-label frm-col-4" style=" margin-left:106px">经办人</label>
				      <div class="layui-input-block  frm-col-5" >
				        <input type="text" id="jbr" name="jbr" value="${userSession.user.xm }" lay-verify="chinese" maxlength="15"  placeholder="请输入经办人" class="layui-input">
				      </div>
				   
					
				 </div>
				 
				  <div class="frm-row" id="frm">
				    <label class="frm-label frm-col-4">号牌种类</label>
				     <div class="layui-input-block frm-col-5" >
						<select id="hpzl" name="hpzl" lay-filter="hpzlSelect"  data-value="${hpzl}" placeholder="请选择号牌种类"  lay-verify="required">
						        <option value="">请选择号牌种类</option>
						</select>
			        </div>
				  
			        <label class="frm-label frm-col-4" style="margin-left:106px;">号牌号码</label>
				 <div class=" layui-input-block frm-col-5" >
                     <input type="text" id="ince-bdfzjg" value="${hphm }" readonly class="layui-input" style="width: 18%;;float:left;">
					 <input type="text" id="hm"  onkeyup="this.value=this.value.toUpperCase()" lay-verify="hphm" maxlength="5" placeholder="请输入号牌号码" class="layui-input" style="width: 82%;float:right;">
				 </div>
			   </div>
			    
			    <div class="frm-row" id="frm" >
				              <label class="frm-label frm-col-4">费用类型</label>
				   <div class="layui-input-block frm-col-5"  >
						<select id="fylx" name="fylx" lay-filter="fylxSelect"  placeholder="请选择费类型" data-value="${expense.fylx}" lay-verify="required">
						        <option value="">请选择费用类型</option>
						</select>
				  </div>
					
					   <label class="frm-label frm-col-4" style="margin-left:106px;">费用金额</label>
				 <div class=" layui-input-block frm-col-5" >
                     <input type="text" id="fyje" value="元" readonly class="layui-input" style="width: 18%; float:right;">
					 <input type="text" id="je" name="fyje" lay-verify="money1"  maxlength="10" placeholder="请输入费用金额" class="layui-input" style="width: 82%;float:right;">
				 </div>
			</div>
			<div class="frm-row"  style="float:left;">
					 <div class=" layui-input-block frm-col-2" style="margin-left:580px;margin-top:10px;" >
					     <a href="javascript:;" class="layui-btn layui-btn-small" id="addc"><i class="layui-icon" >&#xe654;</i>上传票据添加</a>
					 </div>
			</div>
		    <div class="frm-row"  id="cs" style="border:1px solid #e6e6e6; width:900px;height:200px;margin-left:200px;float:left;overflow-y:scroll;">
		      
		    </div>
		    <div class="frm-row"  style=" width:225px;height:30px; margin-top:20px; margin-left:68%;float:left;">
		    	<a href="javascript:;" class="layui-btn layui-btn-small" id="expenses-add" style="background: #01AAED;color:#fff;"><i class="layui-icon"  >&#xe654;</i> 新增</a>
				<a href="javascript:;" class="layui-btn layui-btn-small" id="expenses-save" style="background:#01AAED;color:#fff;"><i class="layui-icon" >&#xe654;</i>保存</a>
				<a href="javascript:;" class="layui-btn layui-btn-small" id="ue-cancel" style="background:#01AAED;color:#fff"><i class="layui-icon" >&#xe654;</i> 关闭</a>
		    </div>
		  </form>
		</div>
		<script type="text/javascript">
			//发证机关选择下拉框事件
			var fzjg ='<%=Constant.SYS_PARAM.get("bdfzjg") %>';
			document.getElementById("ince-bdfzjg").value=fzjg;
		</script>
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
	  <script type="text/javascript">
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
					/* //创建底部按钮 页面其它所有内容都要包含到“<div id="content"></div>”中
					domTools.createBtnsAtBottom([{
						name:'<i class="layui-icon">&#xe654;</i> 新增', id:'expenses-add', style:'margin-top:0px;border-color: deepskyblue;background-color: deepskyblue;color: #fff;'},{
						name:'<i class="layui-icon">&#xe605;</i> 保存', id:'expenses-save', style:'margin-top:0px;border-color: #4898d5;background-color: #2e8ded;color: #fff;'},{
						name:'<i class="layui-icon">&#x1006;</i> 关闭', id:'ue-cancel', type:'cancel' ,style:'margin-top:0px;'}//如果要自己写事件关闭，则去掉 type:'cancel' ，调用domTools.closeThisIframeLayer()方法
					]); */
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
						//关闭弹层
						$('#ue-cancel').click(function(){
								domTools.closeThisIframeLayer();
						});
					
					//渲染
					element.init();
					form.render();
					//号牌种类选择下拉框事件
					ajaxTools.loadCodeDataKK($('#hpzl'),{dmmc:'hpzl'},false,($('#hpzl').data('value')||''),'code.do?method=selectListCode','请选择号牌种类');
					form.render('select')
					
					//费用类型选择下拉框事件
					ajaxTools.loadCodeDataFYLX($('#fylx'),{dmmc:'clfylx'}, false,($('#fylx').data('value')||''),'exp.do?method=selectExpensesFylx', '请选择费用类型');
					form.render('select');
					
					
				   //新增
					$('#expenses-add').click(function(){
						var lsh=$('#ince-lsh').val();
						var hpzl=$('#hpzl').val();
						var hphm = $('#ince-bdfzjg').val()+$('#hm').val();
						if(lsh!=''){
						    $("#cs").empty();	
		                    $('#fylx').val('');
							form.render('select')
				            $('#je').val('');
						    $('#expenses-save').attr('disabled',false);
						    $('#expenses-save').attr('style','border-color: #4898d5;background-color: #2e8ded;color: #fff;');
						}
					});
	
					//保存按钮
					$('#expenses-save').click(function(){
						if(form.verifyForm(mainForm)){//form.verifyForm返回ture表示表单验证成功
							if($('#expenses-save').attr('disabled')=="disabled"){
								return;
							}
							var gnid ='02080301';
							/* var jbr=$('#curr-user-xm').val(); */
							
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
								},
								dataType:'json',
								success:function(rlt){
									if(rlt.code=='1'){
										/* $('#opr').val('e'); */
										$('#lsh').val(rlt.backValueMap.lsh);
										layer.alert(rlt.mess, {icon: 6});
									}else{
										layer.alert(rlt.mess, {icon: 5});
									}
									try {
										//刷新父页面列表
										parent.reQueryExpensesList();
									} catch (e) {}
								}
							});
						}
					});//position: absolute;
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
	   		            src1+="<img id=\"PreviewImg"+count+"\" src=\"\" onerror=\"this.src='common/pictures/01.jpg'\" style=\"width: 180px;height:160px;\" style=\"width: 180px;height:160px\">"
	   		            src1+="</div>"
	   		            src1+= "<input id=\"pic"+count+"\" name=\"pic"+(count++)+"\"   type=\"file\" class=\"layui-input layui-upload-file\" style=\"position:relative;width:160px;height:160px;top:0;left:0;z-index:999;opacty:0;\"/>" 
	   		            src1+="</div>"
	   		            src1+="<div class=\"frm-col-8\" style=\"height:160px; width:180px; position: relative; margin-left:2px; border:1px solid black; float:left;margin-top:22px;\">"
				        src1+="<div id=\"PreviewDiv"+count+"\"  style=\"width:180px;height:160px; position:absolute; margin-right:1px;overflow: hidden;\">"
				        src1+="<img id=\"PreviewImg"+count+"\"  src=\"\" onerror=\"this.src='common/pictures/01.jpg'\" style=\"width: 180px;height:160px\">"
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
	                      $("#cs").empty();
						  var fylx=$('#fylx').val();
						  var lsh=$('#ince-lsh').val();
						$.ajax({
						url:'govPhoto.do?method=selectGovPhotoListzp&lsh='+lsh+'&zplx='+fylx+'&t='+new Date().getTime(),
						async:false,
						dataType:'json',
						success:function(rlt){
						    var stringdiv="";
						    $('#je').val('0');
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
						});    
				});
	  </script>
	</body>
</html>
