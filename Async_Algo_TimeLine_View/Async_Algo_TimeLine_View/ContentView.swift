//
//  ContentView.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 01/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(Algorithm.allCases) { algo in
                NavigationLink(algo.rawValue) {
                    RunView(algorithm: algo)
                }
            }
            .navigationTitle("Algorithms")
        }
    }
}
