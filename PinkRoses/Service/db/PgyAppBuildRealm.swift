//
//  PgyAppBuildRealm.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/12.
//

import Foundation
import RealmSwift

/// 存储蒲公英应用上传的各个安装包的信息
class PgyAppBuildRealm: Object {
    /// 记录的唯一标识
    @Persisted(primaryKey: true) var id: String
    /// 应用在蒲公英中的唯一标识
    @Persisted var appKey: String
    /// 应用名称
    @Persisted var appName: String
    /// 应用程序包名，iOS为BundleId，Android为包名
    @Persisted var appIdentifier: String
    /// 应用的Icon图标key，访问地址为 `https://www.pgyer.com/image/view/app_icons/<buildIcon>`
    @Persisted var appIcon: String
    /// 应用类型，1:iOS; 2:Android
    @Persisted var appType: Int
    /// 安装包的唯一标识
    @Persisted var buildKey: String
    /// 安装包的版本号
    @Persisted var buildVersion: String
    /// 安装包的构建版本号
    @Persisted var buildVersionNo: String
    /// 蒲公英为每个安装包生成的构建版本号
    @Persisted var buildBuildVersion: String
    /// 应用上传时间
    @Persisted var buildCreated: String
    
    /// 应用图标完整链接
    var icon: URL? {
        let path = "https://www.pgyer.com/image/view/app_icons/" + appIcon
        return URL(string: path)
    }
    
    /// 应用类型图标
    var appTypeLogo: UIImage? {
        switch appType {
            case 1:  return R.image.logo_ios()
            case 2:  return R.image.logo_android()
            default: return nil
        }
    }
    
    convenience init(_ obj: PgyAppBuildListModel, appKey: String) {
        self.init()
        self.id = UUID().uuidString
        self.appKey = appKey
        self.appName = obj.buildName
        self.appIdentifier = obj.buildIdentifier
        self.appIcon = obj.buildIcon
        self.appType = obj.buildType.int ?? 0
        self.buildKey = obj.buildKey
        self.buildVersion = obj.buildVersion
        self.buildVersionNo = obj.buildVersionNo
        self.buildBuildVersion = obj.buildBuildVersion
        self.buildCreated = obj.buildCreated
    }
    
    func copy() -> PgyAppBuildRealm {
        let obj = PgyAppBuildRealm()
        obj.id = self.id
        obj.appKey = self.appKey
        obj.appName = self.appName
        obj.appIdentifier = self.appIdentifier
        obj.appIcon = self.appIcon
        obj.appType = self.appType
        obj.buildKey = self.buildKey
        obj.buildVersion = self.buildVersion
        obj.buildVersionNo = self.buildVersionNo
        obj.buildBuildVersion = self.buildBuildVersion
        obj.buildCreated = self.buildCreated
        return obj
    }
}

extension PgyAppBuildRealm {
    /// 新增多条记录
    static func insert(_ list: [PgyAppBuildListModel], appKey: String) throws {
        let list = list.map {
            PgyAppBuildRealm($0, appKey: appKey)
        }
        try insert(list)
    }
    
    /// 新增多条记录
    static func insert(_ list: [PgyAppBuildRealm]) throws {
        let realm = try Realm.getDefault()
        try realm.write {
            realm.add(list)
        }
    }
    
    /// 删除指定`appKey`的全部数据
    static func deleteAll(forAppKey appKey: String) throws {
        let realm = try Realm.getDefault()
        let objects = realm.objects(PgyAppBuildRealm.self).filter {
            $0.appKey == appKey
        }
        if objects.isEmpty {
            return
        }
        try realm.write {
            realm.delete(objects)
        }
    }
    
    /// 获取指定`appKey`的全部数据
    static func query(forAppKey appKey: String) -> [PgyAppBuildRealm] {
        do {
            let realm = try Realm.getDefault()
            let objects = realm.objects(PgyAppBuildRealm.self).filter {
                $0.appKey == appKey
            }.map {
                $0.copy()
            }
            return Array(objects)
        } catch {
            return []
        }
    }
}
