package com.lk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.lk.model.Categories;

/**
 * @author: linkui
 * @Date:2020/11/17 20:54
 * Describe: 分类sql
 */
@Mapper
@Repository
public interface CategoryMapper {

    @Select("select categoryName from categories")
    List<String> findCategoriesName();

    @Select("select count(*) from categories")
    int countCategoriesNum();
    @Select("select id,categoryName from categories")
    List<Categories> findAllCategories();
    
    
    
    
    
    @Insert("insert into categories(categoryName) value(#{categoryName})")
    void save(Categories categories);

    
 

     

    @Delete("delete from categories where categoryName=#{categoryName}")
    void deleteCategory(String categoryName);

    @Select("select IFNULL((select id from categories where categoryName=#{categoryName}),0)")
    int findIsExistByCategoryName(String categoryName);

}


