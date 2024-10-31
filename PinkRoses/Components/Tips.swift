//
//  Tips.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/26.
//

import Foundation
import QMUIKit

struct Tips {
    private init() {}
    
    private static func paragraphStyle(alignment: NSTextAlignment, lineSpacing: CGFloat) -> NSMutableParagraphStyle {
        let tmp = NSMutableParagraphStyle()
        tmp.alignment = alignment
        tmp.lineSpacing = lineSpacing
        return tmp
    }
    
    private static let alertTitleAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.c3C3C3C,
        .font: UIFont.systemFont(ofSize: 16, weight: .medium),
        .paragraphStyle: paragraphStyle(alignment: .center, lineSpacing: 5)
    ]
    
    private static let alertMessageAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.c3C3C3C,
        .font: UIFont.systemFont(ofSize: 16, weight: .regular),
        .paragraphStyle: paragraphStyle(alignment: .center, lineSpacing: 5)
    ]
    
    private static let alertCancelButtonAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.c999999,
        .font: UIFont.systemFont(ofSize: 16, weight: .regular)
    ]
    
    private static let alertButtonAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.c3C3C3C,
        .font: UIFont.systemFont(ofSize: 16, weight: .regular)
    ]
}

extension Tips {
    static func showAlert(title: String?,
                          message: String?,
                          okTitle: String = "确定",
                          onOk: (() -> Void)? = nil) {
        let okAction = QMUIAlertAction(title: okTitle, style: .default) { _, _ in
            onOk?()
        }
        let alert = QMUIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.alertTitleAttributes = alertTitleAttributes
        alert.alertMessageAttributes = alertMessageAttributes
        alert.alertCancelButtonAttributes = alertCancelButtonAttributes
        alert.alertButtonAttributes = alertButtonAttributes
        alert.alertTitleMessageSpacing = 10
        alert.addAction(okAction)
        alert.showWith(animated: true)
    }
    
    static func showConfirm(title: String?,
                            message: String?,
                            cancelTitle: String = "取消",
                            okTitle: String = "确定",
                            onCancel: (() -> Void)?,
                            onOk: (() -> Void)?) {
        let cancelAction = QMUIAlertAction(title: cancelTitle, style: .cancel) { _, _ in
            onCancel?()
        }
        let okAction = QMUIAlertAction(title: okTitle, style: .default) { _, _ in
            onOk?()
        }
        let alert = QMUIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.alertTitleAttributes = alertTitleAttributes
        alert.alertMessageAttributes = alertMessageAttributes
        alert.alertCancelButtonAttributes = alertCancelButtonAttributes
        alert.alertButtonAttributes = alertButtonAttributes
        alert.alertTitleMessageSpacing = 10
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.showWith(animated: true)
    }
}

extension QMUITips {
    
}
