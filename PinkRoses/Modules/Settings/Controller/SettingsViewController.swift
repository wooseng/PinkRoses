//
//  SettingsViewController.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/10/31.
//

import UIKit

/// 设置页面
class SettingsViewController: BaseViewController {

    private var dataSource: [(String, [SettingsRowItem])] = [
        ("蒲公英", [.pgyApiKey, .pgyUserKey])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置"
    }
}
