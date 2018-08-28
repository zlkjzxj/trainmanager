package com.zlkj.trainmanager.dao.database;

import java.util.List;
import java.util.Map;

public interface BaseDao {
    public ExcuteResult excuteDataBase(Object args, ExcuteType excuteType, Enum excuteWhat) throws ExcuteException;

    public Object getObject(Object args, Enum excuteWhat) throws ExcuteException;

    public List getObjectList(Object args, Enum excuteWhat) throws ExcuteException;

    public List<Map<?, ?>> getObjectListMap(Object args, Enum excuteWhat) throws ExcuteException;

}
