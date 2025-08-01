//
//  AlgorithmCard.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 01/08/2025.
//

import SwiftUI

struct AlgorithmCard: View {
    let algorithm: Algorithm
    let isSelected: Bool
    let action: () -> Void

    private var algorithmInfo: (icon: String, title: String, description: String, color: Color) {
        return switch algorithm {
        case .merge:

            (
                "arrow.triangle.merge",
                "Merge",
                "Combine streams by timestamp",
                .blue
            )

        case .chain:

            (
                "link",
                "Chain",
                "Sequential stream execution",
                .purple
            )

        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {

                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(algorithmInfo.color.gradient.opacity(0.2))
                        .frame(width: 50, height: 50)

                    Image(systemName: algorithmInfo.icon)
                        .font(.title2)
                        .foregroundStyle(algorithmInfo.color.gradient)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(algorithmInfo.title)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text(algorithmInfo.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(algorithmInfo.color.gradient)
                        .font(.title3)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? algorithmInfo.color.opacity(0.1) : Color.clear)
                    .strokeBorder(
                        isSelected ? algorithmInfo.color.opacity(0.3) : Color.clear,
                        lineWidth: 1
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}
