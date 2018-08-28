<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>日志管理</title>
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
			<style type="text/css">
			.layui-elem-quote{
				padding: 9px 10px;
			}
			.veh-query-form .layui-input{
				display: inline-block;
			}
			.veh-query-form label{
				padding: 9px 4px 9px 9px;
				vertical-align: middle; 
			}
			.veh-query-form .layui-btn{
				float: right;
				margin-left: 10px;
			}
			.veh-query-form .layui-form-checkbox,.veh-query-form .layui-form-switch{
				margin: 0;
			}
			.frm-label{
			  line-height:18px;
			}
		</style>
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
				glbmSelectByZTree:'common/js/glbmSelectByZTree',
				ajaxTools:'common/js/ajaxTools'
			}).use(['element','laydate','paging','form','tree','ajaxTools','hrefTools','domTools','glbmSelectByZTree'], function() {
			   
				var $ = layui.jquery,
				paging = layui.paging(),
				layerTips = parent.layer === undefined ? layui.layer : parent.layer, //获取父窗口的layer对象
				layer = layui.layer, //获取当前窗口的layer对象
				form = layui.form(),
				hrefTools = layui.hrefTools,
				domTools=layui.domTools,
				ajaxTools = layui.ajaxTools;
				 	//让表头隐藏
				$('#a').hide();
				$('#b').hide();
				
					//日志类型加载
				ajaxTools.loadCodeDataKK($('#ue-rzlx'),{dmmc:'rzlx'},false,'','code.do?method=selectListCode','请选择日志类型');
				form.render('select');
				//总日志类型加载
				ajaxTools.loadCodeDataKK($('#zul-rzlx'),{dmmc:'czrzlx'},false,'','code.do?method=selectListCode','请选择总日志类型');
				 $("#zul-rzlx  option[value='B'] ").attr("selected",true)
				form.render('select');
				
				//程序功能加载
				//ajaxTools.loadProgram($('#ue-cxid'),false);
				ajaxTools.loadCodeDataKK($('#ue-cxid'),'',false,'','code.do?method=getProgramListJson','请选择程序功能')
				form.render('select')
				var glbmSelectByZTree = layui.glbmSelectByZTree({bgColor:'#F9FAFC',area:['300px','300px'],data:{rootBmdm:$('#curr-user-glbm').val()}});
				//管理部门选择下拉框事件
				$('#us-glbm').on('click',function(){
					glbmSelectByZTree.show($('#us-glbm'),function(event, treeId, treeNode){
						$('#us-glbm').val(treeNode.name);
						$('#hidden-us-glbm').val(treeNode.tags.glbm);
						reloadYhdh();
					});
				});
				//用户代号初次加载
				reloadYhdh();
				
				function reloadYhdh(){
					ajaxTools.loadCodeDataKK($('#ue-yhdh'),{glbm:$('#hidden-us-glbm').val(),bhxj:0},false,'','code.do?method=getUserJson','请选择用户');
					form.render('select');
				}
				
				//关闭按钮
				$('#close').on('click',function(){
					top.closeTab(hrefTools.getLocationParam('cxdh'));
				});
			
				
				//查询按钮
				$('#query').on('click',function(){
					queryuserList();
				});
	
				//重置按钮
				$('#reset').on('click',function(){
					$('#us-glbm').val('');
					$('#hidden-us-glbm').val('');
					$('#ue-yhdh').val('');
					$('#ue-rzlx').val('');
					$('#ue-cxid').val('');
					$('#ue-kssj').val('');
					$('#ue-jssj').val('');
					form.render();
				});
			     //设置日志类型的样式
			      $('#ue-rzlx').attr('disabled',false);
			      form.render();
				function queryuserList(){
					var bj=$('#zul-rzlx').val();
					var params = {};
					var url="";
					//A业务日志   B系统日志
					if(bj=="A"){
					  params.glbm = $('#hidden-us-glbm').val();
					  params.cxdh= $('#ue-cxid').val();
					  params.jbr=$('#ue-yhdh').val();
					  params.clrq= $('#ue-jssj').val();
					  params.kssj = $('#ue-kssj').val();
					  params.jssj = $('#ue-jssj').val();
					  url='govlog.do?method=ywgetgovLogListPage';
					  tpl="tplA";
					  $('#ue-rzlx').attr('disabled',true);
					  form.render();
					  $('#a').show();
					  $('#b').hide();
					}else if(bj=="B"){
					  $("#ue-cxid").val();
					 $('#ue-rzlx').attr('disabled',false);
					 form.render();
					 params.glbm = $('#hidden-us-glbm').val();
					 params.yhdh=$('#ue-yhdh').val();
					 params.rzlx=$('#ue-rzlx').val();
					 params.cxid = $('#ue-cxid').val();
					 params.kssj = $('#ue-kssj').val();
					 params.jssj = $('#ue-jssj').val();
			          url='logs.do?method=getlogListPage';
			          tpl="tplB";
			          $('#b').show();
			          $('#a').hide();
					}
					queryDrvList(url,params,bj)
					
			     }
				function queryDrvList(url,params,bj){
					paging.init({
						url: url, //地址
						elem: '#content', //内容容器
						params: params, //发送到服务端的参数
						type: 'POST',
						tempElem: '#'+tpl, //模块容器
						pageConfig: { //分页参数配置
							elem: '#paged', //分页容器
							pageSize: 10 //分页大小
						},
						complate: function() { //完成的回调
						//$(window).off('resize',domTools.resizeTableHeight).on('resize', domTools.resizeTableHeight).resize();
						}
					})
					
			};
			});
		</script>
	</head>
	<body>
	    <input type="hidden" id="curr-user-glbm" value="${userSession.dep.glbm }">
		<input type="hidden" id="hidden-us-glbm">
	    <input type="hidden" id="bj" name="bj" value="${bj}"/>
				<div class="admin-main">
					<form class="layui-form" action="">
				<blockquote class="layui-elem-quote veh-query-form">
					<div class="frm-row">
						<label class="frm-label frm-col-2">管理部门</label>
						<div class="frm-col-3" >
							<input type="text" id="us-glbm"  name="glbm" readonly placeholder="请选择管理部门" class="layui-input">
						</div>
						
						<label class="frm-label frm-col-3">用户代号</label>
						<div class="frm-col-3">
						       <select id="ue-yhdh" >
						         <option value="">请选择</option>
							   </select>
						</div>
						
							<label class="frm-label frm-col-3">总日志类型</label>
						<div class="frm-col-3">
						       <select id="zul-rzlx">
						         <option value="">请选择</option>
							   </select>
						</div>
						
						<label class="frm-label frm-col-3">程序功能</label>
						<div class="frm-col-3">
						       <select id="ue-cxid" name="cxid" lay-search="" >
						         <option value="">请选择</option>
							   </select>
						</div>
						
					</div>
					
					<div class="frm-row">
					
						<label class="frm-label frm-col-2">起始时间</label>
						<div class="frm-col-3">
							<input class="layui-input" id="ue-kssj"  onclick="layui.laydate({elem: this})"  type="text" placeholder="请编写如1990-11-11" autocomplete="off" lay-verify="date">
						</div>
						<label class="frm-label frm-col-3">截止时间</label>
						<div class="frm-col-3">
							<input class="layui-input" id="ue-jssj" onclick="layui.laydate({elem: this})"  type="text" placeholder="请编写如1990-11-11" autocomplete="off" lay-verify="date">
						</div>
						
						<label class="frm-label frm-col-3">日志类型</label>
						<div class="frm-col-3">
						       <select id="ue-rzlx" name="rzlx" disabled="">
						         <option value="">请选择</option>
							   </select>
						</div>
						
						
						<div class="frm-col-6">
							<a href="javascript:;" class="layui-btn layui-btn-small" id="close"><i class="layui-icon" >&#x1006;</i> 关闭</a>
							<a href="javascript:;" class="layui-btn layui-btn-small" id="reset"><i class="layui-icon" >&#xe609;</i> 重置</a>
							<a href="javascript:;" class="layui-btn layui-btn-small" id="query"><i class="layui-icon" >&#xe615;</i> 查询</a>
						</div>
					</div>
				</blockquote>
			</form>
				<fieldset class="layui-elem-field">
					<div class="layui-field-box layui-form">
						<table id="theadTable" class="layui-table admin-table">
							<thead>
								<c:if test="${bj==B }" >
								<tr id="b">
									<th style="width:4%">序号</th>
									<th style="width:6%">日志类型</th>
									<th style="width:5%">用户代号</th>
									<th style="width:8%">姓名</th>
									<th style="width:8%">管理部门</th>
									<th style="width:6%">程序功能</th>
									<th style="width:9%">功能名称</th>
									<th style="width:13%">日志信息</th>
									<th style="width:10%">日志时间</th>
								</tr>
								</c:if>
								
								<c:if test="${bj==A }" >
								<tr id="a">
									<th style="width:4%">序号</th>
									<th style="width:10%">流水号</th>
									<th style="width:10%">程序功能</th>
									<th style="width:10%">功能名称</th>
									<th style="width:8%">号牌号码</th>
									<th style="width:12%">管理部门</th>
									<th style="width:10%">日志时间</th>
									<th style="width:10%">经办人</th>
									<th style="width:20%">日志信息</th>
								</tr>
								</c:if>
								
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
				</div>
				
		<script type="text/html" id="tplB">
			{{# layui.each(d.list, function(index, item){ }}
			<tr >
                <td style="width:4%">{{ index+1 }}</td>
				<td style="width:6%">{{ formateRzlx(item.rzlx) }}</td>
				<td style="width:5%">{{ item.yhdh }}</td>
				<td style="width:8%">{{ item.xm }}</td>
				<td style="width:8%">{{ formateGlbm_jc(item.glbm) }}</td>
				<td style="width:6%">{{ item.cxid==null?'':item.cxid }}</td>
				<td style="width:9%">{{ item.gnid==null?'':item.gnid }}</td>
				<td style="width:13%">{{ item.rzxx }}</td>
				<td style="width:10%">{{ formateLongDate(item.rzsj) }}</td>
			</tr>
			{{# }); }}
		</script>
		
		<script type="text/html" id="tplA">
			{{# layui.each(d.list, function(index, item){ }}
			<tr>
				<td style="width:4%">{{index+1}}</td>
				<td style="width:10%">{{ item.lsh }}</td>
				<td style="width:10%">{{ item.cxdh==null?'':item.cxdh }}</td>
				<td style="width:10%">{{ item.gnid==null?'':item.gnid }}</td>
                <td style="width:8%">{{ item.hphm}}</td>
				<td style="width:12%">{{formateGlbm(item.glbm)}}</td>
				<td style="width:10%">{{ formateLongDate(item.clrq)}}</td>
				<td style="width:10%">{{ item.jbr}}</td>
                <td style="width:20%">{{ item.rznr }}</td>
			</tr>
			{{# }); }}
		</script>
	</body>
</html>
