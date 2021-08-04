//
//  NetworkService.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/31.
//

import Foundation

struct NetworkService {
    
    private var currentPage: UInt = 1
    private let networkManager: NetworkManagable
    private let dataManager: DataManagable
    private let fetchItemListURL = NetworkURL.test.url
    
    init(networkManager: NetworkManagable, dataManager: DataManagable) {
        self.networkManager = networkManager
        self.dataManager = dataManager
    }
    
    func fetchItemList(completionHandler: @escaping (Result<ItemList, NetworkError>) -> ()) {
        guard let url = URL(string: fetchItemListURL) else { return }
        let request = URLRequest(url: url)
        
        networkManager.fetchModel(with: request) { result in
            switch result {
            case .success(let data):
                guard let itemList: ItemList = dataManager.decodeJSONData(with: data) else {
                    completionHandler(.failure(NetworkError.jsonParsingError))
                    return
                }
                completionHandler(.success(itemList))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
