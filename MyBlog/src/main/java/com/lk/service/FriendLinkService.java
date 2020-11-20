package com.lk.service;

import com.lk.model.FriendLink;
import com.lk.utils.DataMap;

/**
 * @author: linkui
 * @Date: 2020/11/16 17:08
 * Describe:
 */
public interface FriendLinkService {

    DataMap addFriendLink(FriendLink friendLink);

    DataMap getAllFriendLink();

    DataMap updateFriendLink(FriendLink friendLink, int id);

    DataMap deleteFriendLink(int id);

    DataMap getFriendLink();
}
