//
//  Loading.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/26.
//

import Foundation
import QMUIKit

struct Loading {
    private init() {}
    
    private var tips: QMUITips?
    
    static func show(text: String?, in view: UIView) -> Loading {
        var loading = Loading()
        loading.tips = QMUITips.showLoading(text, in: view)
        return loading
    }
    
    func hide(animated: Bool) {
        tips?.hide(animated: animated)
    }
    
    static func hideAll(in view: UIView? = nil) {
        if let view {
            QMUITips.hideAllTips(in: view)
        } else {
            QMUITips.hideAllTips()
        }
    }
}
