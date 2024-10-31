//
//  PgyAccountRealm.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/10/31.
//

import Foundation
import RealmSwift

/// 蒲公英账号信息表
class PgyAccountRealm: Object {
    /// 账号的唯一标识
    @Persisted(primaryKey: true) var id: String
    /// 账号名
    @Persisted var accountName: String
    /// 蒲公英生成的API Key
    @Persisted var apiKey: String
    /// 蒲公英生成的User Key
    @Persisted var userKey: String
    
    func copy() -> PgyAccountRealm {
        let obj = PgyAccountRealm()
        obj.id = id
        obj.accountName = accountName
        obj.apiKey = apiKey
        obj.userKey = userKey
        return obj
    }
}

extension PgyAccountRealm {
    /// 更新记录，如果`id`为空，则会新增一条记录
    static func update(id: String? = nil, accountName: String, apiKey: String, userKey: String) {
        do {
            let realm = try Realm.getDefault()
            if let id, let record = realm.object(ofType: PgyAccountRealm.self, forPrimaryKey: id) {
                try realm.write {
                    record.accountName = accountName
                    record.apiKey = apiKey
                    record.userKey = userKey
                }
            } else {
                let record = PgyAccountRealm()
                record.id = UUID().uuidString
                record.accountName = accountName
                record.apiKey = apiKey
                record.userKey = userKey
                try realm.write {
                    realm.add(record)
                }
            }
        } catch {
            print("新增或更新账号失败：", error.localizedDescription)
        }
    }
    
    /// 删除指定账号
    static func delete(id: String) {
        do {
            let realm = try Realm.getDefault()
            guard let record = realm.object(ofType: PgyAccountRealm.self, forPrimaryKey: id) else {
                return
            }
            try realm.write {
                realm.delete(record)
            }
        } catch {
            print("删除账号失败：", error.localizedDescription)
        }
    }
    
    /// 删除全部账号
    static func deleteAll() {
        do {
            let realm = try Realm.getDefault()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("删除账号失败：", error.localizedDescription)
        }
    }
    
    /// 获取全部账号
    static func queryAll() -> [PgyAccountRealm] {
        do {
            let realm = try Realm.getDefault()
            let result = realm.objects(PgyAccountRealm.self).map { $0.copy() }
            return Array(result)
        } catch {
            print("获取全部账号失败：", error.localizedDescription)
            return []
        }
    }
    
    /// 获取指定`id`对应的账号
    static func query(forId id: String) -> PgyAccountRealm? {
        do {
            let realm = try Realm.getDefault()
            return realm.object(ofType: PgyAccountRealm.self, forPrimaryKey: id)?.copy()
        } catch {
            print("获取全部账号失败：", error.localizedDescription)
            return nil
        }
    }
    
}

// MARK: - 当前账号
extension PgyAccountRealm {
    /// 获取当前使用的账号
    static func queryCurrent() -> PgyAccountRealm? {
        do {
            let realm = try Realm.getDefault()
            return realm.objects(PgyAccountRealm.self).filter { $0.isCurrent }.first?.copy()
        } catch {
            print("获取当前账号失败：", error.localizedDescription)
            return nil
        }
    }
    
    /// 把指定账号设置为当前账号
    static func setCurrent(forId id: String?) {
        let key = "pgy.account.current.id"
        if let id {
            KV.set(id, forKey: key)
        } else {
            KV.removeValue(forKey: key)
        }
    }
    
    /// 是否是当前正在使用的账号
    var isCurrent: Bool {
        return id == KV.string(forKey: "pgy.account.current.id")
    }
}
