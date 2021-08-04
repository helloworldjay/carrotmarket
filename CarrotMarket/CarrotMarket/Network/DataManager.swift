//
//  DataManager.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/31.
//

import Foundation

struct DataManager: DataManagable {
    
    func decodeJSONData<T: Decodable>(with data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        guard let model = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        return model
    }
    
}
