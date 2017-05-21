//
//  SearchUserResPonse.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/21.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import Foundation
import Moya_SwiftyJSONMapper
import SwiftyJSON

struct SearchUserResponse: ALSwiftyJSONAble {
    var incompleteResults: Bool!
    var items: [SearchUserItem]!
    var totalCount: Int!
    init?(jsonData: JSON) {
        if jsonData.isEmpty {
            return
        }
        incompleteResults = jsonData["incomplete_results"].boolValue
        items = [SearchUserItem]()
        let itemsArray = jsonData["items"].arrayValue
        for itemsJson in itemsArray {
            let value = SearchUserItem(jsonData: itemsJson)
            items.append(value!)
        }
        totalCount = jsonData["total_count"].intValue
    }
}
struct SearchUserItem: ALSwiftyJSONAble {
    var avatarUrl: String!
    var eventsUrl: String!
    var followersUrl: String!
    var followingUrl: String!
    var gistsUrl: String!
    var gravatarId: String!
    var htmlUrl: String!
    var id: Int!
    var login: String!
    var organizationsUrl: String!
    var receivedEventsUrl: String!
    var reposUrl: String!
    var score: Float!
    var siteAdmin: Bool!
    var starredUrl: String!
    var subscriptionsUrl: String!
    var type: String!
    var url: String!
    init?(jsonData: JSON) {
        if jsonData.isEmpty {
            return
        }
        avatarUrl = jsonData["avatar_url"].stringValue
        eventsUrl = jsonData["events_url"].stringValue
        followersUrl = jsonData["followers_url"].stringValue
        followingUrl = jsonData["following_url"].stringValue
        gistsUrl = jsonData["gists_url"].stringValue
        gravatarId = jsonData["gravatar_id"].stringValue
        htmlUrl = jsonData["html_url"].stringValue
        id = jsonData["id"].intValue
        login = jsonData["login"].stringValue
        organizationsUrl = jsonData["organizations_url"].stringValue
        receivedEventsUrl = jsonData["received_events_url"].stringValue
        reposUrl = jsonData["repos_url"].stringValue
        score = jsonData["score"].floatValue
        siteAdmin = jsonData["site_admin"].boolValue
        starredUrl = jsonData["starred_url"].stringValue
        subscriptionsUrl = jsonData["subscriptions_url"].stringValue
        type = jsonData["type"].stringValue
        url = jsonData["url"].stringValue
    }
}
