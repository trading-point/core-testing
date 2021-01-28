//
//  SupportButtonTests.swift
//  CoreTesting_Tests
//
//  Created by Georgios Sotiropoulos on 29/5/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import CoreTesting

class SupportButtonTests: XCTestCase {
    func testSupportButton() {
        let button = SupportButton()
        SnapshotTestConfig.View.free { config in            
            assertImageSnapshot(matching: button, config: config)
        }
    }
}
