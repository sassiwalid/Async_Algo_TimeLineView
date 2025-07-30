//
//  Array+asyncStream.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 30/07/2025.
//

import Foundation

extension Array where Element  == Event {
    func makeStream() -> AsyncStream<Event> {
        AsyncStream { continuation in

            for event in self {
                Timer.scheduledTimer(withTimeInterval: event.time, repeats: false) { _ in
                    continuation.yield(event)

                    if event == last {
                        continuation.finish()
                    }
                }
            }
        }
    }
}
