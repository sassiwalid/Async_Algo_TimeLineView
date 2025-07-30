//
//  Async_Algo_TimeLine_ViewUITestsLaunchTests.swift
//  Async_Algo_TimeLine_ViewUITests
//
//  Created by Walid SASSI on 30/07/2025.
//

import XCTest

final class Async_Algo_TimeLine_ViewUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
