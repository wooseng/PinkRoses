//
//  PgyAppBuildListResponse.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/12.
//

import Foundation

/// 蒲公英构建版本列表返回的响应数据
struct PgyAppBuildListResponse: Decodable {
    var list = [PgyAppBuildListModel]()
}
