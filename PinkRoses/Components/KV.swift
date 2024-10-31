//
//  KV.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/27.
//

import Foundation
import MMKV

struct KV {
    private static let mmkv = MMKV(mmapID: "default")
    
    private init() {}
}

// MARK: - 初始化MMKV
extension KV {
    /// 用来标识MMKV是否经过初始化
    private static var mmkv_not_initialized = true
    
    /// 初始化方法，在应用启动后直接调用
    static func initialize() {
        guard mmkv_not_initialized else {
            return
        }
        mmkv_not_initialized = false
        let rootDir = NSHomeDirectory() + "/Documents/KV"
        MMKV.initialize(rootDir: rootDir, logLevel: MMKVLogLevel.info)
    }
}

// MARK: - 数据存储
extension KV {
    static func set(_ value: String, forKey key: String) {
        mmkv?.set(value, forKey: key)
    }
    
    static func set(_ value: Bool, forKey key: String) {
        mmkv?.set(value, forKey: key)
    }
    
    static func set(_ value: Date, forKey key: String) {
        mmkv?.set(value, forKey: key)
    }
    
    static func set(_ value: Data, forKey key: String) {
        mmkv?.set(value, forKey: key)
    }
    
    static func set(_ value: Int, forKey key: String) {
        mmkv?.set(Int64(value), forKey: key)
    }
    
    static func set(_ value: UInt, forKey key: String) {
        mmkv?.set(UInt64(value), forKey: key)
    }
    
    static func set(_ value: Int32, forKey key: String) {
        mmkv?.set(value, forKey: key)
    }
    
    static func set(_ value: UInt32, forKey key: String) {
        mmkv?.set(value, forKey: key)
    }
    
    static func set(_ value: Int64, forKey key: String) {
        mmkv?.set(value, forKey: key)
    }
    
    static func set(_ value: UInt64, forKey key: String) {
        mmkv?.set(value, forKey: key)
    }
    
    static func set(_ value: Float, forKey key: String) {
        mmkv?.set(value, forKey: key)
    }
    
    static func set(_ value: CGFloat, forKey key: String) {
        mmkv?.set(Double(value), forKey: key)
    }
    
    static func set(_ value: Double, forKey key: String) {
        mmkv?.set(value, forKey: key)
    }
}

// MARK: - 数据读取
extension KV {
    static func string(forKey key: String) -> String? {
        mmkv?.string(forKey: key)
    }
    
    static func bool(forKey key: String, defaultValue: Bool = false) -> Bool {
        return mmkv?.bool(forKey: key, defaultValue: defaultValue) ?? defaultValue
    }
    
    static func date(forKey key: String) -> Date? {
        return mmkv?.date(forKey: key)
    }
    
    static func data(forKey key: String) -> Data? {
        return mmkv?.data(forKey: key)
    }
    
    static func int(forKey key: String, defaultValue: Int = 0) -> Int {
        let defaultValue = Int64(defaultValue)
        let int64 = mmkv?.int64(forKey: key, defaultValue: defaultValue) ?? defaultValue
        return Int(int64)
    }
    
    static func uint(forKey key: String, defaultValue: UInt = 0) -> UInt {
        let defaultValue = UInt64(defaultValue)
        let uint64 = mmkv?.uint64(forKey: key, defaultValue: defaultValue) ?? defaultValue
        return UInt(uint64)
    }
    
    static func int32(forKey key: String, defaultValue: Int32 = 0) -> Int32 {
        return mmkv?.int32(forKey: key, defaultValue: defaultValue) ?? defaultValue
    }
    
    static func uint32(forKey key: String, defaultValue: UInt32 = 0) -> UInt32 {
        return mmkv?.uint32(forKey: key) ?? defaultValue
    }
    
    static func int64(forKey key: String, defaultValue: Int64 = 0) -> Int64 {
        return mmkv?.int64(forKey: key, defaultValue: defaultValue) ?? defaultValue
    }
    
    static func uint64(forKey key: String, defaultValue: UInt64 = 0) -> UInt64 {
        return mmkv?.uint64(forKey: key, defaultValue: defaultValue) ?? defaultValue
    }
    
    static func float(forKey key: String, defaultValue: Float = 0) -> Float {
        return mmkv?.float(forKey: key, defaultValue: defaultValue) ?? defaultValue
    }
    
    static func cgfloat(forKey key: String, defaultValue: CGFloat = 0) -> CGFloat {
        let defaultValue = Double(defaultValue)
        let double = mmkv?.double(forKey: key, defaultValue: defaultValue) ?? defaultValue
        return CGFloat(double)
    }
    
    static func double(forKey key: String, defaultValue: Double = 0) -> Double {
        return mmkv?.double(forKey: key, defaultValue: defaultValue) ?? defaultValue
    }
}

// MARK: - 数据清理
extension KV {
    /// 传入一个key，删除对应的数据
    static func removeValue(forKey key: String) {
        mmkv?.removeValue(forKey: key)
    }
    
    /// 传入一个key列表，删除对应的数据
    static func removeValues(forKeys keys: [String]) {
        mmkv?.removeValues(forKeys: keys)
    }
    
    /// 删除所有保存的数据
    static func removeAll() {
        mmkv?.clearAll()
    }
    
    /// 清理内存中的缓存
    ///
    /// 在内存告警时会自动调用
    /// 也可以在合适的时候手动调用
    static func removeMemoryCache() {
        mmkv?.clearMemoryCache()
    }
    
    /// 关闭实例，释放资源，不再使用时调用
    private static func close() {
        mmkv?.close()
    }
}
