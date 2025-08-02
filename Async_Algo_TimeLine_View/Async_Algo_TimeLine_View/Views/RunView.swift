//
//  ContentView.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 30/07/2025.
//

import SwiftUI
import AsyncAlgorithms
import Foundation

var sampleInt: [Event] = [
    .init( time:  0, color: .red, value: .int(1)),
    .init(time:  1, color: .red, value: .int(2)),
    .init(time:  2, color: .red, value: .int(3)),
    .init(time:  5, color: .red, value: .int(4)),
    .init(time:  8, color: .red, value: .int(5)),
]

var sampleString: [Event] = [
    .init(time:  1.5, value: .string("a")),
    .init(time:  2.5, value: .string("b")),
    .init(time:  4.5, value: .string("c")),
    .init(time:  6.5, value: .string("d")),
    .init(time:  7.5, value: .string("e")),
]

func run(algorithm: Algorithm, _ events1: [Event], _ events2: [Event]) async -> [Event] {

    let speedFactor: CGFloat = 10

    let stream1 = await events1.makeStream(speedFactor: speedFactor)

    let stream2 = await events2.makeStream(speedFactor: speedFactor)

    var result = [Event]()

    let startDate = Date()

    var interval: TimeInterval { Date().timeIntervalSince(startDate) * speedFactor }

    switch algorithm {

    case .merge:

        let merged =  merge(
            stream1,stream2
        )

        return await Array(merged)

    case .chain:

        for await event in chain(stream1,stream2) {

            result.append(
                Event(
                    id: event.id,
                    time: interval,
                    color: event.color,
                    value: event.value
                )
            )

        }

        return result

    case .zip:

        for await (e1,e2) in zip(stream1,stream2) {

            result.append(
                Event(
                    id: .pair(e1.id, e2.id),
                    time: interval,
                    color: .blue,
                    value: .pair(e1.value, e2.value)
                )
            )

        }

        return result

    case .combineLatest:

        for await (e1,e2) in combineLatest(stream1,stream2) {

            result.append(
                Event(
                    id: .pair(e1.id, e2.id),
                    time: interval,
                    color: .blue,
                    value: .pair(e1.value, e2.value)
                )
            )

        }

        return result

    }

}

struct RunView: View {
    @State var result: [Event]? = nil
    @State var sample1 = sampleInt
    @State var sample2 = sampleString
    @State private var loading = false
    var algorithm: Algorithm

    var duration: TimeInterval {
        (sample1 + sample2 + (result ?? [])).lazy.map { $0.time }.max() ?? 0
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {

                algorithmHeader

                VStack(spacing: 24) {
                    Text("Input Streams")
                        .font(.title2.bold())
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TimelineSection(
                        title: "Stream 1",
                        subtitle: "Numbers • \(sample1.count) events",
                        description: "Integer values emitted over time",
                        color: .red,
                        icon: "1.circle.fill"
                    ) {
                        TimelineView(
                            events: $sample1,
                            duration: duration
                        )
                    }

                    Spacer()
                        .frame(height: 16)

                    TimelineSection(
                        title: "Stream 2",
                        subtitle: "Letters • \(sample2.count) events",
                        description: "String characters emitted over time",
                        color: .green,
                        icon: "a.circle.fill"
                    ) {
                        TimelineView(
                            events: $sample2,
                            duration: duration
                        )
                    }
                }

                algorithmIndicator

                VStack(spacing: 20) {
                    Text("Result Stream")
                        .font(.title2.bold())
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TimelineSection(
                        title: "Output",
                        subtitle: resultSubtitle,
                        description: algorithm.resultDescription,
                        color: algorithm.color,
                        icon: "arrow.right.circle.fill",
                        isResult: true
                    ) {
                        TimelineView(
                            events: .constant(result ?? []),
                            duration: duration
                        )
                        .drawingGroup()
                        .opacity(loading ? 0.5 : 1)
                        .animation(.default, value: result)
                        .overlay(
                            loadingOverlay,
                            alignment: .center
                        )
                    }
                }

                if let result = result, !result.isEmpty {
                    statisticsSection(result: result)
                }
            }
            .padding(24)
        }
        .task(id: "\(algorithm.rawValue)-\(sample1.hashValue)-\(sample2.hashValue)") {
            loading = true
            result = await run(
                algorithm: algorithm,
                sample1,
                sample2
            )
            loading = false
        }
    }

    private var resultSubtitle: String {
        if loading {
            return "Processing..."
        } else if let result = result {
            return "\(result.count) events • \(duration)s duration"
        } else {
            return "Waiting for execution"
        }
    }

    private var algorithmHeader: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {

                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(algorithm.color.gradient.opacity(0.2))
                        .frame(
                            width: 64,
                            height: 64
                        )

                    Image(systemName: algorithm.icon)
                        .font(.title)
                        .foregroundStyle(algorithm.color.gradient)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(algorithm.rawValue.capitalized)
                        .font(.title.bold())
                        .foregroundStyle(.primary)

                    Text(algorithm.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 6) {
                        Circle()
                            .fill(loading ? .orange : .green)
                            .frame(width: 6, height: 6)

                        Text(loading ? "Processing" : "Ready")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                }

                Spacer()
            }

            Text(algorithm.behaviorDescription)
                .font(.body)
                .foregroundStyle(.secondary)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.top, 4)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .strokeBorder(
                    algorithm.color.opacity(0.3),
                    lineWidth: 1
                )
        )
    }

    private var algorithmIndicator: some View {
        HStack {
            Rectangle()
                .fill(.secondary.opacity(0.3))
                .frame(height: 1)

            VStack(spacing: 8) {
                Image(systemName: algorithm.icon)
                    .font(.title2)
                    .foregroundStyle(algorithm.color.gradient)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(algorithm.color.opacity(0.1))
                            .strokeBorder(algorithm.color.opacity(0.3), lineWidth: 1)
                    )

                Text(algorithm.rawValue.uppercased())
                    .font(.caption2.bold())
                    .foregroundStyle(algorithm.color)
            }

            Rectangle()
                .fill(.secondary.opacity(0.3))
                .frame(height: 1)
        }
        .padding(.vertical, 20)
    }

    private var loadingOverlay: some View {
        Group {
            if loading {
                VStack(spacing: 12) {
                    ProgressView()
                        .scaleEffect(1.2)

                    Text("Executing \(algorithm.rawValue)...")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.ultraThinMaterial)
                )
            }
        }
    }

    private func statisticsSection(result: [Event]) -> some View {
        VStack(spacing: 16) {
            Text("Execution Statistics")
                .font(.title3.bold())
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 16) {
                StatCard(
                    title: "Total Events",
                    value: "\(result.count)",
                    color: .blue,
                    icon: "number.circle"
                )

                StatCard(
                    title: "Duration",
                    value: "\(duration)s",
                    color: .green,
                    icon: "clock"
                )

                StatCard(
                    title: algorithm.statTitle,
                    value: algorithm.statValue(input1: sample1, input2: sample2, result: result),
                    color: algorithm.color,
                    icon: algorithm.icon
                )
            }
        }
        .padding(.top, 8)
    }
}

#Preview {
    RunView(algorithm: .merge)
}
