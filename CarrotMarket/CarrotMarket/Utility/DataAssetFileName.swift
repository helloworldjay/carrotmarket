//
//  DataAssetFileName.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/08/04.
//

import Foundation

enum DataAssetFileName {
    case itemList
    
    var fileName: String {
        switch self {
        case .itemList:
            return "carrotJSON"
        }
    }
}
