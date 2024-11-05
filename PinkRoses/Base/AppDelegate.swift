//
//  AppDelegate.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KV.initialize()
        window?.rootViewController = BaseNavigationController(rootViewController: AppListViewController())
        return true
    }
}

