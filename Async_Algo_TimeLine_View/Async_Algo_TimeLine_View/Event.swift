//
//  Event.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 30/07/2025.
//

import Foundation
import SwiftUI

enum Value: Hashable, Sendable {
    case int(Int)

    case string(String)

    indirect case pair(Value, Value)
}

extension Value: View {

    var body: some View {
        switch self {

        case .int(let intValue): Text("\(intValue)")

        case .string(let stringValue): Text(stringValue)

        case let .pair(left, right):
            HStack(spacing:0) {
                left
                right
            }

        }
    }
}

struct Event: Identifiable, Hashable, Sendable, Comparable {

    var id: EventID = .single(UUID())

    var time: TimeInterval

    var color: Color = .green

    var value: Value

    static func < (lhs: Event, rhs: Event) -> Bool {
        lhs.time < rhs.time
    }

}

indirect enum EventID: Hashable, Sendable {

    case single(UUID)

    case pair(EventID, EventID)
}

