//
//  PgyTarget.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/4.
//

import Foundation
import Moya

enum PgyTarget {
    /// 获取应用列表
    case queryAppList([String: Any])
    /// 获取应用的版本列表
    case queryAppBuildList([String: Any])
    /// 获取应用的详细信息
    case queryAppDetail([String: Any])
}

extension PgyTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.pgyer.com/apiv2")!
    }
    
    var path: String {
        switch self {
            case .queryAppList:
                return "app/listMy"
            case .queryAppBuildList:
                return "app/builds"
            case .queryAppDetail:
                return "app/view"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
    
    var task: Task {
        switch self {
            case let .queryAppList(params):
                return .requestParameters(parameters: params, encoding: URLEncoding.default)
            case let .queryAppBuildList(params):
                return .requestParameters(parameters: params, encoding: URLEncoding.default)
            case let .queryAppDetail(params):
                return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}

private let provider = MoyaProvider<PgyTarget>()

extension PgyTarget {
    func request<T: Decodable>(cls: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(self) { result in
            switch result {
                case let .success(response):
                    do {
                        let res = try response.map(PgyResponse<T>.self)
                        completion(.success(res.data))
                    } catch {
                        completion(.failure(error))
                    }
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }
}
