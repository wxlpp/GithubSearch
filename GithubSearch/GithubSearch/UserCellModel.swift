//
//  UserCellModel.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/21.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import IGListKit

class UserCellModel :IGListDiffable {
    var loginId:NSNumber = 0
    var name = ""
    var languageStr = ""
    var avatarPath = ""
    
    public func diffIdentifier() -> NSObjectProtocol {
        return loginId
    }
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return loginId.isEqual(object?.diffIdentifier())
    }
    
}
