//
//  UserReposResponse.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/21.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import Foundation
import Moya_SwiftyJSONMapper
import SwiftyJSON


class UserReposResponse : ALSwiftyJSONAble {
    var language : String?
    required init?(jsonData: JSON) {
        if jsonData.isEmpty {
            return
        }
        language = jsonData["language"].stringValue
       
    }
}
