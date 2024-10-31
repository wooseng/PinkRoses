//
//  Realm+SchemaVersion.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/27.
//

import Foundation
import RealmSwift

extension Realm {
    /// 当前可用的 `schemaVersion`
    ///
    /// 根据应用的版本号、build以及之前的 `schemaVersion` 进行自动计算，得出最新可用的版本
    /// 避免每次更新数据库相关字段后，都要重新设置数据库的`schemaVersion`
    ///
    /// 本地会存储两个字段，已在使用的 `schemaVersion` 和 对应的应用的版本号（版本号 + build）
    /// 如果本地存储的应用版本号与当前的版本号一致，则直接将之前的 `schemaVersion` 返回即可
    /// 如果不一致，则说明应用版本发生了变化，在原来的 `schemaVersion` 基础上 + 1 得到新的 `schemaVersion`
    /// 将新的 `schemaVersion` 及对应的应用版本号存储到本地
    /// 然后将新的 `schemaVersion` 返回
    ///
    /// 注意，本地存储的`schemaVersion`为空表示应用是新安装的，或者是之前的老版本
    public static var usableSchemaVersion: UInt64 {
        let schemaVersionKey = "com.wooseng.realm.schemaVersion.current"
        let appVersionKey = "com.wooseng.realm.schemaVersion.app"
        let oldSchemaVersion = KV.uint64(forKey: schemaVersionKey, defaultValue: 0)
        let oldAppVersionIdentifier = KV.string(forKey: appVersionKey) ?? ""
        let currentAppVersionIdentifier = appVersionIdentifier
        guard currentAppVersionIdentifier != oldAppVersionIdentifier else {
            return oldSchemaVersion
        }
        let newSchemaVersion = oldSchemaVersion + 1
        KV.set(currentAppVersionIdentifier, forKey: appVersionKey)
        KV.set(newSchemaVersion, forKey: schemaVersionKey)
        return newSchemaVersion
    }
    
    /// 缓存的应用版本标识符
    private static var appVersionIdentifierCache: String?
    
    /// 应用版本标识符
    ///
    /// `DEBUG`模式下，应用每次启动都会重新生成一个标识符，便于
    private static var appVersionIdentifier: String {
        if let appVersionIdentifierCache {
            return appVersionIdentifierCache
        }
        #if DEBUG
        let identifier = Date().timeIntervalSince1970.string
        #else
        let identifier = [
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0",
            Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "\(Int.random(in: 1 ... 1000))" // 在获取build失败的时候给个随机值，防止版本号没变化导致出现Crash
        ].joined(separator: ".")
        #endif
        appVersionIdentifierCache = identifier
        return identifier
    }
}
