//
//  Error.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/19.
//

import Foundation

enum APIError: Error {
    case jsonParsingError, networkError, invalidAddressError
}
