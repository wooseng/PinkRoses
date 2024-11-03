//
//  BaseViewController.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/26.
//

import UIKit
import QMUIKit
import SnapKit
import RxSwift
import SwifterSwift

/// 基础视图控制器
class BaseViewController: UIViewController, QMUINavigationControllerDelegate {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        setupNavigationItems()
        setupBindings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    func shouldCustomizeNavigationBarTransitionIfHideable() -> Bool { true }
    
    func preferredNavigationBarHidden() -> Bool { false }
    
    func qmui_backBarButtonItemTitle(withPreviousViewController viewController: UIViewController?) -> String? {
        return ""
    }
    
    /// 设置子视图
    func setupSubviews() {
        view.backgroundColor = .cF5F6FA
    }
    
    /// 设置约束
    func setupConstraints() {}
    
    /// 设置导航栏两侧的视图
    func setupNavigationItems() {}
    
    /// 设置数据绑定
    func setupBindings() {}
}

