<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>限行参数</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		
		<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="frm/css/global.css" media="all">
		<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="frm/css/table.css" />
		<link rel="stylesheet" href="common/js/zTree_v3-master/css/zTreeStyle/zTreeStyle.css">
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript">
			layui.config({
				base: '',
				version: new Date().getTime()
			}).extend({
				paging:'frm/js/paging',
				hrefTools:'common/js/hrefTools',
				domTools:'common/js/domTools',
				jqueryform:	'common/js/jquery.form',
				ajaxTools:'common/js/ajaxTools'
			}).use(['element','laydate','paging','form','tree','ajaxTools','hrefTools','domTools','jqueryform'], function() {
				var $ = layui.jquery,
				paging = layui.paging(),
				layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
				layer = layui.layer, //获取当前窗口的layer对象
				form = layui.form(),
				hrefTools = layui.hrefTools,
				domTools=layui.domTools,
				ajaxTools = layui.ajaxTools;
				//关闭按钮
				$('#car-close').on('click',function(){
					top.closeTab(hrefTools.getLocationParam('cxdh'));
				});
			     //设置日志类型的样式
			   	$(function(){
			   		getxxwh();
 			   		getLimitList();
			   	})
			    function getxxwh(){
			    	$.ajax({
						url:'govVehLimitLine.do?method=getFunWh',	//如果url为空，则默认查询code
						async:false,
						dataType:'json',
						success:function(rlt){
							var rt="今日限行车辆尾号：";
							if(rlt==null){
							$('#xxid').html("<font style=\"font-size:18px;\">"+rt+"无</font>");
							}else{
							$('#xxid').html("<font style=\"font-size:18px;\">"+rt+rlt+"</font>");
							}
						}
					});
			    }
				function getLimitList(){
					paging.init({
						url: 'govVehLimitLine.do?method=getGovVehLimitList&t='+new Date().getTime(), //地址
						elem: '#content', //内容容器
// 						params: '', //发送到服务端的参数
						type: 'POST',
						tempElem: '#tpl', //模块容器
						pageConfig: { //分页参数配置
							elem: '#paged', //分页容器
							pageSize: 10 //分页大小
						},
						complate: function() { //完成的回调
						form.render();
						}
					})
				};
				form.on('switch(fiterzt)', function(data){
					if(data.elem.id=="ztid1"){
						if(data.elem.checked){
							$("#ztid2").attr("checked",false);
						}
					}else{
						if(data.elem.checked){
							$("#ztid1").attr("checked",false);
						}
					}
					form.render('checkbox','fiterzt');
				})
				$('#car-save').on('click', function() {
				    var xh=""; var flag=true;
					if($(".ztdiv:checked").val()!=undefined){
						xh=$(".ztdiv:checked").val();
					}else{
						layer.alert('请选择限行规则', {icon: 7});
						return;
					}
					getAll($('#xxrqq').val(),$('#xxrqz').val(),'xxrq',flag);
					if(!flag){return;}
					getAll($('#gzrqq').val(),$('#gzrqz').val(),'gzrq',flag);
					if(!flag){return;}
					$(mainForm).ajaxSubmit({
							type:'POST',
							url:'govVehLimitLine.do',
							data:{
								method:'saveLimitline',
								cxdh:'010209',
								gnid:'01020901',
								xh:xh,
							},
							dataType:'json',
							success:function(rlt){
								if(rlt.code=='1'){
									layer.alert(rlt.mess, {icon: 6});
								}else{
									layer.alert(rlt.mess, {icon: 5});
								}
                             }
						});
				})
				
			 Date.prototype.format = function() {  
		     	  var s = '';  
			      var mouth = (this.getMonth() + 1)>=10?(this.getMonth() + 1):('0'+(this.getMonth() + 1));  
			      var day = this.getDate()>=10?this.getDate():('0'+this.getDate());  
			      s += this.getFullYear() + '-'; // 获取年份。  
			      s += mouth + "-"; // 获取月份。  
			      s += day; // 获取日。  
			      return (s); // 返回日期。  
			  };  
			  function getAll(begin, end,id,flag) {  
			      var ab = begin.split("-");  
			      var ae = end.split("-");  
			      var db = new Date();
			      var times="";  
			      db.setUTCFullYear(ab[0], ab[1] - 1, ab[2]);  
			      var de = new Date();  
			      de.setUTCFullYear(ae[0], ae[1] - 1, ae[2]);  
			      var unixDb = db.getTime();  
			      var unixDe = de.getTime(); 
			      if(unixDe-unixDb<0){
			      	alert("时间止不能小于时间起");
			      	flag=false;
			      	return;
			      } 
			      for (var k = unixDb; k <= unixDe;) { 
			      	  times+=(new Date(parseInt(k))).format()+",";
			          k = k + 24 * 60 * 60 * 1000;  
			      }
			      $("#"+id).val(times);
			   }
			});
		</script>
	</head>
	<body>
				<div class="admin-main">
				<form class="layui-form" id="mainForm" name="mainForm" method="post">
					<input type="hidden" name="xxrq" id="xxrq" value="">
					<input type="hidden" name="gzrq" id="gzrq" value="">
					<div class="frm-row" id="xxid">
					</div>
					<div style="font-size: 18px;margin-top: 10px;"> 限行规则</div>
					<fieldset class="layui-elem-field">
						<div class="layui-field-box layui-form">
							<table id="theadTable" class="layui-table admin-table">
								<thead>
									<tr id="b">
										<th style="width:25%">序号</th>
										<th style="width:25%">限行名称</th>
										<th style="width:25%">限行规则</th>
										<th style="width:25%">是否启用</th>
									</tr>
								</thead>
							</table>
							<div id="contentDiv">
								<table id="tbodyTable" class="layui-table admin-table">
									<tbody id="content">
									</tbody>
								</table>
							</div>
						</div>
					</fieldset>
					<div class="admin-table-page">
						<div id="paged" class="page">
						</div>
					</div>
					<div class="frm-row" style="line-height: 30px;">
						<div class="frm-col-2" >节假日维护</div>
						<div class="frm-col-2" style="text-align: right;">时间起&nbsp;&nbsp;</div>
						<div class="frm-col-3">
							<input type="text" id="xxrqq"  placeholder="请编写如1990/11/11 12:12:12" value="" class="layui-input" onclick="layui.laydate({elem: this,istime: true})">
						</div>
						<div class="frm-col-2" style="text-align: right;">时间止&nbsp;&nbsp;</div>
						<div class="frm-col-3">
							<input type="text" id="xxrqz"  placeholder="请编写如1990/11/11 12:12:12" value="" class="layui-input" onclick="layui.laydate({elem: this,istime: true})">
						</div>
						
					</div>
					<div class="frm-row" style="line-height: 30px;">
						<div class="frm-col-2" >工作日维护</div>
						<div class="frm-col-2" style="text-align: right;">时间起&nbsp;&nbsp;</div>
						<div class="frm-col-3">
							<input type="text" id="gzrqq"  placeholder="请编写如1990/11/11 12:12:12" value="" class="layui-input" onclick="layui.laydate({elem: this,istime: true})">
						</div>
						<div class="frm-col-2" style="text-align: right;">时间止&nbsp;&nbsp;</div>
						<div class="frm-col-3">
							<input type="text" id="gzrqz"  placeholder="请编写如1990/11/11 12:12:12" value="" class="layui-input" onclick="layui.laydate({elem: this,istime: true})">
						</div>
					</div>
					<div class="frm-row">
					<div class="frm-col-23" style="text-align: right">
						<a href="javascript:;" class="layui-btn layui-btn-small" id="car-save" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#xe605;</i> 保存</a>
						<a href="javascript:;" class="layui-btn layui-btn-small" id="car-close" style="background: #4F98C2;color:#FEFEFE"><i class="layui-icon" >&#x1006;</i> 关闭</a>
				    </div>
				  </div>
				</form>
				</div>
		
		<script type="text/html" id="tpl">
			{{# layui.each(d.list, function(index, item){ }}
			<tr>
				<td style="width:25%">{{item.xh}}</td>
				<td style="width:25%">{{ item.mc }}</td>
				<td style="width:25%">{{ item.gz }}</td>
				<td style="width:25%">
					<input type="checkbox" id="ztid{{index+1}}" class="ztdiv"  lay-filter="fiterzt" value="{{item.xh}}"  lay-skin="switch" lay-text="是|否" {{ item.zt==1?'checked=true':'' }}>
				</td>
			</tr>
			{{# }); }}
		</script>
	</body>
</html>
