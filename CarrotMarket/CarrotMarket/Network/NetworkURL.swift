//
//  NetworkURL.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/29.
//

import Foundation

enum NetworkURL {
    case test
    
    var url: String {
        switch self {
        case .test:
            return "https://www.daangn.com/"
        }
    }
}
