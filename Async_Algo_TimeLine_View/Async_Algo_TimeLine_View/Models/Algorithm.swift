//
//  Algorithm.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 01/08/2025.
//

import SwiftUI

enum Algorithm: String, CaseIterable, Identifiable {
    case merge
    case chain
    case zip
    case combineLatest

    var id: Self {
        self
    }
}

extension Algorithm {
    var icon: String {
        return switch self {
        case .merge: "arrow.triangle.merge"
        case .chain: "link"
        case .zip: "arrow.up.arrow.down.circle"
        case .combineLatest: "arrow.2.circlepath"
        }
    }

    var color: Color {
        return switch self {
        case .merge: .blue
        case .chain: .purple
        case .zip: .red
        case .combineLatest: .brown
        }
    }

    var description: String {
        return switch self {
        case .merge:
            "Time-based merging of multiple async streams"
        case .chain:
            "Sequential execution of async streams"
        case .zip:
            "Synchronous pairing of events from both streams"
        case .combineLatest:
            "Continuous combination of most recent values"
        }
    }

    var behaviorDescription: String {
        return switch self {
        case .merge:
            "Events from both streams are combined while preserving their original timestamps, creating a naturally interleaved result."
        case .chain:
            "Stream 1 executes completely before Stream 2 begins, creating a sequential concatenation of events."
        case .zip:
            "Waits for both streams to emit events, then pairs them together. Stops when either stream completes."
        case .combineLatest:
            "Combines the latest value from each stream whenever any stream emits, maintaining current state."
        }
    }

    var resultDescription: String {
        return switch self {
        case .merge:
            "Interleaved events maintaining temporal order"
        case .chain:
            "All events from stream 1, then all from stream 2"
        case .zip:
            "Paired tuples of synchronized events"
        case .combineLatest:
            "Latest combinations updated on each emission"
        }
    }

    var statTitle: String {
        return switch self {
        case .merge: "Interleaved"
        case .chain: "Sequential"
        case .zip: "Pairs"
        case .combineLatest: "Updates"
        }
    }

    func statValue(input1: [Event], input2: [Event], result: [Event]) -> String {
        switch self {
        case .merge:
            guard result.count > 1 else { return "0%" }
            var switches = 0
            var lastColor: Color?
            for event in result {
                if let last = lastColor, last != event.color {
                    switches += 1
                }
                lastColor = event.color
            }
            return "\(Int((Double(switches) / Double(result.count - 1)) * 100))%"

        case .chain:
            let stream1Count = input1.count
            var correctOrder = 0
            for (index, event) in result.enumerated() {
                if index < stream1Count && event.color == .red {
                    correctOrder += 1
                } else if index >= stream1Count && event.color == .green {
                    correctOrder += 1
                }
            }
            return result.isEmpty ? "0%" : "\(Int((Double(correctOrder) / Double(result.count)) * 100))%"

        case .zip:
            return "\(min(input1.count, input2.count))"

        case .combineLatest:
            return "\(result.count)"
        }
    }
}

