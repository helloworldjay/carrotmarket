//
//  NetworkError.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/19.
//

import Foundation

enum NetworkError: Error {
    case jsonParsingError, networkError, invalidAddressError
}
