/** index.js By Beginner Emain:zheng_jinfan@126.com HomePage:http://www.zhengjinfan.cn */

var tab;

layui.config({
    base: '',
    version: new Date().getTime()
}).extend({
    common: 'frm/js/common',//navbar组件使用
    navbar: 'frm/js/navbar',
    tab: 'frm/js/tab'
}).use(['element', 'layer', 'navbar', 'tab'], function () {
    var element = layui.element(),
        $ = layui.jquery,
        layer = layui.layer,
        navbar = layui.navbar();
    tab = layui.tab({
        elem: '.admin-nav-card' //设置选项卡容器
        ,
        maxSetting: {
            max: 6,
            tipMsg: ''
        },
        contextMenu: true
    });

    //iframe自适应
    $(window).on('resize', function () {
        var $content = $('.admin-nav-card .layui-tab-content');
        $content.height($(this).height() - 101);//147
        $content.find('iframe').each(function () {
            $(this).height($content.height());
        });
    }).resize();

    function opendiv(rt) {
        outtc = layer.open({
            type: 1,
            offset: 'rb',
            shade: 0,
            time: 174000,
            id: "nmoutdiv",
            area: ['300px', '150px'],
            content: rt//这里content是一个普通的String
        });
    }

    function spshfun(cxdh, ymmc, title) {
        top.addTab(cxdh, ymmc, title, "");
    }

    function getcountspsh() {
        $.ajax({
            url: 'flow.do?method=getAuditCount&t=' + new Date().getTime(),	//如果url为空，则默认查询code
            async: false,
            dataType: 'json',
            success: function (rlt) {
                if (rlt.counts > 0) {
                    opendiv(rlt.strings)
                } else {
                }
            }
        });
    }

    getcountspsh();
    //关闭标签页

    window.closeTab = function (cxid) {
        if (!cxid) {
            //error
            return;
        }

        $('#admin-body>div.layui-tab>ul.layui-tab-title>li').each(function () {
            if ($(this).data('cxid') == cxid) {
                element.tabDelete('admin-tab', $(this).attr('lay-id'));
                return;
            }
        });
    }
    window.addTab = function (cxdh, ymmc, title, icon) {
        var href = "/forwardMenu?ymmc=" + ymmc + "&cxdh=" + cxdh;
        if (cxdh == "090102") {
            href = ymmc;
//			window.open(href,"newwindow");
        }
        var datas = {
            href: href,
            icon: icon,
            title: title,
            cxdh: cxdh
        }
        tab.tabAdd(datas, cxdh);

    }
    $("#ttp").on('click', function () {
        getcountspsh();
    })
    $("#spdiv").on('click', function () {
        spshfun('020102', 'gov/audit1.jsp', '业务审批');
    })
    $("#shdiv").on('click', function () {
        spshfun('020103', 'gov/audit2.jsp', '业务审核');
    })
    //设置navbar
    navbar.set({
        spreadOne: true,
        elem: '#admin-navbar-side',
        cached: true,
        url: '/getMenus'
    });
    //渲染navbar
    navbar.render();
    //监听点击事件
    navbar.on('click(side)', function (data) {
        console.log(data)
        if (data.field.cxdh == "090102") {
            data.field.href = data.field.href;
        } else {
            data.field.href = "/forwardMenu?ymmc=" + data.field.href + "&cxdh=" + data.field.cxdh;
        }
        tab.tabAdd(data.field, data.field.cxdh);
    });

    $('.admin-side-toggle').on('click', function () {
        var sideWidth = $('#admin-side').width();
        if (sideWidth === 200) {
            $('#admin-body').animate({
                left: '50'
            }); //admin-footer
            $('#admin-footer').animate({
                left: '50'
            });
            $('#admin-side').animate({
                width: '50'
            });
        } else {
            $('#admin-body').animate({
                left: '200px'
            });
            $('#admin-footer').animate({
                left: '200px'
            });
            $('#admin-side').animate({
                width: '200px'
            });
        }
    });

    $('#deskTabTitle').on('click', function () {
        $('#deskTab')[0].src = $('#deskTab')[0].src;
    });
    var miniUlMenuTree = $('#admin-navbar-side>ul');
    miniUlMenuTree.css('height', parseInt(miniUlMenuTree.css('height')) + parseInt($('#admin-navbar-side').css('height')) - 100);
    $('.left-menus-toggle').on('click', function () {
        var sideWidth = $('#admin-side').width();
        if (sideWidth === 200) {
            $('#admin-side').removeClass('own-side-layout-extend').addClass('own-side-layout-mini');
            $('#admin-body').animate({
                left: '50'
            }); //admin-footer
            $('#admin-footer').animate({
                left: '50'
            });
            $('#admin-side').animate({
                width: '50'
            });

            $('.own-side-layout-mini li.layui-nav-item>a').off('mouseover', fixMinifixedPoPMenuPosition).on('mouseover', fixMinifixedPoPMenuPosition);
        } else {
            $('#admin-side').removeClass('own-side-layout-mini').addClass('own-side-layout-extend');
            $('#admin-body').animate({
                left: '200px'
            });
            $('#admin-footer').animate({
                left: '200px'
            });
            $('#admin-side').animate({
                width: '200px'
            });

            fixExtendMenuPosition($);
        }
    });
    $('.admin-side-full').on('click', function () {
        var docElm = document.documentElement;
        //W3C
        if (docElm.requestFullscreen) {
            docElm.requestFullscreen();
        }
        //FireFox
        else if (docElm.mozRequestFullScreen) {
            docElm.mozRequestFullScreen();
        }
        //Chrome等
        else if (docElm.webkitRequestFullScreen) {
            docElm.webkitRequestFullScreen();
        }
        //IE11
        else if (elem.msRequestFullscreen) {
            elem.msRequestFullscreen();
        }
        layer.msg('按Esc即可退出全屏');
    });


    //锁屏
    $(document).on('keydown', function () {
        var e = window.event;
        if (e.keyCode === 76 && e.altKey) {
            //alert("你按下了alt+l");
            //lock($, layer);
        }
    });
    $('#lock').on('click', function () {
        //lock($, layer);
    });

    //手机设备的简单适配
    var treeMobile = $('.site-tree-mobile'),
        shadeMobile = $('.site-mobile-shade');
    treeMobile.on('click', function () {
        $('body').addClass('site-mobile');
    });
    shadeMobile.on('click', function () {
        $('body').removeClass('site-mobile');
    });


    /*//加载下载列表
    if (downFiles) {
        if (downFiles.length && downFiles.length > 0) {
            var hstr = '';
            for (var i in downFiles) {
                hstr += '<li><a href="' + downFiles[i].wjm + '"><i class="' + downFiles[i].wjtb + '"></i> ' + downFiles[i].xsm + '</a></li>';
            }
            $('#downList-div div.downList-lis ul').html(hstr);

            $('#downList-div div.downList-tip').text('当前有' + downFiles.length + '个可下载项');
            $('#downList span.numTips.downListNum').text(downFiles.length);

            $('#downList a').on('click', function () {
                var dis = $('#downList-div').hasClass('layui-hide');
                $('#downList-div').removeClass(dis ? 'layui-hide' : 'layui-show').addClass(dis ? 'layui-show' : 'layui-hide');
            });
            $('#downList').on('mouseleave', function () {
                $('#downList-div').removeClass('layui-show').addClass('layui-hide');
            });
        }
    }*/


    //加载登录用户信息
    $.ajax({
        url: 'user.do?method=getUserJsonInfo&ttt=' + new Date().getTime(),
        async: false,
        dataType: 'json',
        success: function (rlt) {
            try {
                $('.loginUName').text(rlt.user.xm);
                $('.loginUSfGLY').text(rlt.user.sfgly == 1 ? '管理员' : '在线');
                $('.loginUBMJC').text(rlt.dep.bmjc);
                $('.loginUYHYXQ').text('用户有效期: ' + rlt.user.yhyxq.substr(0, 10));
                $('.loginUMMYXQ').text('密码有效期: ' + rlt.user.mmyxq.substr(0, 10));

                //加载头像
                $('.userHeadPortrait').each(function () {
                    $(this)[0].onerror = function () {
                        if (rlt.user.sfzmhm == undefined || rlt.user.sfzmhm == '') {
                            $('.userHeadPortrait').attr('src', 'frm/images/noSex.png');
                        }
                        var s = parseInt(rlt.user.sfzmhm.substr(16, 1));
                        if (s % 2 == 1) {
                            $('.userHeadPortrait').attr('src', 'frm/images/man.png');
                        } else {
                            $('.userHeadPortrait').attr('src', 'frm/images/woman.png');
                        }
                    }
                });
                setTimeout(function () {
                    $('.userHeadPortrait').attr('src', 'user.do?method=printHeadPortrait&t=' + new Date().getTime());
                }, 150);
            } catch (e) {
                //alert('加载用户信息发生错误:\n'+e.message);
            }
        },
        error: function (e) {
            throw e;
        }
    });


    $('#userLoginInfo a').on('click', function () {
        var dis = $('#userLoginInfo>div.userInfoDiv').hasClass('layui-hide');
        $('#userLoginInfo>div.userInfoDiv').removeClass(dis ? 'layui-hide' : 'layui-show').addClass(dis ? 'layui-show' : 'layui-hide');
    });
    $('#userLoginInfo').on('mouseleave', function () {
        $('#userLoginInfo>div.userInfoDiv').removeClass('layui-show').addClass('layui-hide');
    });


    //更换用户头像
    $('#changeUserImgBtn').on('click', function () {
        layer.open({
            type: 2,
            id: 'UserChangePassWord',
            content: 'user.do?method=forwardUserChangeHeadAvatar&ttt=' + new Date().getTime(),
            title: '更换用户头像',
            shade: 0.2,
            offset: ['100px', '30%'],
            area: ['700px', '500px'],
            zIndex: 10000000,
            //fixed: false,
            moveOut: true,
            //scrollbar: false,
            maxmin: false,
            btn: 0
        });
    });
    //修改用户密码
    $('#changeUserPwd').on('click', function () {
        layer.open({
            type: 2,
            id: 'UserChangePassWord',
            content: 'user.do?method=forwardUserChangePassWord&ttt=' + new Date().getTime(),
            title: '修改用户密码',
            shade: 0.2,
            offset: ['100px', '40%'],
            area: ['400px', '400px'],
            zIndex: 10000000,
            //fixed: false,
            moveOut: true,
            //scrollbar: false,
            maxmin: false,
            btn: 0
        });
    });

    //注销
    $('#userLogout').on('click', function () {
        location.href = 'login.do?method=loginOut&ttt=' + new Date().getTime();
    });
});


function fixExtendMenuPosition($) {
    $('div.own-side-layout-extend #left-menus .layui-nav-item>a cite').css('margin-top', 'auto');
    $('div.own-side-layout-extend #left-menus .layui-nav-item>a span').css('margin-top', 'auto');
    $('div.own-side-layout-extend #left-menus .layui-nav-item>dl').css('margin-top', 'auto');
}

function fixMinifixedPoPMenuPosition() {
    var $ = layui.jquery;
    var fixHeight = document.getElementById('admin-navbar-side').scrollTop;
    $('div.own-side-layout-mini #left-menus .layui-nav-item:hover>a cite').css('margin-top', '-' + (45 + parseInt(fixHeight)) + 'px');
    $('div.own-side-layout-mini #left-menus .layui-nav-item:hover>a span').css('margin-top', '-' + (25 + parseInt(fixHeight)) + 'px');
    $('div.own-side-layout-mini #left-menus .layui-nav-item:hover>dl').css('margin-top', '-' + fixHeight + 'px');
}


var isShowLock = false;

function lock($, layer) {
    if (isShowLock)
        return;
    //自定页
    layer.open({
        title: false,
        type: 1,
        closeBtn: 0,
        anim: 6,
        content: $('#lock-temp').html(),
        shade: [0.9, '#393D49'],
        success: function (layero, lockIndex) {
            isShowLock = true;
            //给显示用户名赋值
            layero.find('div#lockUserName').text('admin');
            layero.find('input[name=lockPwd]').on('focus', function () {
                var $this = $(this);
                if ($this.val() === '输入密码解锁..') {
                    $this.val('').attr('type', 'password');
                }
            })
                .on('blur', function () {
                    var $this = $(this);
                    if ($this.val() === '' || $this.length === 0) {
                        $this.attr('type', 'text').val('输入密码解锁..');
                    }
                });
            //在此处可以写一个请求到服务端删除相关身份认证，因为考虑到如果浏览器被强制刷新的时候，身份验证还存在的情况
            //do something...
            //e.g.
            /*
             $.post(url,params,callback,'json');
             */
            //绑定解锁按钮的点击事件
            layero.find('button#unlock').on('click', function () {
                var $lockBox = $('div#lock-box');

                var userName = $lockBox.find('div#lockUserName').text();
                var pwd = $lockBox.find('input[name=lockPwd]').val();
                if (pwd === '输入密码解锁..' || pwd.length === 0) {
                    layer.msg('请输入密码..', {
                        icon: 2,
                        time: 1000
                    });
                    return;
                }
                unlock(userName, pwd);
            });
            /**
             * 解锁操作方法
             * @param {String} 用户名
             * @param {String} 密码
             */
            var unlock = function (un, pwd) {
                //这里可以使用ajax方法解锁
                /*$.post('api/xx',{username:un,password:pwd},function(data){
                     //验证成功
                    if(data.success){
                        //关闭锁屏层
                        layer.close(lockIndex);
                    }else{
                        layer.msg('密码输入错误..',{icon:2,time:1000});
                    }
                },'json');
                */
                isShowLock = false;
                //演示：默认输入密码都算成功
                //关闭锁屏层
                layer.close(lockIndex);
            };
        }
    });
};