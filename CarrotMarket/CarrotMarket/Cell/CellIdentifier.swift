//
//  CellIdentifier.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/08/03.
//

import Foundation

enum CellIdentifier {
    case itemListCell
    
    var identifier: String {
        switch self {
        case .itemListCell:
            return "homeTableViewCell"
        }
    }
}
