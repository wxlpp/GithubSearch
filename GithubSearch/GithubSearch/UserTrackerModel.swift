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
import PINCache
struct UserTrackerModel {
    let provider: RxMoyaProvider<GitHub>
    static let shar = UserTrackerModel(provider: github)
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
    func getLanguage(for username: String) -> Observable<String> {
        if let language = PINCache.shared.object(forKey: username) as! String?{
            return Observable<String>.create({ (observer) -> Disposable in
                observer.on(.next(language))
                observer.on(.completed)
                return Disposables.create()
            })
        }
        return provider.request(.repos(username: username)).map(to: [UserReposResponse.self]).map({ (repos) -> String in
            var countDic = [String: Int]()
            repos.forEach({ r in
                if let language = r.language {
                    countDic[language] = (countDic[language] ?? 0) + 1
                }
            })
            countDic.removeValue(forKey: "")
            let ret = countDic.sorted(by: { (dic1, dic2) -> Bool in
                return dic1.value > dic2.value
            })
            let str = ret.count > 0 ? ret[0].key : ""
            PINCache.shared.setObject(str, forKey: username)
            return str
        })
    }
}
