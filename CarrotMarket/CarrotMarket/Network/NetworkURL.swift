//
//  NetworkURL.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/29.
//

import Foundation

enum NetworkURL {
    case home
    
    var url: String {
        switch self {
        case .home:
            return "Home URL Example"
        }
    }
}
