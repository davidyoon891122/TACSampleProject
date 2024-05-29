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
//    static let store = Store(initialState: AppFeature.State()) {
//        AppFeature()
//            ._printChanges()
//    }
    
    static let store = Store(initialState: ContactsFeature.State()) {
        ContactsFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
//            AppView(store: TCATestSampleApp.store)
            ContactsView(store: TCATestSampleApp.store)
        }
    }
}
