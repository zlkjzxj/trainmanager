package com.zlkj.trainmanager.bean;

import org.apache.ibatis.type.Alias;


@Alias("menuresource")
public class MenuResourceBean extends TreeModel {

    private String menuopen;    //	是否新开窗口
    private String menupic;     //菜单图片
    private String menuenview;  //菜单是否可见
    private String menudesc;    //	菜单描述

    private String menutype;    //菜单类型


    public String getMenuopen() {
        return menuopen;
    }

    public void setMenuopen(String menuopen) {
        this.menuopen = menuopen;
    }

    public String getMenupic() {
        return menupic;
    }

    public void setMenupic(String menupic) {
        this.menupic = menupic;
    }

    public String getMenuenview() {
        return menuenview;
    }

    public void setMenuenview(String menuenview) {
        this.menuenview = menuenview;
    }

    public String getMenudesc() {
        return menudesc;
    }

    public void setMenudesc(String menudesc) {
        this.menudesc = menudesc;
    }

    public String getMenutype() {
        return menutype;
    }

    public void setMenutype(String menutype) {
        this.menutype = menutype;
    }
}
