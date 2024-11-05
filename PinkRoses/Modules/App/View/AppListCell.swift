//
//  AppListCell.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/5.
//

import UIKit
import Kingfisher

/// 应用列表的`cell`
class AppListCell: UITableViewCell {
    var model: PgyAppListModel? {
        didSet {
            appNameLabel.text = model?.buildName
            buildIdentifierLabel.text = model?.buildIdentifier
            iconImageView.kf.setImage(with: model?.icon)
        }
    }
    
    private lazy var iconImageView: UIImageView = {
        let tmp = UIImageView()
        tmp.contentMode = .scaleAspectFit
        tmp.layer.cornerRadius = 6
        tmp.layer.masksToBounds = true
        tmp.backgroundColor = .cF5F6FA
        return tmp
    }()
    
    private lazy var appNameLabel: UILabel = {
        let tmp = UILabel()
        tmp.textColor = .c3C3C3C
        tmp.font = .boldSystemFont(ofSize: 16)
        return tmp
    }()
    
    private lazy var buildIdentifierLabel: UILabel = {
        let tmp = UILabel()
        tmp.textColor = .c666666
        tmp.font = .systemFont(ofSize: 12)
        return tmp
    }()
    
    private lazy var stackView: UIStackView = {
        let tmp = UIStackView()
        tmp.axis = .vertical
        tmp.spacing = 0
        tmp.alignment = .leading
        tmp.distribution = .equalSpacing
        tmp.addArrangedSubview(appNameLabel)
        tmp.addArrangedSubview(buildIdentifierLabel)
        return tmp
    }()
    
    private lazy var separator = UIView(backgroundColor: UIColor.cF0F0F0)
    
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
        selectionStyle = .none
        backgroundColor = .white
        contentView.addSubview(iconImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(separator)
    }
    
    /// 设置约束
    private func setupConstraints() {
        iconImageView.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.top.equalTo(10)
            $0.bottom.equalTo(-10)
            $0.width.height.equalTo(35)
        }
        stackView.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(-16)
            $0.top.bottom.equalTo(iconImageView)
        }
        separator.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
