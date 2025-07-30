//
//  TimelineView.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 30/07/2025.
//

import SwiftUI

struct TimelineView: View {
    @Binding var events: [Event]
    var duration: TimeInterval

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.secondary)
                    .frame(height: 1)

                ForEach(0..<Int(duration.rounded(.up))) { tick in
                    Rectangle()
                        .frame(width: 1)
                        .foregroundStyle(.secondary)
                        .allowsHitTesting(false)
                        .alignmentGuide(.leading) { _ in
                            let relativeTime = CGFloat(tick) / duration

                            return -(proxy.size.width-30) * CGFloat(relativeTime)
                        }

                }
                .offset(x: 15)

                ForEach($events) { $event in
                    EventNode(
                        event: $event,
                        secondsPerPoints: duration / (proxy.size.width - 30)
                    )
                    .help("Time: \(String(format: "%.1f", event.time))s")
                    .alignmentGuide(.leading) { _ in
                        let relativeTime = event.time / duration

                        return -(proxy.size.width-30) * CGFloat(relativeTime)
                    }

                }
            }
        }
        .frame(height: 50)
    }
}
