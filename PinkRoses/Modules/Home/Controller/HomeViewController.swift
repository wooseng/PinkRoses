//
//  HomeViewController.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/26.
//

import UIKit

class HomeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "粉红玫瑰"
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.backgroundColor = .white
    }
    
    override func setupConstraints() {
        super.setupConstraints()
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onSettingClick))
    }
    
    @objc private func onSettingClick() {
        print("设置")
        let vc = AccountListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
