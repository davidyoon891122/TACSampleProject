//
//  CounterFeature.swift
//  TCATestSample
//
//  Created by Davidyoon on 5/28/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct CounterFeature {
    @ObservableState
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
    }
    
    enum Action {
        case descrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped
        case factResponse(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .descrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared
                        .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    await send(.factResponse(fact))
                }
            case .factResponse(let fact):
                state.fact = fact
                state.isLoading = false
                return .none
            }
        }
    }
}

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .clipShape(.rect(cornerRadius: 10))
            HStack {
                Button("-") {
                    store.send(.descrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(.black.opacity(0.1))
                .clipShape(.rect(cornerRadius: 10))
                
                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(.black.opacity(0.1))
                .clipShape(.rect(cornerRadius: 10))
            }
            Button("Fact") {
                store.send(.factButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(.black.opacity(0.1))
            .clipShape(.rect(cornerRadius: 10))
            
            if store.isLoading {
                ProgressView()
            } else if let fact = store.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}

#Preview {
    CounterView(store: Store(initialState: CounterFeature.State()) {
        CounterFeature()
    })
}
