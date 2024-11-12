//
//  AppRefreshTask.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/12.
//

import Foundation

protocol AppRefreshTask {
    /// 任务执行结束后的回调闭包
    var completion: (() -> Void)? { get set }
    
    /// 开始执行任务
    func start()
}
