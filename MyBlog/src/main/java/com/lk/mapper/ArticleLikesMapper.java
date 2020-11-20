package com.lk.mapper;

import com.lk.model.ArticleLikesRecord;

import java.util.List;

import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

/**
 * @author: linkui
 * @Date:2020/11/7 15:51
 * Describe: 文章点赞sql
 */
@Mapper
@Repository
public interface ArticleLikesMapper {

    @Insert("insert into article_likes_record(articleId,likerId,likeDate,isread) values(#{articleId},#{likerId},#{likeDate},#{isRead})")
    void insertArticleLikesRecord(ArticleLikesRecord articleLikesRecord);

    @Select("select likeDate from article_likes_record where articleId=#{articleId} and likerId=#{likerId}")
    ArticleLikesRecord isLiked(@Param("articleId") long articleId, @Param("likerId") int likerId);

    @Delete("delete from article_likes_record where articleId=#{articleId}")
    void deleteArticleLikesRecordByArticleId(long articleId);
    @Select("select * from article_likes_record order by id desc")
    List<ArticleLikesRecord> getArticleThumbsUp();

    @Select("select count(*) from article_likes_record where isRead=1")
    int countIsReadNum();

    @Update("update article_likes_record set isRead=0 where id=#{id}")
    void readThisThumbsUp(int id);

    @Update("update article_likes_record set isRead=0")
    void readAllThumbsUp();
}
