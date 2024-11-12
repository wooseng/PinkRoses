//
//  AppDetailViewController.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/12.
//

import UIKit
import MJRefresh

/// 应用详情页面
class AppDetailViewController: BaseViewController {

    private let model: PgyAppRealm
    
    required init(_ model: PgyAppRealm) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = model.appName
        AppManager.shared.refreshBuilds(for: model.id) {
            print("数据请求完毕", PgyAppBuildRealm.query(forAppKey: self.model.appKey))
        }
    }
}
