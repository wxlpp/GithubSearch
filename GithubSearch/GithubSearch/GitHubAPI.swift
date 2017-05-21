//
//  GithubAPI.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/20.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import Foundation
import Moya

let accessToken = "adfed01023c776c86f9d49978fa0e872d3119d33"
let endpointClosure = { (target: GitHub) -> Endpoint<GitHub> in
    let defaultEndpoint = RxMoyaProvider.defaultEndpointMapping(for: target)
    return defaultEndpoint.adding(newHTTPHeaderFields: ["Authorization": "token \(accessToken)"])
}

let github = RxMoyaProvider<GitHub>(endpointClosure: endpointClosure)

enum GitHub {
    case search(username: String, page: Int)
    case repos(username: String)
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
        case let .repos(name):
            return "users/\(name)/repos"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var parameters: [String: Any]? {
        switch self {
        case let .search(name, page):
            return ["in": "login","type": "user","q": name, "page": page]
        case .repos: return nil
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
