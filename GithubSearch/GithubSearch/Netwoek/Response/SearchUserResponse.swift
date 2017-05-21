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
    var id: Int!
    var login: String!
    init?(jsonData: JSON) {
        if jsonData.isEmpty {
            return
        }
        avatarUrl = jsonData["avatar_url"].stringValue
        id = jsonData["id"].intValue
        login = jsonData["login"].stringValue
    }
}
