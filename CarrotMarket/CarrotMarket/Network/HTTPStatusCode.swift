//
//  HTTPStatusCode.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/08/04.
//

import Foundation

enum HTTPStatusCode {
    case ok, gone
    
    var code: Int {
        switch self {
        case .ok:
            return 200
        case .gone:
            return 410
        }
    }
}
