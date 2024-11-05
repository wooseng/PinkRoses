//
//  AppListViewController.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/26.
//

import UIKit
import QMUIKit

class AppListViewController: BaseViewController {
    /// 账号列表
    private var accounts = [PgyAccountRealm]()
    
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
        tmp.register(cellWithClass: AppListCell.self)
        return tmp
    }()
    
    private let vm = AppListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "应用列表"
        accounts = PgyAccountRealm.queryAll()
        vm.refresh { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
        }
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
        let vc = AccountListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AppListViewController: UITableViewDelegate, UITableViewDataSource {
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
        let result = vm.list(for: account.id)
        switch result {
            case let .success(list):
                return list.count
            case .failure:
                return 0
            case .none:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: AppListCell.self, for: indexPath)
        let account = accounts[indexPath.section]
        let result = vm.list(for: account.id)
        switch result {
            case let .success(list):
                cell.model = list[safe: indexPath.row]
            case .failure:
                cell.model = nil
            case .none:
                cell.model = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
