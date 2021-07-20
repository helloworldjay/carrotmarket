//
//  ItemList.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/19.
//

import Foundation

struct ItemList: Decodable {
    var page: UInt
    var itemList: [ListedItem]

    enum CodingKeys: String, CodingKey {
        case page
        case itemList = "items"
    }
}

struct ListedItem: Decodable {
    var id: UInt
    var title: String
    var location: String
    var date: Date
    var price: UInt
    var chat: UInt?
    var heart: UInt?
    var thumbnails: [String]
}


