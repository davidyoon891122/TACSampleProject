//
//  AppFeatureTests.swift
//  TCATestSampleTests
//
//  Created by Davidyoon on 5/29/24.
//

import XCTest
import ComposableArchitecture

@testable import TCATestSample

@MainActor
final class AppFeatureTests: XCTestCase {
    
    func testIncrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        await store.send(\.tab1.incrementButtonTapped) {
            $0.tab1.count = 1
        }
    }
    
}
