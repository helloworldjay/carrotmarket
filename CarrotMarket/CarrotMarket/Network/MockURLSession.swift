//
//  MockURLSession.swift
//  CarrotMarketTests
//
//  Created by Seungjin Baek on 2021/07/29.
//

import UIKit

class MockURLSession: URLSessionProtocol {
    
    var isFailureRequest = false
    var sessionDataTask: MockURLSessionDataTask?
    
    init(makeRequestFail: Bool = false) {
        self.isFailureRequest = makeRequestFail
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let httpResponse = httpResponse(isFailureRequest: isFailureRequest)
        let fetchedData = fetchDataFromLocalFile(dataDescription: DataAssetFileName.itemList.fileName)
        let sessionDataTask = MockURLSessionDataTask()
        
        sessionDataTask.resumeDidCall = {
            if self.isFailureRequest {
                completionHandler(nil, httpResponse, NetworkError.networkError)
            } else {
                completionHandler(fetchedData, httpResponse, nil)
            }
        }
        self.sessionDataTask = sessionDataTask
        return sessionDataTask
    }
    
    private func fetchDataFromLocalFile(dataDescription: String) -> Data? {
        guard let dataAsset = NSDataAsset.init(name: dataDescription) else { return nil }
        return dataAsset.data
    }
    
    func httpResponse(isFailureRequest: Bool) -> HTTPURLResponse? {
        guard let networkURL = URL(string: NetworkURL.test.url) else { return nil }
        if isFailureRequest {
            return HTTPURLResponse(url: networkURL, statusCode: 410, httpVersion: "2", headerFields: nil)
        }
        return HTTPURLResponse(url: networkURL, statusCode: 200, httpVersion: "2", headerFields: nil)
    }
}

enum DataAssetFileName {
    case itemList
    
    var fileName: String {
        switch self {
        case .itemList:
            return "carrotJSON"
        }
    }
}
