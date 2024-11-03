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
        let tips = QMUITips.show(withText: msg)
        tips.isUserInteractionEnabled = false
    }
    
    static func success(_ msg: String) {
        let tips = QMUITips.showSucceed(msg)
        tips.isUserInteractionEnabled = false
    }
    
    static func error(_ msg: String) {
        let tips = QMUITips.showError(msg)
        tips.isUserInteractionEnabled = false
    }
}
