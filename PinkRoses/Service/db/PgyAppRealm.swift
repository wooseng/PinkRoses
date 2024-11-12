//
//  PgyAppRealm.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/6.
//

import Foundation
import RealmSwift

/// 存储蒲公英应用列表的数据表
class PgyAppRealm: Object {
    /// 记录的唯一标识
    @Persisted(primaryKey: true) var id: String
    /// 应用所属账号的唯一标识
    @Persisted var accountId: String
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
    /// 是否在首页中显示
    @Persisted var isEnable: Bool
    
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
    
    convenience init(_ obj: PgyAppListModel, account: PgyAccountRealm) {
        self.init()
        id = UUID().uuidString
        accountId = account.id
        appKey = obj.appKey
        appName = obj.buildName
        appIdentifier = obj.buildIdentifier
        appIcon = obj.buildIcon
        appType = obj.buildType.int ?? 0
        isEnable = false
    }
    
    func copy() -> PgyAppRealm {
        let obj = PgyAppRealm()
        obj.id = id
        obj.accountId = accountId
        obj.appKey = appKey
        obj.appName = appName
        obj.appIdentifier = appIdentifier
        obj.appIcon = appIcon
        obj.appType = appType
        obj.isEnable = isEnable
        return obj
    }
}

extension PgyAppRealm {
    /// 新增一条记录
    static func insert(_ obj: PgyAppListModel, account: PgyAccountRealm) throws {
        let obj = PgyAppRealm(obj, account: account)
        try insert(obj, account: account)
    }
    
    /// 新增一条记录
    static func insert(_ obj: PgyAppRealm, account: PgyAccountRealm) throws {
        let realm = try Realm.getDefault()
        try realm.write {
            realm.add(obj)
        }
    }
    
    /// 新增多条记录
    static func insert(_ list: [PgyAppListModel], account: PgyAccountRealm) throws {
        guard !list.isEmpty else {
            return
        }
        let list = list.map {
            PgyAppRealm($0, account: account)
        }
        try insert(list, account: account)
    }
    
    /// 新增多条记录
    static func insert(_ list: [PgyAppRealm], account: PgyAccountRealm) throws {
        guard !list.isEmpty else {
            return
        }
        let realm = try Realm.getDefault()
        try realm.write {
            realm.add(list)
        }
    }
    
    /// 删除指定蒲公英账户对应的全部数据
    static func deleteAll(forAccountId accountId: String) throws {
        let realm = try Realm.getDefault()
        let results = realm.objects(PgyAppRealm.self).filter {
            $0.accountId == accountId
        }
        try realm.write {
            realm.delete(results)
        }
    }
    
    /// 更新指定记录是否在首页显示的状态
    static func updateEnable(_ isEnable: Bool, for recordId: String) throws {
        let realm = try Realm.getDefault()
        guard let obj = realm.object(ofType: PgyAppRealm.self, forPrimaryKey: recordId) else {
            return
        }
        try realm.write {
            obj.isEnable = isEnable
        }
    }
    
    /// 获取全部记录
    static func queryAll(accountId: String?) throws -> [PgyAppRealm] {
        let realm = try Realm.getDefault()
        let results = realm.objects(PgyAppRealm.self)
            .filter { accountId == nil || $0.accountId == accountId }
            .map { $0.copy() }
        return Array(results)
    }
    
    /// 获取全部在首页展示的记录
    static func queryAllForEnable(accountId: String?) throws -> [PgyAppRealm] {
        let realm = try Realm.getDefault()
        let results = realm.objects(PgyAppRealm.self)
            .filter { accountId == nil || $0.accountId == accountId }
            .filter { $0.isEnable }
            .map { $0.copy() }
        return Array(results)
    }
    
    /// 根据记录`id`获取对应的记录
    static func query(forId id: String) -> PgyAppRealm? {
        do {
            let realm = try Realm.getDefault()
            return realm.object(ofType: PgyAppRealm.self, forPrimaryKey: id)?.copy()
        } catch {
            return nil
        }
    }
}
