//
//  AppListViewController.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/26.
//

import UIKit
import QMUIKit

class AppListViewController: BaseViewController {
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
}

extension AppListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.accounts.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = QMUILabel()
        header.text = vm.accounts.value[section].accountName
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
        let account = vm.accounts.value[section]
        return vm.apps.value[account.id]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account = vm.accounts.value[indexPath.section]
        let apps = vm.apps.value[account.id] ?? []
        let model = apps[indexPath.row]
        let cell = tableView.dequeueReusableCell(withClass: AppListCell.self, for: indexPath)
        cell.model = model
        cell.separator.isHidden = indexPath.row == apps.count - 1
        cell.didEnableStatusChanged = { [weak self] isEnable in
            guard let self else { return }
            self.vm.setEnable(isEnable, for: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
