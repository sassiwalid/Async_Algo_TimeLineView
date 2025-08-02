//
//  StatusCard.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 01/08/2025.
//

import SwiftUI

struct StatusCard: View {
    @State private var isAnimating = false

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(.green.gradient.opacity(0.2))
                    .frame(width: 32, height: 32)

                Circle()
                    .fill(.green.gradient)
                    .frame(width: 8, height: 8)
                    .scaleEffect(isAnimating ? 1.5 : 1.0)
                    .opacity(isAnimating ? 0.0 : 1.0)
                    .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text("System Ready")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.primary)

                Text("All algorithms available")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
        )
        .onAppear {
            isAnimating = true
        }
    }
}
