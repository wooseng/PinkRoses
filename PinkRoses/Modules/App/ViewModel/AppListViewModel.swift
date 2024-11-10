//
//  AppListViewModel.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/5.
//

import Foundation
import RxSwift
import RxRelay

class AppListViewModel {
    /// 账号列表
    let accounts = BehaviorRelay<[PgyAccountRealm]>(value: [])
    /// 账号对应的应用数据
    let apps = BehaviorRelay<[String: [PgyAppRealm]]>(value: [:])
    
    private var isRefreshing = false
}

// MARK: - 刷新列表数据
extension AppListViewModel {
    /// 刷新应用列表
    func refresh(_ completion: (() -> Void)? = nil) {
        let accounts = PgyAccountRealm.queryAll()
        self.accounts.accept(accounts)
        loadAppsFromRealm(accounts: accounts)
        guard !accounts.isEmpty else {
            completion?()
            return
        }
        if isRefreshing {
            completion?()
            return
        }
        isRefreshing = true
        refresh(accounts: accounts, index: 0) { [weak self] in
            guard let self else { return }
            self.isRefreshing = false
            completion?()
        }
    }
    
    /// 刷新指定账号列表中的全部应用列表
    private func refresh(accounts: [PgyAccountRealm], index: Int, _ completion: @escaping () -> Void) {
        guard let account = accounts[safe: index] else {
            completion()
            return
        }
        let key = "account.apps.refresh.latest." + account.id
        if let latestDate = KV.date(forKey: key), Date().timeIntervalSince(latestDate) < 60 * 5 {
            // 五分钟以内同一账号只会请求一次
            completion()
            return
        }
        refresh(account: account, page: 1, list: []) { [weak self] result in
            guard let self else { return }
            switch result {
                case let .success(list):
                    self.save(list, account: account)
                    self.loadAppsFromRealm(account: account)
                    KV.set(Date(), forKey: key)
                case .failure:
                    break
            }
            self.refresh(accounts: accounts, index: index + 1, completion)
        }
    }
    
    /// 刷新指定账号的应用列表
    private func refresh(account: PgyAccountRealm,
                         page: Int,
                         list: [PgyAppListModel],
                         _ completion: @escaping (Result<[PgyAppListModel], Error>) -> Void) {
        print("开始获取应用列表：", account.accountName, page)
        let params: [String: Any] = [
            "_api_key": account.apiKey,
            "page": page
        ]
        PgyTarget.queryAppList(params).request(cls: PgyAppListResponse.self) { [weak self] result in
            guard let self else { return }
            switch result {
                case let .success(response):
                    let newList = list + response.list
                    if response.list.isEmpty {
                        // 数据请求完了，将结果回调
                        completion(.success(newList))
                    } else {
                        // 数据没有请求完，继续下一页
                        self.refresh(account: account, page: page + 1, list: newList, completion)
                    }
                case let .failure(error):
                    // 请求失败，直接报错
                    completion(.failure(error))
            }
        }
    }
}

extension AppListViewModel {
    /// 保存数据到本地
    private func save(_ list: [PgyAppListModel], account: PgyAccountRealm) {
        // 先获取本地存储的已在首页显示的应用
        let appKeys = (try? PgyAppRealm.queryAllForEnable(accountId: account.id))?.map { $0.appKey } ?? []
        // 将列表数据转为数据库存储对象
        let list = list.map {
            let obj = PgyAppRealm($0, account: account)
            // 原来已经在首页选中的，也需要在首页选中
            obj.isEnable = appKeys.contains(obj.appKey)
            return obj
        }
        try? PgyAppRealm.deleteAll(forAccountId: account.id)
        try? PgyAppRealm.insert(list, account: account)
    }
    
    /// 从数据库中加载应用列表
    private func loadAppsFromRealm(accounts: [PgyAccountRealm]) {
        var apps = [String: [PgyAppRealm]]()
        for account in accounts {
            do {
                let list = try PgyAppRealm.queryAll(accountId: account.id)
                apps[account.id] = list
            } catch {}
        }
        self.apps.accept(apps)
    }
    
    /// 从数据库中加载应用列表
    private func loadAppsFromRealm(account: PgyAccountRealm) {
        loadAppsFromRealm(account: account.id)
    }
    
    /// 从数据库中加载应用列表
    private func loadAppsFromRealm(account: String) {
        guard let list = try? PgyAppRealm.queryAll(accountId: account) else {
            return
        }
        var apps = apps.value
        apps[account] = list
        self.apps.accept(apps)
    }
    
}

extension AppListViewModel {
    func setEnable(_ isEnable: Bool, for record: PgyAppRealm) {
        do {
            try PgyAppRealm.updateEnable(isEnable, for: record.id)
            loadAppsFromRealm(account: record.accountId)
        } catch { }
    }
}
