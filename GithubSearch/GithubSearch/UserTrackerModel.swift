//
//  UserModel.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/21.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import Foundation
import Moya
import Moya_SwiftyJSONMapper
import RxSwift
struct UserTrackerModel {
    let provider: RxMoyaProvider<GitHub>
    func search(username: String) -> Observable<[UserCellModel]> {
        return provider.request(.search(username: username)).map(to: SearchUserResponse.self).map { (r) -> [UserCellModel] in
            r.items.map({ (item) -> UserCellModel in
                let model = UserCellModel()
                model.loginId = NSNumber(integerLiteral: item.id)
                model.avatarPath = item.avatarUrl
                model.languageStr = ""
                model.name = item.login
                return model
            })
        }
    }
}
