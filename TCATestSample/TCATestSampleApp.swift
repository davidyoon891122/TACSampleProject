//
//  TCATestSampleApp.swift
//  TCATestSample
//
//  Created by Davidyoon on 5/28/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCATestSampleApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(
                store: TCATestSampleApp.store
            )
        }
    }
}
