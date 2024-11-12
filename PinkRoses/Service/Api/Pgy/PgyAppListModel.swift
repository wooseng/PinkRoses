//
//  PgyAppListModel.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/5.
//

import Foundation

/// 蒲公英应用列表返回的应用数据的Model
struct PgyAppListModel: Decodable {
    /// 表示一个App组的唯一Key
    var appKey: String
    /// Build Key是唯一标识应用的索引ID
    var buildKey: String
    /// 应用名称
    var buildName: String
    /// 应用类型（1:iOS; 2:Android）
    var buildType: String
    /// 应用程序包名，iOS为BundleId，Android为包名
    var buildIdentifier: String
    /// 应用的Icon图标key，访问地址为 `https://www.pgyer.com/image/view/app_icons/<buildIcon>`
    var buildIcon: String
}
