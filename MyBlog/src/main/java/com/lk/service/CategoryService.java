package com.lk.service;

import com.lk.utils.DataMap;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @author: linkui
 * @Date:2020/11/17 20:52
 * Describe:分类业务操作
 */
public interface CategoryService {

    /**
     * 获得所有的分类以及该分类的文章总数
     * @return
     */
    JSONObject findCategoriesNameAndArticleNum();

    /**
     * 获得所有的分类
     * @return
     */
    JSONArray findCategoriesName();

    /**
     * 获得分类数目
     * @return
     */
    int countCategoriesNum();

    /**
     * 获得分类名和对应id
     */
    DataMap findAllCategories();
    /**
     * 更新分类
     * @param categoryName 分类名
     * @param type 1--增加分类   2--删除分类
     */
    DataMap updateCategory(String categoryName, int type);
}
