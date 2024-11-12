//
//  AppBuildListRefreshTask.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/12.
//

import Foundation

/// 刷新应用构建列表的任务
class AppBuildListRefreshTask: AppRefreshTask {
    var completion: (() -> Void)?
    
    private var buildList = [PgyAppBuildListModel]()
    
    let apiKey: String
    let appKey: String
    
    private let cacheKey: String
    
    init(apiKey: String, appKey: String) {
        self.apiKey = apiKey
        self.appKey = appKey
        self.cacheKey = "app.builds.refresh.date.\(appKey)"
    }
    
    func start() {
        if let latestDate = KV.date(forKey: cacheKey), Date().timeIntervalSince(latestDate) < 60 * 5 {
            // 一定时间内只会请求一次
            completion?()
            return
        }
        // 先把时间缓存起来
        KV.set(Date(), forKey: cacheKey)
        request(page: 1)
    }
    
    /// 开始加载指定页码的数据
    private func request(page: Int) {
        let params: [String: Any] = [
            "_api_key": apiKey,
            "appKey": appKey,
            "page": page
        ]
        PgyTarget.queryAppBuildList(params).request(cls: PgyAppBuildListResponse.self) { result in
            switch result {
                case let .success(response):
                    let list = response.list
                    if list.isEmpty {
                        self.didRequestFinish()
                    } else {
                        self.buildList += list
                        self.request(page: page + 1)
                    }
                case .failure:
                    // 移除存储的请求时间
                    KV.removeValue(forKey: self.cacheKey)
                    // 接口请求失败，直接结束
                    self.completion?()
            }
        }
    }
    
    /// 请求完成后执行的事件
    private func didRequestFinish() {
        do {
            // 先删除数据库中应用的老数据
            try PgyAppBuildRealm.deleteAll(forAppKey: appKey)
            // 再把数据存储到数据库中
            try PgyAppBuildRealm.insert(buildList, appKey: appKey)
        } catch {
            // 失败后把缓存时间移除
            KV.removeValue(forKey: cacheKey)
        }
        // 回调
        completion?()
    }
}
