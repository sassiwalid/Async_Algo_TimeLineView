//
//  ContentView.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 01/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedAlgorithm: Algorithm?

    var body: some View {
        NavigationSplitView {

            List(Algorithm.allCases, selection: $selectedAlgorithm) { algo in
                NavigationLink(algo.rawValue, value: algo)
            }
            .navigationTitle("Algorithms")
        } detail: {
            if let selectedAlgorithm = selectedAlgorithm {
                RunView(algorithm: selectedAlgorithm)
            } else {
                Text("Choose one algorithm")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    ContentView()
}
