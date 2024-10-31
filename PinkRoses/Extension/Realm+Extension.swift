//
//  Realm+Extension.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/27.
//

import Foundation
import RealmSwift

extension Realm {
    static func getDefault() throws -> Realm {
        return try Realm(name: "default")
    }
    
    init(name: String) throws {
        let dir = NSHomeDirectory() + "/Documents/Realm/"
        if !FileManager.default.fileExists(atPath: dir) {
            try FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true)
        }
        let path = dir + name + ".realm"
        var configuration = Realm.Configuration.defaultConfiguration
        configuration.schemaVersion = Realm.usableSchemaVersion
        if #available(iOS 16, *) {
            configuration.fileURL = URL(filePath: path)
        } else {
            configuration.fileURL = URL(fileURLWithPath: path)
        }
        try self.init(configuration: configuration)
    }
}
