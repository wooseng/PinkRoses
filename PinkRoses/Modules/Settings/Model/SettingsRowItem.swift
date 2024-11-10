//
//  SettingsRowItem.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/10/31.
//

import Foundation

enum SettingsRowItem {
    case accounts
    case apps
}

extension SettingsRowItem {
    var title: String {
        switch self {
            case .accounts: return "账号管理"
            case .apps:     return "应用管理"
        }
    }
}
