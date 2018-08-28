package com.zlkj.trainmanager.dao;

import com.zlkj.trainmanager.bean.MenuResourceBean;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface MenuResource {
    public void addMenuResource(MenuResourceBean menuResourceBean);

    public List<MenuResourceBean> getNavMenus();
}
