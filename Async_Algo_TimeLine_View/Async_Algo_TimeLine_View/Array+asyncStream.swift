//
//  Array+asyncStream.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 30/07/2025.
//

import Foundation

extension Array where Element  == Event {
    @MainActor
    func makeStream(speedFactor: Double) -> AsyncStream<Event> {
        AsyncStream { continuation in

            let events = sorted()

            for event in events {
                Timer.scheduledTimer(withTimeInterval: event.time / speedFactor, repeats: false) { _ in

                    continuation.yield(event)

                    if event == events.last {
                        continuation.finish()
                    }
                }
            }
        }
    }
}
