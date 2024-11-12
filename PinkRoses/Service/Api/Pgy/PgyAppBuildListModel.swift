//
//  PgyAppBuildListModel.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/12.
//

import Foundation

/// 蒲公英构建版本列表返回的数据
struct PgyAppBuildListModel: Decodable {
    /// 应用名称
    var buildName: String
    /// 应用程序包名，iOS为BundleId，Android为包名
    var buildIdentifier: String
    /// 应用的Icon图标key，访问地址为 `https://www.pgyer.com/image/view/app_icons/<buildIcon>`
    var buildIcon: String
    /// 应用类型，1:iOS; 2:Android
    var buildType: String
    /// 安装包的唯一标识
    var buildKey: String
    /// 安装包的版本号
    var buildVersion: String
    /// 安装包的构建版本号
    var buildVersionNo: String
    /// 蒲公英为每个安装包生成的构建版本号
    var buildBuildVersion: String
    /// 应用上传时间
    var buildCreated: String
}
