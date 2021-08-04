//
//  NetworkManagable.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/08/04.
//

import Foundation

protocol NetworkManagable {
    func fetchModel(with urlRequest: URLRequest, completionHandler: @escaping (Result<Data, NetworkError>) -> Void)
}
