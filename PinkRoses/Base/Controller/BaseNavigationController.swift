//
//  BaseNavigationController.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/26.
//

import UIKit
import QMUIKit

class BaseNavigationController: QMUINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(backgroundColor: .white)
        navigationBar.tintColor = .c666666
    }
}

extension UINavigationController {
    func setNavigationBar(backgroundColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = backgroundColor
        appearance.shadowColor = UIColor.clear
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
}
