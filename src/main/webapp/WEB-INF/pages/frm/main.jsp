<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>


<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link rel="stylesheet" href="frm/plugins/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="frm/css/frmColors.css" type="text/css">
    <link rel="stylesheet" href="frm/css/global.css" media="all">
    <link rel="stylesheet" href="frm/plugins/font-awesome/css/font-awesome.min.css">

    <style type="text/css">
        #admin-body > div.layui-tab {
            margin-bottom: 0;
        }
    </style>

</head>

<body>
<input type="hidden" id="ttp" value="">
<input type="hidden" id="spdiv" value="">
<input type="hidden" id="shdiv" value="">
<div class="layui-layout layui-layout-admin" style=""><!-- border-bottom: solid 5px #1aa094; -->
    <div class="layui-header header header-demo">
        <div class="layui-main">
            <div class="admin-login-box">
                <a class="logo" style="left: 0;" href="javascript:;">
                    <img src="frm/images/toptitle.png">
                </a>
            </div>
            <ul class="layui-nav not-bottom-hover-bar admin-header-item">
                <li class="layui-nav-item smallIconMenu" id="downList">
                    <a href="javascript:;"><i class="fa fa-cloud-download"></i><span
                            class="numTips downListNum">0</span></a>

                    <div id="downList-div" class="layui-hide">
                        <div class="downList-tip">
                            当前有0个可下载项
                        </div>
                        <div class="downList-lis">
                            <ul></ul>
                        </div>
                    </div>
                </li>
                <li class="layui-nav-item smallIconMenu">
                    <a href="javascript:;"><i class="fa fa-bell-o"></i><span class="numTips bellNum">0</span></a>
                </li>
                <li class="layui-nav-item smallIconMenu" id="">
                    <a href="javascript:;"><i class="fa fa-flag-o"></i><span class="numTips flagNum">0</span></a>
                </li>
                <li class="layui-nav-item" id="userLoginInfo">
                    <a href="javascript:;" class="admin-header-user">
                        <img class="userHeadPortrait" src="frm/images/noSex.png"/>
                        <img id="ie8-top-head-small" style="position: absolute;top: 9px;left: 20px;"
                             src="frm/images/ie8-top-head-small.png">
                        <span class="loginUName"></span>
                    </a>
                    <div class="layui-hide userInfoDiv">
                        <div>
                            <img class="userHeadPortrait" src="frm/images/noSex.png"/>
                            <p><span class="loginUName"></span> - <span class="loginUBMJC"></span></p>
                            <span class="loginUYHYXQ"></span><br>
                            <span class="loginUMMYXQ"></span>
                        </div>
                        <button id="changeUserImgBtn" class="layui-btn  layui-btn-small">更换头像</button>
                        <button id="changeUserPwd" class="layui-btn  layui-btn-small">修改密码</button>
                        <button id="userLogout" class="layui-btn  layui-btn-small">注销登录</button>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="layui-side layui-bg-white own-side-layout-extend" id="admin-side">
        <div id="user-info">
            <img class="left-menus-toggle userHeadPortrait" src="frm/images/noSex.png">
            <img id="ie8-left-head-png" class="left-menus-toggle" style="position: absolute;top: 0px;left: 0px;"
                 src="frm/images/ie8-left-head.png">
            <div class="limg">
                <p class="loginUName"></p>
                <span>
                            <i class="fa fa-circle"></i> <span class="loginUSfGLY">管理员</span><br>
                            <i class="fa fa-circle"></i> 在线人数 :1
                        </span>
            </div>
            <div id="menus-tip">程序菜单</div>
        </div>
        <div id="left-menus">
            <div class="layui-side-scroll" id="admin-navbar-side" lay-filter="side"></div>
        </div>
    </div>
    <div class="layui-body" style="bottom: 0;border-left: solid 2px #3C8DBC;" id="admin-body">
        <div class="layui-tab admin-nav-card layui-tab-brief" lay-filter="admin-tab">
            <ul class="layui-tab-title">
                <li class="layui-this" id="deskTabTitle">
                    <i class="fa fa-dashboard" aria-hidden="true"></i>
                    <cite>我的桌面</cite>
                </li>
            </ul>
            <div class="layui-tab-content" style="min-height: 150px; padding: 0 0 0 0;">
                <div class="layui-tab-item layui-show">
                    <iframe frameborder="0" id='deskTab' src="forwardMenu?ymmc=mainInner"
                            scrolling='no'></iframe>
                    <!-- <iframe frameborder="0" src="menu.do?method=forwardMenu&cxdh=010103&ymmc=frm/user"></iframe> -->
                </div>
            </div>
        </div>
    </div>
    <!-- <div class="layui-footer footer footer-demo" id="admin-footer">
        <div class="layui-main">
            <p>2016 &copy;
                <a href="http://m.zhengjinfan.cn/">m.zhengjinfan.cn/</a> LGPL license
            </p>
        </div>
    </div> -->
    <div class="site-tree-mobile layui-hide">
        <i class="layui-icon">&#xe602;</i>
    </div>
    <div class="site-mobile-shade"></div>

    <!--锁屏模板 start-->
    <script type="text/template" id="lock-temp">
        <div class="admin-header-lock" id="lock-box">
            <div class="admin-header-lock-img">
                <img src="images/0.jpg"/>
            </div>
            <div class="admin-header-lock-name" id="lockUserName">beginner</div>
            <input type="text" class="admin-header-lock-input" value="输入密码解锁.." name="lockPwd" id="lockPwd"/>
            <button class="layui-btn layui-btn-small" id="unlock">解锁</button>
        </div>
    </script>
    <!--锁屏模板 end -->

    <script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
    <script src="frm/js/index.js"></script>
    <script type="text/javascript">
        function countSecond() {
            document.getElementById("ttp").click();
            setTimeout("countSecond()", 180000)
        }

        countSecond()

        function xqspsh(bj) {
            if (bj == "1") {
                document.getElementById("spdiv").click();
            } else {
                document.getElementById("shdiv").click();
            }
        }
    </script>
</div>
</body>

</html>
