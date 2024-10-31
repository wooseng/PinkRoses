//
//  AccountListViewController.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/10/31.
//

import UIKit
import QMUIKit
import RxSwift
import RxRelay
import RxCocoa

/// 蒲公英账号列表页面
class AccountListViewController: BaseViewController {
    private let dataSource = BehaviorRelay<[PgyAccountRealm]>(value: [])
    
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
        tmp.register(cellWithClass: SwitchTableViewCell.self)
        return tmp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "账号"
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
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupBindings() {
        super.setupBindings()
        dataSource.observe(on: MainScheduler.instance).bind { [weak self] _ in
            guard let self else { return }
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    private func loadData() {
        let list = PgyAccountRealm.queryAll()
        dataSource.accept(list)
    }
}

extension AccountListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account = dataSource.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withClass: SwitchTableViewCell.self)
        cell.titleLabel.text = account.accountName
        cell.value = account.isCurrent
        cell.didValueChanged = { [weak self] isOn in
            guard let self else { return }
            var indexPaths = [indexPath]
            if let last = PgyAccountRealm.queryCurrent()?.id, let index = self.dataSource.value.firstIndex(where: { $0.id == last }) {
                indexPaths.append(IndexPath(row: index, section: 0))
            }
            PgyAccountRealm.setCurrent(forId: isOn ? account.id : nil)
            self.tableView.reloadRows(at: indexPaths, with: .none)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let record = dataSource.value[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "删除") { _, _, completion in
            PgyAccountRealm.delete(id: record.id)
            self.loadData()
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
