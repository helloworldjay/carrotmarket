//
//  CarrotMarketTests.swift
//  CarrotMarketTests
//
//  Created by Seungjin Baek on 2021/07/16.
//

import XCTest
@testable import CarrotMarket

class CarrotMarketTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func fetchDataFromLocalFile() -> Data? {
        guard let dataAsset = NSDataAsset.init(name: "carrotJSON") else { return nil }
        return dataAsset.data
    }
    
    func test_fetchDataFromLocalJSONFile() {
        XCTAssertNotNil(fetchDataFromLocalFile())
    }
    
    func test_decodeFromJSON() {
        let decoder = JSONDecoder()
        guard let dataAsset = fetchDataFromLocalFile(), let decodedData = try? decoder.decode(ItemList.self, from: dataAsset) else { return }
        
        XCTAssertNotNil(decodedData)
    }
}
