//
//  TimelineSection.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 02/08/2025.
//


import SwiftUI
import AsyncAlgorithms
import Foundation

struct TimelineSection<Content: View>: View {
    let title: String
    let subtitle: String
    let description: String
    let color: Color
    let icon: String
    let isResult: Bool
    @ViewBuilder let content: Content

    init(
        title: String,
        subtitle: String,
        description: String,
        color: Color,
        icon: String,
        isResult: Bool = false,
        @ViewBuilder content: () -> Content
    ) {

        self.title = title

        self.subtitle = subtitle

        self.description = description

        self.color = color

        self.icon = icon

        self.isResult = isResult

        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundStyle(color.gradient)
                    .font(.title2)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if isResult {
                    Image(systemName: "arrow.down.circle.fill")
                        .foregroundStyle(color.gradient)
                        .font(.title3)
                }
            }

            Text(description)
                .font(.caption)
                .foregroundStyle(.tertiary)
                .frame(maxWidth: .infinity, alignment: .leading)

            content
                .padding(.top, 8)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .strokeBorder(color.opacity(0.2), lineWidth: 1)
        )
    }
}
