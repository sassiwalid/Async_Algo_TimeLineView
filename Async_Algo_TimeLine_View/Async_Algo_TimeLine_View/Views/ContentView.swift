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

            Sidebar(selectedAlgorithm: $selectedAlgorithm)
        } detail: {
            if let selectedAlgorithm = selectedAlgorithm {
                RunView(algorithm: selectedAlgorithm)

            } else {
                WelcomeView()
            }
        }
        .preferredColorScheme(.dark)
        .navigationTitle("")

    }
}



#Preview {
    ContentView()
}
