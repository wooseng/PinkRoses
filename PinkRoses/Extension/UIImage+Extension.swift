//
//  UIImage+Extension.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/3.
//

import QMUIKit

extension UIImage {
    func resize(width: CGFloat, height: CGFloat, resizingMode: QMUIImageResizingMode = .scaleAspectFit) -> UIImage? {
        let size = CGSize(width: width, height: height)
        return qmui_imageResized(inLimitedSize: size, resizingMode: resizingMode)
    }
}
