package com.zlkj.trainmanager.dao.database;

import com.zlkj.trainmanager.tools.Tools;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;

public class BaseDaoImpl implements BaseDao {
    private static final String UNCHECKED = "unchecked";
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @SuppressWarnings("static-access")
    public ExcuteResult excuteDataBase(Object args, ExcuteType excuteType, @SuppressWarnings("rawtypes") Enum excuteWhat) throws ExcuteException {
        int recount = 0;
        try {
            if (excuteType.INSERT != null) {
                recount = sqlSessionTemplate.insert(excuteWhat.toString(), args);
            } else if (excuteType.DELETE != null) {
                recount = sqlSessionTemplate.delete(excuteWhat.toString(), args);
            } else if (excuteType.UPDATE != null) {
                recount = sqlSessionTemplate.update(excuteWhat.toString(), args);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ExcuteException(-1, excuteType + "__" + excuteWhat.toString() + "__操作执行异常:" + Tools.getException(e));
        }
        if (recount == 0) {
            return new ExcuteResult(recount, "操作执行没有符合条件的数据项");
        }

        return new ExcuteResult(recount, "操作执行成功");
    }

    /**
     * 重载
     * 数据库执行 增删改操作
     *
     * @param args
     * @param excuteType
     * @param strname
     * @return
     * @throws ExcuteException
     */
    public ExcuteResult excuteDataBase(Object args, ExcuteType excuteType, String strname) throws ExcuteException {
        int recount = 0;
        try {
            if (excuteType.INSERT != null) {
                recount = sqlSessionTemplate.insert(strname, args);
            } else if (excuteType.DELETE != null) {
                recount = sqlSessionTemplate.delete(strname, args);
            } else if (excuteType.UPDATE != null) {
                recount = sqlSessionTemplate.update(strname, args);
            }
        } catch (Exception e) {
            throw new ExcuteException(-1, excuteType + "__" + strname + "__操作执行异常:" + Tools.getException(e));
        }
        if (recount == 0) {
            return new ExcuteResult(recount, "操作执行没有符合条件的数据项");
        }

        return new ExcuteResult(recount, "操作执行成功");
    }

    @SuppressWarnings("rawtypes")
    public Object getObject(Object args, Enum excuteWhat) throws ExcuteException {
        try {
            return sqlSessionTemplate.selectOne(excuteWhat.toString(), args);
        } catch (Exception e) {
            throw new ExcuteException(-1, "GETOBJECT__" + excuteWhat.toString() + "__操作执行异常:" + Tools.getException(e));
        }
    }

    /**
     * 重载
     * 执行查询操作
     * 返回一个对象
     *
     * @param args
     * @param strname
     * @return
     * @throws ExcuteException
     */
    public Object getObject(Object args, String strname) throws ExcuteException {
        try {
            return sqlSessionTemplate.selectOne(strname, args);
        } catch (Exception e) {
            throw new ExcuteException(-1, "GETOBJECT__" + strname + "__操作执行异常:" + Tools.getException(e));
        }
    }

    @SuppressWarnings("rawtypes")
    public List getObjectList(Object args, Enum excuteWhat) throws ExcuteException {
        try {
            if (null != args)
                return sqlSessionTemplate.selectList(excuteWhat.toString(), args);
            else
                return sqlSessionTemplate.selectList(excuteWhat.toString());
        } catch (Exception e) {
            throw new ExcuteException(-1, "GETOBJECTLIST__" + excuteWhat.toString() + "__操作执行异常:" + Tools.getException(e));
        }
    }

    public List getObjectList(Object args, String strname) throws ExcuteException {
        try {
            if (null != args)
                return sqlSessionTemplate.selectList(strname, args);
            else
                return sqlSessionTemplate.selectList(strname);
        } catch (Exception e) {
            throw new ExcuteException(-1, "GETOBJECTLIST__" + strname + "__操作执行异常:" + Tools.getException(e));
        }
    }

    @SuppressWarnings("rawtypes")
    public List getRootList(Enum excuteWhat) throws ExcuteException {
        try {
            return sqlSessionTemplate.selectList(excuteWhat.toString());
        } catch (Exception e) {
            throw new ExcuteException(-1, "GETROOTTLIST__" + excuteWhat.toString() + "__操作执行异常:" + Tools.getException(e));
        }
    }

    @SuppressWarnings({UNCHECKED, "rawtypes"})
    public List<Map<?, ?>> getObjectListMap(Object args, Enum excuteWhat) throws ExcuteException {
        try {
            if (null != args)
                return (List) sqlSessionTemplate.selectList(excuteWhat.toString(), args);
            else
                return (List) sqlSessionTemplate.selectList(excuteWhat.toString());
        } catch (Exception e) {
            throw new ExcuteException(-1, "GETOBJECTLISTMAP__" + excuteWhat.toString() + "__操作执行异常:" + Tools.getException(e));
        }
    }

    public SqlSessionTemplate getSqlSessionTemplate() {
        return sqlSessionTemplate;
    }

    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

    public static String getUnchecked() {
        return UNCHECKED;
    }
}