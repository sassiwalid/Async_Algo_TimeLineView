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
            Color.clear
            ZStack(alignment: .leading) {
                ForEach(events) { event in
                    event.value.frame(width: 30, height: 30)
                        .background {
                            Circle().fill(event.color)
                        }
                        .alignmentGuide(.leading) { dim in
                            let relativeTime = event.time / duration
                            return -(proxy.size.width-30) * CGFloat(relativeTime)
                        }
                }
            }
        }
        .frame(height: 50)
    }
}
