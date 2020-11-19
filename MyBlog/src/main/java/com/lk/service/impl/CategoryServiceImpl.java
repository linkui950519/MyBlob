package com.lk.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lk.constant.CodeType;
import com.lk.mapper.CategoryMapper;
import com.lk.model.Categories;
import com.lk.service.ArticleService;
import com.lk.service.CategoryService;
import com.lk.utils.DataMap;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @author: zhangocean
 * @Date: 2018/7/17 20:54
 * Describe:
 */
@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    CategoryMapper categoryMapper;
    @Autowired
    ArticleService articleService;

    @Override
    public JSONObject findCategoriesNameAndArticleNum() {
        List<String> categoryNames = categoryMapper.findCategoriesName();
        JSONObject categoryJson;
        JSONArray categoryJsonArray = new JSONArray();
        JSONObject returnJson = new JSONObject();
        for(String categoryName : categoryNames){
            categoryJson = new JSONObject();
            categoryJson.put("categoryName",categoryName);
            categoryJson.put("categoryArticleNum",articleService.countArticleCategoryByCategory(categoryName));
            categoryJsonArray.add(categoryJson);
        }
        returnJson.put("status",200);
        returnJson.put("result",categoryJsonArray);
        return returnJson;
    }

    @Override
    public JSONArray findCategoriesName() {
        List<String> categoryNames = categoryMapper.findCategoriesName();
        return JSONArray.fromObject(categoryNames);
    }

    @Override
    public int countCategoriesNum() {
        return categoryMapper.countCategoriesNum();
    }
    @Override
    public DataMap<Object> findAllCategories() {
        List<Categories> lists = categoryMapper.findAllCategories();
        JSONObject returnJson = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        JSONObject jsonObject;
        for(Categories c : lists){
            jsonObject = new JSONObject();
            jsonObject.put("id", c.getId());
            jsonObject.put("categoryName", c.getCategoryName());
            jsonArray.add(jsonObject);
        }
        returnJson.put("result", jsonArray);
        DataMap<Object> setData = DataMap.success().setData(returnJson);
        return setData;
    }
    @Override
    public DataMap updateCategory(String categoryName, int type) {
        int isExistCategory = categoryMapper.findIsExistByCategoryName(categoryName);
        if(type == 1){
            if(isExistCategory == 0){
                Categories categories = new Categories();
                categories.setCategoryName(categoryName);
                categoryMapper.save(categories);

                int id = categoryMapper.findIsExistByCategoryName(categoryName);

                return DataMap.success(CodeType.ADD_CATEGORY_SUCCESS)
                        .setData(id);
            } else {
                return DataMap.fail(CodeType.CATEGORY_EXIST);
            }
        } else {
            if(isExistCategory != 0){
                int articleNum = articleService.countArticleCategoryByCategory(categoryName);
                if(articleNum > 0){
                    return DataMap.fail(CodeType.CATEGORY_HAS_ARTICLE);
                }

                categoryMapper.deleteCategory(categoryName);
                return DataMap.success(CodeType.DELETE_CATEGORY_SUCCESS);
            }else {
                return DataMap.fail(CodeType.CATEGORY_NOT_EXIST);
            }
        }
    }
}
