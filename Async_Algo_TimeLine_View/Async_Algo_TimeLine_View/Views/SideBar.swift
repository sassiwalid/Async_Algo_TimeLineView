//
//  SideBar.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 01/08/2025.
//

import SwiftUI

struct Sidebar: View {
    @Binding var selectedAlgorithm: Algorithm?

    var body: some View {
        VStack(spacing: 0) {

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "waveform.path.ecg.rectangle")
                        .font(.title2)
                        .foregroundStyle(.blue.gradient)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Async Algorithms")
                            .font(.title2.bold())
                            .foregroundStyle(.primary)

                        Text("Stream Visualizer")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                Text("Visualize real-time stream operations")
                    .font(.footnote)
                    .foregroundStyle(.tertiary)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 30)

            VStack(spacing: 12) {
                Text("Select Algorithm")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)

                ForEach(Algorithm.allCases, id: \.self) { algorithm in
                    AlgorithmCard(
                        algorithm: algorithm,
                        isSelected: selectedAlgorithm == algorithm
                    ) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedAlgorithm = algorithm
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }

            Spacer()

            StatusCard()
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
        }
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.05, blue: 0.1),
                    Color(red: 0.1, green: 0.05, blue: 0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}



