package com.lk.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lk.mapper.ArticleLikesMapper;
import com.lk.model.ArticleLikesRecord;
import com.lk.service.ArticleLikesRecordService;
import com.lk.service.ArticleService;
import com.lk.service.UserService;
import com.lk.utils.DataMap;

/**
 * @author: linkui
 * @Date: 2020/11/7 15:50
 * Describe:
 */
@Service
public class ArticleLikesRecordServiceImpl implements ArticleLikesRecordService {

    @Autowired
    ArticleLikesMapper articleLikesMapper;
    @Autowired
    UserService userService;
    @Autowired
    ArticleService articleService;
  
    @Override
    public boolean isLiked(long articleId, String username) {
        ArticleLikesRecord articleLikesRecord = articleLikesMapper.isLiked(articleId, userService.findIdByUsername(username));

        return articleLikesRecord != null;
    }

    @Override
    public void insertArticleLikesRecord(ArticleLikesRecord articleLikesRecord) {
        articleLikesMapper.insertArticleLikesRecord(articleLikesRecord);
    }

    @Override
    public void deleteArticleLikesRecordByArticleId(long articleId) {
        articleLikesMapper.deleteArticleLikesRecordByArticleId(articleId);
    }
    @Override
    public DataMap getArticleThumbsUp(int rows, int pageNum) {
        JSONObject returnJson = new JSONObject();

        PageHelper.startPage(pageNum, rows);
        List<ArticleLikesRecord> likesRecords = articleLikesMapper.getArticleThumbsUp();
        PageInfo<ArticleLikesRecord> pageInfo = new PageInfo<>(likesRecords);
        JSONArray returnJsonArray = new JSONArray();
        JSONObject articleLikesJson;
        for(ArticleLikesRecord a : likesRecords){
            articleLikesJson = new JSONObject();
            articleLikesJson.put("id", a.getId());
            articleLikesJson.put("articleId", a.getArticleId());
            articleLikesJson.put("likeDate", a.getLikeDate());
            articleLikesJson.put("praisePeople", userService.findUsernameById(a.getLikerId()));
            articleLikesJson.put("articleTitle", articleService.findArticleTitleByArticleId(a.getArticleId()).get("articleTitle"));
            articleLikesJson.put("isRead", a.getIsRead());
            returnJsonArray.add(articleLikesJson);
        }
        returnJson.put("result", returnJsonArray);
        returnJson.put("msgIsNotReadNum",articleLikesMapper.countIsReadNum());

        JSONObject pageJson = new JSONObject();
        pageJson.put("pageNum",pageInfo.getPageNum());
        pageJson.put("pageSize",pageInfo.getPageSize());
        pageJson.put("total",pageInfo.getTotal());
        pageJson.put("pages",pageInfo.getPages());
        pageJson.put("isFirstPage",pageInfo.isIsFirstPage());
        pageJson.put("isLastPage",pageInfo.isIsLastPage());
        returnJson.put("pageInfo",pageJson);

        return DataMap.success().setData(returnJson);
    }
    @Override
    public DataMap readThisThumbsUp(int id) {
        articleLikesMapper.readThisThumbsUp(id);
        return DataMap.success();
    }

    @Override
    public DataMap readAllThumbsUp() {
        articleLikesMapper.readAllThumbsUp();
        return DataMap.success();
    }
}
