//
//  AppManager.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/12.
//

import Foundation

class AppManager {
    
    static let shared = AppManager()
    
    /// 需要进行刷新的任务列表
    private var refreshTasks = [AppRefreshTask]()
    
    /// 当前正在执行的刷新任务
    private var currentRefreshTask: AppRefreshTask?
    
    private init() {}
}

// MARK: - Builds
extension AppManager {
    /// 刷新指定应用的构建版本列表
    func refreshBuilds(for recordId: String, completion: (() -> Void)? = nil) {
        guard
            let obj = PgyAppRealm.query(forId: recordId),
            let account = PgyAccountRealm.query(forId: obj.accountId)
        else {
            return
        }
        var task = AppBuildListRefreshTask(apiKey: account.apiKey, appKey: obj.appKey)
        task.completion = { [weak self] in
            guard let self else { return }
            self.currentRefreshTask = nil
            self.execTask()
            completion?()
        }
        refreshTasks.append(task)
        execTask()
    }
}

// MARK: - 任务管理
extension AppManager {
    /// 从任务池中获取一个任务进行执行
    private func execTask() {
        guard currentRefreshTask == nil else { return }
        currentRefreshTask = refreshTasks.popLast()
        currentRefreshTask?.start()
    }
}
