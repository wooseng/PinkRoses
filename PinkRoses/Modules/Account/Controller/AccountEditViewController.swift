//
//  AccountEditViewController.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/3.
//

import UIKit

class AccountEditViewController: BaseViewController {
    var completion: (() -> Void)?

    private lazy var accountNameItem: TitleTextFieldItem = {
        let tmp = TitleTextFieldItem()
        tmp.titleLabel.text = "账号名称"
        tmp.textField.placeholder = "请输入账号名称"
        return tmp
    }()
    
    private lazy var apiKeyItem: TitleTextFieldItem = {
        let tmp = TitleTextFieldItem()
        tmp.titleLabel.text = "API Key"
        tmp.textField.placeholder = "请输入API Key"
        return tmp
    }()
    
    private lazy var userKeyItem: TitleTextFieldItem = {
        let tmp = TitleTextFieldItem()
        tmp.titleLabel.text = "User Key"
        tmp.textField.placeholder = "请输入User Key"
        tmp.separator.isHidden = true
        return tmp
    }()
    
    private lazy var stackView: UIStackView = {
        let tmp = UIStackView()
        tmp.axis = .vertical
        tmp.spacing = 0
        tmp.alignment = .fill
        tmp.distribution = .equalSpacing
        tmp.addArrangedSubview(accountNameItem)
        tmp.addArrangedSubview(apiKeyItem)
        tmp.addArrangedSubview(userKeyItem)
        return tmp
    }()
    
    let id: String?
    
    required init(id: String? = nil) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = id == nil ? "新增账号" : "修改账号"
        loadData()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.addSubview(stackView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(onDoneClick))
    }
    
    override func setupBindings() {
        super.setupBindings()
    }
    
    @objc private func onDoneClick() {
        guard let accountName = accountNameItem.textField.text?.trimmed, !accountName.isEmpty else {
            Toast.show("请输入账号名称")
            return
        }
        guard let apiKey = apiKeyItem.textField.text?.trimmed, !apiKey.isEmpty else {
            Toast.show("请输入API Key")
            return
        }
        guard let userKey = userKeyItem.textField.text?.trimmed, !userKey.isEmpty else {
            Toast.show("请输入User Key")
            return
        }
        do {
            try PgyAccountRealm.update(id: id, accountName: accountName, apiKey: apiKey, userKey: userKey)
            navigationController?.popViewController(animated: true)
            completion?()
        } catch {
            Toast.show(error.localizedDescription)
        }
    }
    
    private func loadData() {
        guard let id, let record = PgyAccountRealm.query(forId: id) else {
            return
        }
        accountNameItem.textField.text = record.accountName
        apiKeyItem.textField.text = record.apiKey
        userKeyItem.textField.text = record.userKey
    }
}
