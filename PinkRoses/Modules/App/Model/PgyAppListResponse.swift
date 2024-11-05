//
//  PgyAppListResponse.swift
//  PinkRoses
//
//  Created by 詹保成 on 2024/11/5.
//

import Foundation

/// 蒲公英应用列表响应数据的Model
struct PgyAppListResponse: Decodable {
    var count: String
    var page: Int
    var pageCount: Int
    var list: [PgyAppListModel]
}
