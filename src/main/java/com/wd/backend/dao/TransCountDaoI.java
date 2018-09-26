package com.wd.backend.dao;

import java.util.Map;

/**
 * Created by DimonHo on 2018/2/28.
 */
public interface TransCountDaoI {

    /**
     * 更新当天翻译的字符数
     * @param param
     * @return
     */
    Integer setNowDayCount(Map param);

    /**
     * 当天字符总数
     * @param orgFlag
     * @return
     */

    Integer getNowDayCount(String orgFlag);

    /**
     * 当前月字符总数
     * @param orgFlag
     * @return
     */

    Integer getNowMonthCount(String orgFlag);
}
