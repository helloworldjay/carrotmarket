//
//  CarrotMarketTests.swift
//  CarrotMarketTests
//
//  Created by Seungjin Baek on 2021/07/16.
//

import XCTest
@testable import CarrotMarket

class CarrotMarketTests: XCTestCase {
    
    let mockURLSession = MockURLSession()
    let dataManager = DataManager()
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func test_테스트_URL_생성_확인() {
        XCTAssertNotNil(mockURLSession.httpResponse(isFailureRequest: false))
    }
    
    func test_httpResponse_메소드_결과_확인() {
        let successResponse = mockURLSession.httpResponse(isFailureRequest: false)
        let failureResponse = mockURLSession.httpResponse(isFailureRequest: true)
        
        XCTAssertEqual(successResponse?.statusCode, 200)
        XCTAssertEqual(failureResponse?.statusCode, 410)
    }
    
    func test_decodeJSONData_작동_확인() {
        let data = NSDataAsset.init(name: DataAssetFileName.itemList.fileName)!.data
        let result: ItemList? = dataManager.decodeJSONData(with: data)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.page, 1)
    }
    
}
