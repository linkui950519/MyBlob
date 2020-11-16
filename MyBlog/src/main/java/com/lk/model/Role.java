package com.lk.model;

import lombok.Data;

/**
 * @author: linkui
 * @Date: 2020/11/10 19:41
 * Describe: 权限
 */
@Data
public class Role {

    private int id;

    private String name;

    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Role(){

    }

    public Role(int id, String name) {
        this.id = id;
        this.name = name;
    }
}
