//
//  AppFollowListViewController.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/10.
//

import UIKit
import QMUIKit
import RxSwift
import RxRelay

/// 用户所关注的应用列表页面，也就是目前的首页
class AppFollowListViewController: BaseViewController {
    /// 账号列表
    private var accounts = [PgyAccountRealm]()
    /// 账号对应的应用数据
    private var apps = [String: [PgyAppRealm]]()
    
    private lazy var tableView: UITableView = {
        let tmp = UITableView(frame: .zero, style: .plain)
        tmp.separatorStyle = .none
        tmp.backgroundColor = .cF5F6FA
        tmp.delegate = self
        tmp.dataSource = self
        tmp.contentInsetAdjustmentBehavior = .never
        if #available(iOS 15.0, *) {
            tmp.sectionHeaderTopPadding = 0
        }
        tmp.register(cellWithClass: AppFollowListCell.self)
        return tmp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "关注列表"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottomMargin)
        }
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.settings()?.resize(width: 25, height: 25),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onSettingClick))
    }
    
    @objc private func onSettingClick() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func loadData() {
        let accounts = PgyAccountRealm.queryAll()
        var apps = [String: [PgyAppRealm]]()
        for account in accounts {
            guard let list = try? PgyAppRealm.queryAllForEnable(accountId: account.id), !list.isEmpty else {
                continue
            }
            apps[account.id] = list
        }
        self.accounts = accounts.filter { apps.keys.contains($0.id) }
        self.apps = apps
        self.tableView.reloadData()
    }
}

extension AppFollowListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = QMUILabel()
        header.text = accounts[section].accountName
        header.textColor = .c666666
        header.font = .systemFont(ofSize: 14)
        header.backgroundColor = tableView.backgroundColor
        header.contentEdgeInsets = UIEdgeInsets(horizontal: 32, vertical: 0)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let account = accounts[section]
        return apps[account.id]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account = accounts[indexPath.section]
        let apps = apps[account.id] ?? []
        let cell = tableView.dequeueReusableCell(withClass: AppFollowListCell.self, for: indexPath)
        cell.model = apps[indexPath.row]
        cell.separator.isHidden = indexPath.row == apps.count - 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let account = accounts[indexPath.section]
        guard let app = apps[account.id]?[indexPath.row] else {
            return
        }
        let vc = AppDetailViewController(app)
        navigationController?.pushViewController(vc, animated: true)
    }
}
