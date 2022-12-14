//
//  Case_Study_Clean_ArchitectureUITests.swift
//  Case Study Clean ArchitectureUITests
//
//  Created by Kemal Sanli on 25.11.2022.
//

import XCTest
@testable import Case_Study_Clean_Architecture

final class Case_Study_Clean_ArchitectureUITests: XCTestCase {
    
    //Unit test yazmayı çok istedim fakat garip bir şekilde bu projede "symbols" hataları verdi ve bulduğum yollar ile bir çözüme ulaşamadım.
    
    func testBlabla() {
        let abcd = MainPresenter()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
