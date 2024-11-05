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
    /// 版本号, 默认为1.0 (是应用向用户宣传时候用到的标识，例如：1.1、8.2.1等。)
    var buildVersion: String
    /// 上传包的版本编号，默认为1 (即编译的版本号，一般来说，编译一次会变动一次这个版本号, 在 Android 上叫 Version Code。对于 iOS 来说，是字符串类型；对于 Android 来说是一个整数。例如：1001，28等。)
    var buildVersionNo: String
    /// 蒲公英生成的用于区分历史版本的build号
    var buildBuildVersion: String
    /// 应用程序包名，iOS为BundleId，Android为包名
    var buildIdentifier: String
    /// 应用的Icon图标key，访问地址为 `https://www.pgyer.com/image/view/app_icons/<buildIcon>`
    var buildIcon: String
    /// 应用上传时间
    var buildCreated: String
    /// App 文件大小
    var buildFileSize: String
}

extension PgyAppListModel {
    var icon: URL? {
        let path = "https://www.pgyer.com/image/view/app_icons/" + buildIcon
        return URL(string: path)
    }
}
