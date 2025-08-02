//
//  StatCard.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 02/08/2025.
//


import SwiftUI
import AsyncAlgorithms
import Foundation

struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    let icon: String

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundStyle(color)

                Text(title)
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)
            }

            Text(value)
                .font(.title3.bold())
                .foregroundStyle(color)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .strokeBorder(color.opacity(0.3), lineWidth: 1)
        )
    }
}