//
//  AppListViewModel.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/5.
//

import Foundation

class AppListViewModel {
    private var dataSource = [String: Result<[PgyAppListModel], Error>]()
    
    private var isRefreshing = false
}

// MARK: - 刷新列表数据
extension AppListViewModel {
    /// 刷新应用列表
    func refresh(_ completion: (() -> Void)? = nil) {
        let accounts = PgyAccountRealm.queryAll()
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
        refresh(account: account, page: 1, list: []) { [weak self] result in
            guard let self else { return }
            self.dataSource[account.id] = result
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

// MARK: - 读取数据
extension AppListViewModel {
    /// 根据账号id获取对应的应用列表
    func list(for account: String) -> Result<[PgyAppListModel], Error>? {
        return dataSource[account]
    }
}
