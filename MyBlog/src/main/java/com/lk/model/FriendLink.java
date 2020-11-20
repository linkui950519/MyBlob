package com.lk.model;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author: linkui
 * @Date: 2020/11/16 14:39
 * Describe:
 */
@Data
@NoArgsConstructor
public class FriendLink {

    private Integer id;

    /**
     * 博主
     */
    private String blogger;

    /**
     * 博主url
     */
    private String url;

    public FriendLink(String blogger, String url){
    	this.blogger = blogger;
        this.url = url;
    }

    public FriendLink(Integer id,String blogger, String url){
    	this.blogger = blogger;
        this.url = url;
		this.id = id;
    }


	public Integer getId() {
		return id;
	}



	public void setId(Integer id) {
		this.id = id;
	}



	public String getBlogger() {
		return blogger;
	}

	public void setBlogger(String blogger) {
		this.blogger = blogger;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}
