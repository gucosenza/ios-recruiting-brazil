//
//  MovsUITests.swift
//  MovsUITests
//
//  Created by Gustavo Evangelista on 03/06/2019.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import XCTest

class MovsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_filterDontHaveMovieToShow() {
        let app = XCUIApplication()
        let search = app.searchFields["Search Movie"]
        XCTAssertTrue(search.exists)
        search.tap()
        search.typeText("xyz")
        let message = app.staticTexts["Não existe filme para ser exibido"]
        XCTAssertTrue(message.exists)
    }

}
