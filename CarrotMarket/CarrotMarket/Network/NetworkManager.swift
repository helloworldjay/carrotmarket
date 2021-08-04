//
//  NetworkManager.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/19.
//

import Foundation

struct NetworkManager {
    
    let session: URLSessionProtocol
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchModel(with urlRequest: URLRequest, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                return completionHandler(.failure(NetworkError.networkError))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return completionHandler(.failure(NetworkError.networkError))
            }
            
            completionHandler(.success(data))
        }.resume()
    }
    
}
