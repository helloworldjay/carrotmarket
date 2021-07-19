//
//  NetworkManager.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/19.
//

import Foundation

struct NetworkManager {
    
    private func fetchModel<T: Decodable>(with urlRequest: URLRequest, completionHandler: @escaping (Result<T, APIError>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                return completionHandler(.failure(APIError.networkError))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return completionHandler(.failure(APIError.networkError))
            }
            
            guard let model = try? JSONDecoder().decode(T.self, from: data) else {
                return completionHandler(.failure(APIError.jsonParsingError))
            }
            
            completionHandler(.success(model))
        }.resume()
    }
    
    
    
    
}
