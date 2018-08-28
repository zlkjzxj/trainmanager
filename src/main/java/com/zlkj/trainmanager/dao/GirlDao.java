package com.zlkj.trainmanager.dao;


import com.zlkj.trainmanager.bean.Girl;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by walle
 * 2018/1/4 21:39
 * good good study,day day up!
 */
@Component
public interface GirlDao {
    public Girl selectGirlById(int id);

    public List<Girl> getGirlList();

    public int insertAGirl(Girl girl);

    public int updateAGirl(Girl girl);
}
