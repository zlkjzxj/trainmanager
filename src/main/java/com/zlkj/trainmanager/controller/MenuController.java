package com.zlkj.trainmanager.controller;


import com.zlkj.trainmanager.bean.MenuResourceBean;
import com.zlkj.trainmanager.dao.MenuResource;
import com.zlkj.trainmanager.dao.database.ExcuteException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

@RestController
public class MenuController {

    @Autowired
    private MenuResource menuResource;

    @RequestMapping(value = "/getMenus")
    public List<MenuResourceBean> getMenus() {
        List<MenuResourceBean> list = menuResource.getNavMenus();
        return list;
    }

    @RequestMapping(value = "/forwardMenu")
    public String forwardMenu(String ymmc, String cxdh) throws Exception {
        if (ymmc == null || ymmc.trim().equals("")) {
            return "redirect:/login.do?method=loginOut";
        }
        return ymmc;
    }
}
