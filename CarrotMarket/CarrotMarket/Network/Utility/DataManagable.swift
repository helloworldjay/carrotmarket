//
//  DataManagable.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/08/04.
//

import Foundation

protocol DataManagable {
    func decodeJSONData<T: Decodable>(with data: Data) -> T?
}
