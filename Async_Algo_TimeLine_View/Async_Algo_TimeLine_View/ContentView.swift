//
//  ContentView.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 30/07/2025.
//

import SwiftUI

var sampleInt: [Event] = [
    .init(id: 0, time:  0, color: .red, value: .int(1)),
    .init(id: 1, time:  1, color: .red, value: .int(2)),
    .init(id: 2, time:  2, color: .red, value: .int(3)),
    .init(id: 3, time:  5, color: .red, value: .int(4)),
    .init(id: 4, time:  8, color: .red, value: .int(5)),
]

var sampleString: [Event] = [
    .init(id: 100_0, time:  1.5, value: .string("a")),
    .init(id: 100_1, time:  2.5, value: .string("b")),
    .init(id: 100_2, time:  4.5, value: .string("c")),
    .init(id: 100_3, time:  6.5, value: .string("d")),
    .init(id: 100_4, time:  7.5, value: .string("e")),
]



struct ContentView: View {

    var duration: TimeInterval {
        max(sampleInt.last!.time, sampleString.last!.time)
    }

    var body: some View {
        VStack {
            TimelineView(events: sampleInt, duration: duration)

            TimelineView(events: sampleString, duration: duration)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
