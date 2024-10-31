//
//  Toast.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/26.
//

import Foundation
import QMUIKit

struct Toast {
    private init() {}
    
    static func show(_ msg: String) {
        QMUITips.show(withText: msg)
    }
    
    static func success(_ msg: String) {
        QMUITips.showSucceed(msg)
    }
    
    static func error(_ msg: String) {
        QMUITips.showError(msg)
    }
}
