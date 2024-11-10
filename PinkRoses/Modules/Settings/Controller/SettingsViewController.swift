//
//  SettingsViewController.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/10/31.
//

import UIKit
import QMUIKit

/// 设置页面
class SettingsViewController: BaseViewController {
    private var dataSource: [(title: String, items: [SettingsRowItem])] = [
        ("通用", [.accounts, .apps]),
    ]
    
    private lazy var tableView: UITableView = {
        let tmp = UITableView(frame: .zero, style: .plain)
        tmp.separatorStyle = .none
        tmp.backgroundColor = UIColor.cF5F6FA
        tmp.delegate = self
        tmp.dataSource = self
        tmp.showsVerticalScrollIndicator = false
        tmp.contentInsetAdjustmentBehavior = .never
        if #available(iOS 15.0, *) {
            tmp.sectionHeaderTopPadding = 0
        }
        tmp.register(cellWithClass: ValueTableViewCell.self)
        return tmp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置"
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.bottom.equalTo(view.snp.bottomMargin)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = QMUILabel()
        header.backgroundColor = tableView.backgroundColor
        header.text = dataSource[section].title
        header.textColor = UIColor.c666666
        header.font = UIFont.systemFont(ofSize: 14, weight: .medium)
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
        return dataSource[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = dataSource[indexPath.section].items
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withClass: ValueTableViewCell.self, for: indexPath)
        cell.titleLabel.text = item.title
        cell.separator.isHidden = indexPath.row == items.count - 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = dataSource[indexPath.section].items[indexPath.row]
        switch item {
            case .accounts:
                let vc = AccountListViewController()
                navigationController?.pushViewController(vc, animated: true)
            case .apps:
                let vc = AppListViewController()
                navigationController?.pushViewController(vc, animated: true)
        }
    }
}
