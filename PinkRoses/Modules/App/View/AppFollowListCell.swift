//
//  AppFollowListCell.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/10.
//

import UIKit

/// 用户关注应用的列表页面使用的`cell`
class AppFollowListCell: UITableViewCell {
    var model: PgyAppRealm? {
        didSet {
            appNameLabel.text = model?.appName
            appIdentifierLabel.text = model?.appIdentifier
            appTypeImageView.image = model?.appTypeLogo
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
    
    private lazy var appIdentifierLabel: UILabel = {
        let tmp = UILabel()
        tmp.textColor = .c666666
        tmp.font = .systemFont(ofSize: 12)
        return tmp
    }()
    
    /// 应用类型图标
    private lazy var appTypeImageView: UIImageView = {
        let tmp = UIImageView()
        tmp.contentMode = .scaleAspectFit
        return tmp
    }()
    
    /// 右箭头视图
    private lazy var rightArrowImageView: UIImageView = {
        let tmp = UIImageView()
        tmp.image = R.image.arrow_right()
        tmp.contentMode = .scaleAspectFit
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
        contentView.addSubview(appNameLabel)
        contentView.addSubview(appIdentifierLabel)
        contentView.addSubview(appTypeImageView)
        contentView.addSubview(rightArrowImageView)
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
        appTypeImageView.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(appNameLabel)
            $0.width.height.equalTo(16)
        }
        appNameLabel.snp.makeConstraints {
            $0.leading.equalTo(appTypeImageView.snp.trailing).offset(5)
            $0.trailing.lessThanOrEqualTo(rightArrowImageView.snp.leading).offset(-10)
            $0.top.equalTo(iconImageView)
        }
        appIdentifierLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
            $0.trailing.lessThanOrEqualTo(rightArrowImageView.snp.leading).offset(-10)
            $0.bottom.equalTo(iconImageView)
        }
        rightArrowImageView.snp.makeConstraints {
            $0.trailing.equalTo(-16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }
        separator.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
}
