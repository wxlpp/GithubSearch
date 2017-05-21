//
//  GithubAPI.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/20.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import Foundation
import Moya

let github = RxMoyaProvider<GitHub>()
let token = "38217e6f50fb59b3c5dad9eecc128e676e9c29b6"
enum GitHub {
    case search(username: String)
}
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
extension GitHub: TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var path: String {
        switch self {
        case .search:
            return "/search/users"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var parameters: [String: Any]? {
        switch self {
        case .search(let name):
            return ["q": name.urlEscaped,"access_token": token]
        }
    }
        var task: Task {
            return .request
        }
        var parameterEncoding: ParameterEncoding {
            return URLEncoding.default
        }
        public var sampleData: Data {
            return "{\"total_count\":1,\"incomplete_results\":false,\"items\":[{\"login\":\"wxlpp\",\"id\":6649664,\"avatar_url\":\"https://avatars0.githubusercontent.com/u/6649664?v=3\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/wxlpp\",\"html_url\":\"https://github.com/wxlpp\",\"followers_url\":\"https://api.github.com/users/wxlpp/followers\",\"following_url\":\"https://api.github.com/users/wxlpp/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/wxlpp/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/wxlpp/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/wxlpp/subscriptions\",\"organizations_url\":\"https://api.github.com/users/wxlpp/orgs\",\"repos_url\":\"https://api.github.com/users/wxlpp/repos\",\"events_url\":\"https://api.github.com/users/wxlpp/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/wxlpp/received_events\",\"type\":\"User\",\"site_admin\":false,\"score\":36.645664}]}".data(using: String.Encoding.utf8)!
        }
    }
