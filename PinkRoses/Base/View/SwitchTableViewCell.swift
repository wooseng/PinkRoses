//
//  SwitchTableViewCell.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/10/31.
//

import UIKit

/// 左侧标题，右侧开关
class SwitchTableViewCell: UITableViewCell {
    var didValueChanged: ((Bool) -> Void)?
    
    var value: Bool {
        get { switchItem.isOn }
        set { switchItem.setOn(newValue, animated: true) }
    }
    
    private(set) lazy var titleLabel: UILabel = {
        let tmp = UILabel()
        tmp.textColor = .c3C3C3C
        tmp.font = .systemFont(ofSize: 16)
        return tmp
    }()
    
    private lazy var switchItem: UISwitch = {
        let tmp = UISwitch()
        tmp.addTarget(self, action: #selector(onSwitchItemValueChanged), for: .valueChanged)
        return tmp
    }()
    
    private lazy var stackView: UIStackView = {
        let tmp = UIStackView()
        tmp.axis = .horizontal
        tmp.spacing = 10
        tmp.alignment = .center
        tmp.distribution = .equalSpacing
        tmp.addArrangedSubview(titleLabel)
        tmp.addArrangedSubview(switchItem)
        return tmp
    }()
    
    private(set) lazy var separator: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = .cF0F0F0
        return tmp
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置子视图
    private func setupSubviews() {
        backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(stackView)
        contentView.addSubview(separator)
    }
    
    /// 设置约束
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.top.equalTo(10)
            $0.bottom.equalTo(-10)
        }
        separator.snp.makeConstraints {
            $0.leading.trailing.equalTo(stackView)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    @objc private func onSwitchItemValueChanged() {
        didValueChanged?(switchItem.isOn)
    }
}
