//
//  UIView+Extension.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/5.
//

import UIKit

extension UIView {
    convenience init(backgroundColor: UIColor?) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
}
