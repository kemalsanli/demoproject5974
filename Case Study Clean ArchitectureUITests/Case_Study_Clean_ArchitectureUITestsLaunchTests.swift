//
//  Case_Study_Clean_ArchitectureUITestsLaunchTests.swift
//  Case Study Clean ArchitectureUITests
//
//  Created by Kemal Sanli on 25.11.2022.
//

import XCTest

final class Case_Study_Clean_ArchitectureUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

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