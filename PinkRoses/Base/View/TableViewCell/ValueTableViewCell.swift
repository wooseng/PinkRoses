//
//  ValueTableViewCell.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/10/31.
//

import UIKit

/// 标题+值
class ValueTableViewCell: UITableViewCell {
    /// 标题视图
    private(set) lazy var titleLabel: UILabel = {
        let tmp = UILabel()
        tmp.textColor = .c3C3C3C
        tmp.font = .systemFont(ofSize: 16)
        return tmp
    }()
    
    /// 值视图
    private(set) lazy var valueLabel: UILabel = {
        let tmp = UILabel()
        tmp.textColor = .c666666
        tmp.font = .systemFont(ofSize: 16)
        tmp.numberOfLines = 0
        return tmp
    }()
    
    /// 值右侧图标视图
    private(set) lazy var rightImageView: UIImageView = {
        let tmp = UIImageView()
        tmp.image = R.image.arrow_right()?.resize(width: 25, height: 25)
        tmp.contentMode = .scaleAspectFit
        return tmp
    }()
    
    private lazy var rightStackView: UIStackView = {
        let tmp = UIStackView()
        tmp.axis = .horizontal
        tmp.spacing = 0
        tmp.alignment = .center
        tmp.distribution = .equalSpacing
        tmp.addArrangedSubview(valueLabel)
        tmp.addArrangedSubview(rightImageView)
        return tmp
    }()
    
    private(set) lazy var stackView: UIStackView = {
        let tmp = UIStackView()
        tmp.axis = .horizontal
        tmp.spacing = 10
        tmp.alignment = .center
        tmp.distribution = .equalSpacing
        tmp.addArrangedSubview(titleLabel)
        tmp.addArrangedSubview(rightStackView)
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
        accessoryType = .none
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
}
