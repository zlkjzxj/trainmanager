/** navbar.js By Beginner Emain:zheng_jinfan@126.com HomePage:http://www.zhengjinfan.cn */
layui.define(['element', 'common'], function (exports) {
    "use strict";
    var $ = layui.jquery,
        layer = parent.layer === undefined ? layui.layer : parent.layer,
        element = layui.element(),
        common = layui.common,
        cacheName = 'tb_navbar';

    var Navbar = function () {
        /**
         *  默认配置
         */
        this.config = {
            elem: undefined, //容器
            data: undefined, //数据源
            url: undefined, //数据源地址
            type: 'GET', //读取方式
            cached: false, //是否使用缓存
            spreadOne: false //设置是否只展开一个二级菜单
        };
        this.v = '0.0.1';
    };
    Navbar.prototype.render = function () {
        var _that = this;
        var _config = _that.config;
        if (typeof(_config.elem) !== 'string' && typeof(_config.elem) !== 'object') {
            common.throwError('Navbar error: elem参数未定义或设置出错，具体设置格式请参考文档API.');
        }
        var $container;
        if (typeof(_config.elem) === 'string') {
            $container = $('' + _config.elem + '');
        }
        if (typeof(_config.elem) === 'object') {
            $container = _config.elem;
        }
        if ($container.length === 0) {
            common.throwError('Navbar error:找不到elem参数配置的容器，请检查.');
        }
        if (_config.data === undefined && _config.url === undefined) {
            common.throwError('Navbar error:请为Navbar配置数据源.')
        }
        if (_config.data !== undefined && typeof(_config.data) === 'object') {
            var html = getHtml(_config.data);
            $container.html(html);
            element.init();
            _that.config.elem = $container;
        } else {
            if (_config.cached) {
                var cacheNavbar = layui.data(cacheName);
                if (cacheNavbar.navbar === undefined) {
                    $.ajax({
                        type: _config.type,
                        url: _config.url,
                        async: false, //_config.async,
                        dataType: 'json',
                        success: function (result, status, xhr) {
                            //添加缓存
                            layui.data(cacheName, null);
                            var html = getHtml(result);
                            $container.html(html);
                            element.init();
                        },
                        error: function (xhr, status, error) {
                            common.msgError('Navbar error:' + error);
                        },
                        complete: function (xhr, status) {
                            _that.config.elem = $container;
                        }
                    });
                } else {
                    var html = getHtml(cacheNavbar.navbar);
                    $container.html(html);
                    element.init();
                    _that.config.elem = $container;
                }
            } else {
                //清空缓存
                layui.data(cacheName, null);
                $.ajax({
                    type: _config.type,
                    url: _config.url,
                    async: false, //_config.async,
                    dataType: 'json',
                    success: function (result, status, xhr) {
                        var html = getHtml(result);
                        $container.html(html);
                        element.init();
                    },
                    error: function (xhr, status, error) {
                        common.msgError('Navbar error:' + error);
                    },
                    complete: function (xhr, status) {
                        _that.config.elem = $container;
                    }
                });
            }
        }

        //只展开一个二级菜单
        if (_config.spreadOne) {
            var $ul = $container.children('ul');
            $ul.find('li.layui-nav-item').each(function () {
                $(this).on('click', function () {
                    $(this).siblings().removeClass('layui-nav-itemed');
                });
            });
        }

        //只展开一个三级菜单
        if (_config.spreadOne) {
            var $ul = $container.children('ul');
            $ul.find('dl.layui-nav-child dd').each(function () {
                $(this).on('click', function () {
                    $(this).siblings().removeClass('layui-nav-itemed-third');
                });
            });
        }

        return _that;
    };
    /**
     * 配置Navbar
     * @param {Object} options
     */
    Navbar.prototype.set = function (options) {
        var that = this;
        that.config.data = undefined;
        $.extend(true, that.config, options);
        return that;
    };
    /**
     * 绑定事件
     * @param {String} events
     * @param {Function} callback
     */
    Navbar.prototype.on = function (events, callback) {
        var that = this;
        var _con = that.config.elem;
        if (typeof(events) !== 'string') {
            common.throwError('Navbar error:事件名配置出错，请参考API文档.');
        }
        var lIndex = events.indexOf('(');
        var eventName = events.substr(0, lIndex);
        var filter = events.substring(lIndex + 1, events.indexOf(')'));
        if (eventName === 'click') {
            if (_con.attr('lay-filter') !== undefined) {
                _con.children('ul').find('li').each(function () {
                    var $this = $(this);
                    if ($this.find('dl').length > 0) {
                        var $dd = $this.find('dd dd').each(function () {
                            $(this).on('click', function () {
                                var $a = $(this).children('a');
                                var href = $a.data('url');
                                var icon = $a.children('i:first').data('icon');
                                var title = $a.children('cite').text();
                                var cxdh = $a.data('cxdh');
                                var data = {
                                    elem: $a,
                                    field: {
                                        href: href,
                                        icon: icon,
                                        title: title,
                                        cxdh: cxdh
                                    }
                                }
                                callback(data);
                            });
                        });
                    } else {
                        //一级导航，没有子级
                        $this.on('click', function () {
                            var $a = $this.children('a');
                            var href = $a.data('url');
                            var icon = $a.children('i:first').data('icon');
                            var title = $a.children('cite').text();
                            var cxdh = $a.data('cxdh');
                            var data = {
                                elem: $a,
                                field: {
                                    href: href,
                                    icon: icon,
                                    title: title,
                                    cxdh: cxdh
                                }
                            }
                            callback(data);
                        });
                    }
                });
            }
        }
    };
    /**
     * 清除缓存
     */
    Navbar.prototype.cleanCached = function () {
        layui.data(cacheName, null);
    };

    /* /!**
      * 获取html字符串
      * @param {Object} data
      *!/
     function getHtml(data) {
         console.log(data);
         var ulHtml = '<ul class="layui-nav layui-nav-tree beg-navbar">';
         for (var i = 0; i < data.length; i++) {
             if (i == 0) {
                 ulHtml += '<li class="layui-nav-item layui-nav-itemed">';
             } else {
                 ulHtml += '<li class="layui-nav-item">';
             }
             if (data[i].programLbList !== undefined && data[i].programLbList.length > 0) {
                 ulHtml += '<a href="javascript:;">';
                 if (data[i].mltp !== undefined && data[i].mltp !== '') {
                     ulHtml += '<i class="' + data[i].mltp + '" aria-hidden="true"></i>';
                 }
                 ulHtml += '<cite>' + data[i].mlmc + '</cite>';
                 ulHtml += '</a>';
                 ulHtml += '<dl class="layui-nav-child">';
                 for (var j = 0; j < data[i].programLbList.length; j++) {
                     ulHtml += '<dd title="' + data[i].programLbList[j].lbmc + '">';
                     ulHtml += '<a href="javascript:;" >';
                     if (data[i].programLbList[j].lbtp !== undefined && data[i].programLbList[j].lbtp !== '') {
                         ulHtml += '<i class="' + data[i].programLbList[j].lbtp + '" aria-hidden="true"></i>';
                     }
                     ulHtml += '<cite>' + data[i].programLbList[j].lbmc + '</cite>';
                     ulHtml += '</a>';

                     ulHtml += '<dl class="three-level-child">';
                     for (var k = 0; k < data[i].programLbList[j].programList.length; k++) {

                         ulHtml += '<dd title="' + data[i].programLbList[j].programList[k].cxmc + '">';
                         ulHtml += '<a class="three-level-a" href="javascript:;" data-cxdh=' + data[i].programLbList[j].programList[k].cxdh + ' data-url=' + data[i].programLbList[j].programList[k].ymmc + ' >';
                         if (data[i].programLbList[j].programList[k].cxtp !== undefined && data[i].programLbList[j].programList[k].cxtp !== '') {
                             ulHtml += '<i class="' + data[i].programLbList[j].programList[k].cxtp + '" aria-hidden="true"></i>';
                         }
                         ulHtml += '<cite>' + data[i].programLbList[j].programList[k].cxmc + '</cite>';
                         ulHtml += '</a>';
                         ulHtml += '</dd>';

                     }
                     ulHtml += '</dl>';

                     ulHtml += '</dd>';
                 }
                 ulHtml += '</dl>';
             } else {

             }
             ulHtml += '</li>';
         }
         ulHtml += '</ul>';

         return ulHtml;
     }*/
    /**
     * 获取html字符串
     * @param {Object} data
     */
    function getHtml(data) {
        console.log(data);
        var ulHtml = '<ul class="layui-nav layui-nav-tree beg-navbar">';
        ulHtml += "<li class=\"layui-nav-item\">";
        ulHtml += "<a href=\"javascript:;\">后台管理</a>";
        ulHtml += "<dl class=\"layui-nav-child\">";
        for (var i = 0; i < data.length; i++) {
            ulHtml += '<dd title="' + data[i].menuname + '"><li class="layui-nav-item"><a class="three-level-a" href="javascript:;" data-cxdh=' + data[i].menuid + ' data-url=' + data[i].menuurl + ' >' + data[i].menuname + '</a></li></dd>'
        }
        ulHtml += '</dl>';
        ulHtml += "</li>";
        ulHtml += '</ul>';
        return ulHtml;
    }

    var navbar = new Navbar();

    exports('navbar', function (options) {
        return navbar.set(options);
    });
})
;