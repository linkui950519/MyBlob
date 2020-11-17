package com.lk.model;

import lombok.Data;

/**
 * @author: linkui
 * @Date: 2020/11/20 15:36
 * Describe: 标签
 */
@Data
public class Tag {

    private int id;

    /**
     * 标签名
     */
    private String tagName;

    /**
     * 标签大小
     */
    private int tagSize;

    public Tag() {
    }

    public Tag(String tagName, int tagSize) {
        this.tagName = tagName;
        this.tagSize = tagSize;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	public int getTagSize() {
		return tagSize;
	}

	public void setTagSize(int tagSize) {
		this.tagSize = tagSize;
	}
    
}
