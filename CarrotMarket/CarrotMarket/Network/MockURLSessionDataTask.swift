//
//  MockURLSessionDataTask.swift
//  CarrotMarketTests
//
//  Created by Seungjin Baek on 2021/07/29.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    var resumeDidCall = { }
    
    override func resume() {
        resumeDidCall()
    }
}
