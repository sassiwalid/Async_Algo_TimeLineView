//
//  ContentView.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 30/07/2025.
//

import SwiftUI
import AsyncAlgorithms

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
        VStack {

            TimelineView(
                events: $sample1,
                duration: duration
            )

            TimelineView(
                events: $sample2,
                duration: duration
            )

            TimelineView(
                events: .constant(result ?? []),
                duration: duration
            )
            .drawingGroup()
            .opacity(loading ? 0.5 : 1)
            .animation(.default, value: result)

        }
        .padding(20)
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
}

#Preview {
    RunView(algorithm: .merge)
}
