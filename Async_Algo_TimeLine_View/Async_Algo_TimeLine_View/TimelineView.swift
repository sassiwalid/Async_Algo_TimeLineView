//
//  TimelineView.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 30/07/2025.
//

import SwiftUI

struct TimelineView: View {
    var events: [Event]
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
                        .alignmentGuide(.leading) { _ in
                            let relativeTime = CGFloat(tick) / duration

                            return -(proxy.size.width-30) * CGFloat(relativeTime)
                        }

                }
                .offset(x: 15)

                ForEach(events) { event in
                    event.value.frame(width: 30, height: 30)
                        .background {
                            Circle().fill(event.color)
                        }
                        .alignmentGuide(.leading) { _ in
                            let relativeTime = event.time / duration

                            return -(proxy.size.width-30) * CGFloat(relativeTime)
                        }
                }
            }
        }
        .frame(height: 30)
    }
}
