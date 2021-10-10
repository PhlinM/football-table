//
//  football_tableUITests.swift
//  football tableUITests
//
//  Created by Flynn Milton on 06/10/2021.
//

import XCTest

class football_tableUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testNoData() throws {
        let noData = app.staticTexts.element
         
        XCTAssert(noData.exists)
        XCTAssertEqual(noData.label, "No data")
    }
    
    func testFetchData() throws {
        let fetchData = app.buttons["Fetch Data Button"]
        
        XCTAssert(fetchData.exists)
    }
}
