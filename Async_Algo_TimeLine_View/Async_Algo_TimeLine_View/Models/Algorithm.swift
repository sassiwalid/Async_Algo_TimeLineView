//
//  Algorithm.swift
//  Async_Algo_TimeLine_View
//
//  Created by Walid SASSI on 01/08/2025.
//

enum Algorithm: String, CaseIterable, Identifiable {
    case merge
    case chain
    case zip
    case combineLatest

    var id: Self {
        self
    }
}

