package com.zlkj.trainmanager.controller;

import com.zlkj.trainmanager.bean.Girl;
import com.zlkj.trainmanager.dao.GirlDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Login {
    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private GirlDao girlDao;

    @RequestMapping(value = "/")
    public String login(Model model) {
        logger.info("开始登录！");
        Girl girl = girlDao.selectGirlById(1);
        System.out.println(girl.getName());
        return "login";
    }
}
