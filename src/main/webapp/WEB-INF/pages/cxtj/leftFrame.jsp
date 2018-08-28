<%@ page import="com.zlkj.pub.webutils.Constant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>统计信息</title>
		<meta name="renderer" content="webkit">
		 <meta http-equiv="pragma" content="no-cache">  
		<meta http-equiv="cache-control" content="no-cache">  
		<meta http-equiv="expires" content="0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		
		<link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="frm/css/frmColors.css" type="text/css">
		<link rel="stylesheet" href="frm/css/global.css" media="all">
		<link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">
		<script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
		<script type="text/javascript" src="common/js/translation.js"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.GLBMJS_NAME%>"></script>
		<script type="text/javascript" src="<%=Constant.JS_RELATIVE_PATH%><%=Constant.CODEJS_NAME%>"></script>
		<script type="text/javascript" src="common/js/pagekey.js"></script>
		<script src="common/js/echarts-all.js"></script>
		<script type="text/javascript">
		layui.config({
			base: '',
			version: new Date().getTime()
		}).extend({
			paging:'frm/js/paging',
		}).use(['element','laydate','paging'], function() {
		var $ = layui.jquery;
		$(function(){
			alltjtb();
		})
		function alltjtb(){
				mainvehf("mainVeh","main.do?method=getVehListEcharts","机动车状态","bar");
 				maindrvf("mainDrv","main.do?method=getDrvListEcharts","驾驶人状态","pie");
//  				mainflowf("mainFlow","main.do?method=getflowListEcharts","业务办结统计","gauge");
 				maincarf("mainCar","main.do?method=getObjectListEcharts","公车使用","line");
		}	
		window.onresize=function (){
			alltjtb();
		}
		function eConsole(param){
			var par=param.data.namezt;
			var bj=param.data.listbj;
			var condition ='&ymmc=tjlb_list&paras='+par+'&bj='+bj;
			layer.open({
				type: 2,
				id:'ReqEdit',
				content:['main.do?method=forwardPage'+condition],
				title: '详细信息列表', /*<i class="fa fa-user" style="font-size:18px;color:#1AA094;"></i> */
				shade: 0.2,
				offset: ['30px', '15%'],
				area: ['1000px', '500px'],
				zIndex: 10000000,
				moveOut: true,
				maxmin: false,
				btn: 0 	//['新增','保存', '取消']
			});
		}
		function mainvehf(id,url,tex,lx){
		    var url=url+"&t="+new Date().getTime();
		    var json1,json2;
		    $.ajax({
		      url:url,
		      async:false,
		      dataType:"json",
		      success:function(data){
				        json1=data.list1;
				        json2=data.list2;
		      }
		    });
		    var myChart = echarts.init(document.getElementById(id)); 
		    var ecConfig=echarts.config;
// 		    myChart.on(ecConfig.EVENT.DBLCLICK, eConsole) 
        	myChart.on(ecConfig.EVENT.CLICK, eConsole); 
		    option = {
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    title: {
			        x: 'center',
			        text: '机动车状态统计',
			        textStyle:{
			        	fontSize: 13,
			        	fontWeight: '500'
			        }
			    },
			    legend: {
			      orient : 'vertical',
			        x : 'left',
			        y : '30px',
			        data:json1
			    },
			    series : [
			        {
			            name:'机动车状态',
			            type:'pie',
			            radius :['10%', '60%'],
			            center : ['50%', '50%'],
			            roseType : 'radius',
			            width: '40%',       // for funnel
			            itemStyle : {
			                normal : {
			                    label : {
			                        show : false
			                    },
			                    labelLine : {
			                        show : false
			                    }
			                }
			             
			            },
			            data:json2
			        }
			       
			    ]
			};
        	myChart.setOption(option);
		}
		function maindrvf(id,url,tex,lx){
			var url=url+"&t="+new Date().getTime();
		    var json1,json2;
		    $.ajax({
		      url:url,
		      async:false,
		      dataType:"json",
		      success:function(data){
				        json1=data.list1;
				        json2=data.list2;
		      }
		    });
		    var myChart = echarts.init(document.getElementById(id));
		     var ecConfig=echarts.config;
// 		    myChart.on(ecConfig.EVENT.DBLCLICK, eConsole) 
        	myChart.on(ecConfig.EVENT.CLICK, eConsole);
			option = {
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    title: {
			        x: 'center',
			        text: '驾驶人状态统计',
			        textStyle:{
			        	fontSize: 13,
			        	fontWeight: '500'
			        }
			    },
			    legend: {
			        orient : 'vertical',
			        x : 'left',
			        y : '30px',
			        data:json1
			    },
			    series : [
		        {
		            name:tex,
		            type:'pie',
		            radius : ['40%', '60%'],
		            itemStyle : {
		                normal : {
		                    label : {
		                        show : false
		                    },
		                    labelLine : {
		                        show : false
		                    }
		                },
		                emphasis : {
		                    label : {
		                        show : true,
		                        position : 'center',
		                        textStyle : {
		                            fontSize : '20',
		                            fontWeight : 'bold'
		                        }
		                    }
		                }
		            },
		            data:json2
		        }
		        ]
			};
			myChart.setOption(option);
		}	
		function maincarf(id,url,tex,lx){
		    var url=url+"&t="+new Date().getTime();
		    var json1,json2;
		    $.ajax({
		      url:url,
		      async:false,
		      dataType:"json",
		      success:function(data){
				        json1=data.list2;
				        json2=data.list1;
		      }
		    });
		    var myChart = echarts.init(document.getElementById(id)); 
  		    var ecConfig=echarts.config;
        	myChart.on(ecConfig.EVENT.CLICK, eConsole);
		    var option = {
	            tooltip: {
	                show: true,
	                trigger: 'axis'
	            },
	            title: {
			        x: 'center',
			        text: '公车使用情况统计',
			        textStyle:{
			        	fontSize: 13,
			        	fontWeight: '500'
			        }
			    },
	            legend: {
	            	x:'left',
	                data:[tex]
	            },
	            xAxis : [
	                {
	                    type : 'category',
	                    axisLabel:{
		                  rotate:45,
		              	},
	                    data : json2
	                }
	            ],
	            grid: { // 控制图的大小，调整下面这些值就可以，
		             y2: 80// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
	      		},
	            yAxis : [
	                {
	                    type : 'value'
	                }
	            ],
	            series : [
	                {
	                    name:tex,
	                    type:lx,
	                    itemStyle: {
				                normal: {
				                    color: function(params) {
				                        var colorList = [
				                          '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
				                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD'
				                        ];
				                        return colorList[params.dataIndex]
				                    }
				                }
	            		},
	                    data:json1
	                }
	            ]
	        };
        	myChart.setOption(option);
		}
// 		function mainflowf(id,url,tex,lx){
// 			var url=url+"&t="+new Date().getTime();
// 		    var json1,json2,json3,name1,name2,name3;
// 		    $.ajax({
// 		      url:url,
// 		      async:false,
// 		      dataType:"json",
// 		      success:function(data){
// 				        json1=data[0];
// 				        json2=data[1];
// 				        json3=data[2];
// 				        name1=json1.name;
// 				        name2=json2.name;
// 				        name3=json3.name;
// 		      }
// 		    });
// 		    var myChart = echarts.init(document.getElementById(id));
// 		    var ecConfig=echarts.config;
//         	myChart.on(ecConfig.EVENT.CLICK, eConsole);
// 			option = {
// 			    tooltip : {
// 			        formatter: "{c} "
// 			    },
// 			    title: {
// 			        x: 'center',
// 			        text: '办结业务统计',
// 			        textStyle:{
// 			        	fontSize: 13,
// 			        	fontWeight: '500'
// 			        }
// 			    },
// 			    series : [
// 			        {
// 			            name:name1,
// 			            type:lx,
// 			           	center : ['50%', '50%'],    // 默认全局居中
// 			          	radius : ['40%', '50%'] ,
// 			          	axisLine: {            // 坐标轴线
// 			                lineStyle: {       // 属性lineStyle控制线条样式
// 			                    width: 2
// 			                }
// 			            },
// 			            axisTick: {            // 坐标轴小标记
// 			                length :4,        // 属性length控制线长
// 			                lineStyle: {       // 属性lineStyle控制线条样式
// 			                    color: 'auto'
// 			                }
// 			            },
// 			            splitLine: {           // 分隔线
// 			                length :6,         // 属性length控制线长
// 			                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
// 			                    color: 'auto'
// 			                }
// 			            },
// 			            pointer: {
// 			                width:2
// 			            },
// 			            title:{
// 				            textStyle: {
// 						        color: '#333',
// 						        fontSize : 10
// 						    }
// 			            },
// 			            detail : {
// 			            	height: 20,
// 			                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
// 			                    fontWeight: 'bolder',
// 			                    color:'red',
// 			                 	fontSize : 15
// 			                }
// 			            },
// 			            axisLabel:{
// 			            	show: true,
// 						    formatter: null,
// 						    textStyle: {
// 						    	fontSize : 12,
// 						        color: 'auto'
// 						    }
// 			            },
// 			            data:[json1]
// 			        },
// 			        {
// 			            name:name2,
// 			            type:lx,
// 			            center : ['18%', '50%'],    // 默认全局居中
// 			          radius : '50%',
// 			          endAngle:30,
// 			         	startAngle:330,
// 			         	axisLine: {            // 坐标轴线
// 			                lineStyle: {       // 属性lineStyle控制线条样式
// 			                    width: 2
// 			                }
// 			            },
// 			            axisTick: {            // 坐标轴小标记
// 			                length :4,        // 属性length控制线长
// 			                lineStyle: {       // 属性lineStyle控制线条样式
// 			                    color: 'auto'
// 			                }
// 			            },
// 			            splitLine: {           // 分隔线
// 			                length :6,         // 属性length控制线长
// 			                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
// 			                    color: 'auto'
// 			                }
// 			            },
// 			            pointer: {
// 			                width:2
// 			            },
// 			            title:{
// 				            textStyle: {
// 						        color: '#333',
// 						        fontSize : 10
// 						    }
// 			            },
// 			            detail : {
// 			            	height: 20,
// 			                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
// 			                    fontWeight: 'bolder',
// 			                    color:'red',
// 			                 	fontSize : 15
// 			                }
// 			            },
// 			            axisLabel:{
// 			            	show: true,
// 						    formatter: null,
// 						    textStyle: {
// 						    	fontSize : 12,
// 						        color: 'auto'
// 						    }
// 			            },
// 			            data:[json2]
// 			        },
// 			      {
// 			            name:name3,
// 			            type:lx,
// 			            center : ['82%', '50%'],    // 默认全局居中
// 			        	radius : ['40%', '50%'] ,    
// 			        	endAngle:-150,
// 			         	startAngle:150,
// 			         	axisLine: {            // 坐标轴线
// 			                lineStyle: {       // 属性lineStyle控制线条样式
// 			                    width: 2
// 			                }
// 			            },
// 			            axisTick: {            // 坐标轴小标记
// 			                length :4,        // 属性length控制线长
// 			                lineStyle: {       // 属性lineStyle控制线条样式
// 			                    color: 'auto'
// 			                }
// 			            },
// 			            splitLine: {           // 分隔线
// 			                length :6,         // 属性length控制线长
// 			                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
// 			                    color: 'auto'
// 			                }
// 			            },
// 			            pointer: {
// 			                width:2
// 			            },
// 			            title:{
// 				            textStyle: {
// 						        color: '#333',
// 						        fontSize : 10
// 						    }
// 			            },
// 			            detail : {
// 			            	height: 20,
// 			                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
// 			                    fontWeight: 'bolder',
// 			                    color:'red',
// 			                 	fontSize : 15
// 			                }
// 			            },
// 			            axisLabel:{
// 			            	show: true,
// 						    formatter: null,
// 						    textStyle: {
// 						    	fontSize : 12,
// 						        color: 'auto'
// 						    }
// 			            },
// 			            data:[json3]
// 			        }
			        
// 			    ]
// 			};
// 			myChart.setOption(option);
// 		}
		});
		</script>
	</head>
	<body>
		<ul class="layui-nav" style="height:30px;background-color:#3c8dbc;margin-right: 1px;margin-top: 2px;">
		 <li style="line-height: 30px;">业务统计信息</li>
		</ul>
		<div style="height:auto;border:0px solid gray;" class="frm-row">
				<div id="" style="width:50%;height:auto;border: 1px solid #99BBE8;margin-top: 5px;border-right: 0px;margin-left: 2px;" class="frm-col-12">
						<div id="" style="width:99%;height:260px;float: right;border: 0px solid gray;"><div id="mainVeh" style="height:250px;min-width: 200px;max-width:99%;"></div></div>
				</div>
				<div id="" style="width:49%;height:auto;border: 1px solid #99BBE8;margin-top: 5px;" class="frm-col-12">
						<div id="" style="width:99%;height:260px;float: right;border: 0px solid gray;"><div id="mainDrv" style="height:250px;min-width: 200px;max-width:99%;"></div></div>
				</div>
<!-- 				<div id="" style="width:33%;height:auto;border: 1px solid #99BBE8;margin-top: 5px;border-left: 0px;" class="frm-col-8"> -->
<!-- 					<div id="" style="width:99%;height:260px;float: right;border: 0px solid gray;"><div id="mainFlow" style="height:250px;min-width: 200px;max-width:99%;"></div></div> -->
<!-- 				</div> -->
				
			</div>	
			<div style="height:auto;border:0px solid gray;" class="frm-row">
				<div id="" style="width:99%;height:auto;float:left;border: 1px solid #99BBE8;margin-top: 5px;margin-left: 2px;" class="frm-col-24">
<!-- 						<div id="" style="background-color: #3c8dbc;height:30px;border-bottom:solid 1px #D7DBE2;line-height:30px;">&nbsp;&nbsp;单位公车使用统计</div> -->
						<div id="" style="width:100%;height:auto;float: right;border: 0px solid gray;"><div id="mainCar" style="height:300px;min-width: 400px;max-width:99%;"></div></div>
				</div>
			</div>
		
		
	</body>
</html>
