//
//  HomeCollectionViewCell.swift
//  TerminalInstitute
//
//  Created by 詹保成 on 2024/10/26.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    private(set) lazy var iconImageView: UIImageView = {
        let tmp = UIImageView()
        tmp.contentMode = .scaleAspectFit
        tmp.backgroundColor = .cF5F6FA
        tmp.layer.cornerRadius = 6
        tmp.layer.masksToBounds = true
        return tmp
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let tmp = UILabel()
        tmp.text = "测试标题"
        tmp.textColor = UIColor.c3C3C3C
        tmp.font = UIFont.systemFont(ofSize: 14)
        tmp.textAlignment = .center
        return tmp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置子视图
    private func setupSubviews() {
        backgroundColor = .white
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
    }
    
    /// 设置约束
    private func setupConstraints() {
        iconImageView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.bottom.equalTo(nameLabel.snp.top).offset(-10)
            $0.width.equalTo(iconImageView.snp.height)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
