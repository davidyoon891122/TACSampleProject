//
//  CounterFeatureTests.swift
//  TCATestSampleTests
//
//  Created by Davidyoon on 5/29/24.
//

import XCTest
import ComposableArchitecture

@testable import TCATestSample

@MainActor
final class CounterFeatureTests: XCTestCase {
    
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        await store.send(.descrementButtonTapped) {
            $0.count = 0
        }
    }
    
    func testTimer() async {
        let clock = TestClock()
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        await clock.advance(by: .seconds(1))
        await store.receive(\.timerTick) {
            $0.count = 1
        }
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
    
    func testNumberFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        
        // MARK: - could be success because of we can't predict server response(random)
//        await store.send(.factButtonTapped) {
//            $0.isLoading = true
//        }
//        
//        await store.receive(\.factResponse, timeout: .seconds(1)) {
//            $0.isLoading = false
//            $0.fact = "???"
//        }
        
        
    }
    
}

