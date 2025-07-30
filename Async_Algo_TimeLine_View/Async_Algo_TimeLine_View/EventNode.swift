//
//  EventNode.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 30/07/2025.
//

import SwiftUI

struct EventNode: View {
    @Binding var event: Event
    @GestureState var offset: CGFloat = 0
    var secondsPerPoints: CGFloat

    var body: some View {
        event.value.frame(width: 30, height: 30)
            .background {
                Circle().fill(event.color)
            }
            .offset(x: offset)
            .gesture(gesture)
    }

    private var gesture: some Gesture {
        DragGesture()
            .updating($offset) { value, state, transaction in
                state = value.translation.width
            }
            .onEnded { value in
                event.time += secondsPerPoints * value.translation.width
            }
    }
}
