//
//  WelcomeView.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 01/08/2025.
//


import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            VStack(spacing: 20) {
                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 80))
                    .foregroundStyle(.blue.gradient)

                VStack(spacing: 8) {
                    Text("Welcome to Async Algorithms")
                        .font(.title.bold())
                        .foregroundStyle(.primary)

                    Text("Select an algorithm from the sidebar to begin visualization")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }

            Spacer()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(
            RadialGradient(
                colors: [.blue.opacity(0.1), .clear],
                center: .center,
                startRadius: 0,
                endRadius: 300
            )
        )
    }
}
