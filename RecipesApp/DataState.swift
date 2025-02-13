//
//  DataState.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import Foundation

enum DataState<T: Sendable> {
    case loading
    case error(message: String)
    case loaded(data: T)

    /// When in `loaded` state, returns the data associated value - otherwise returns nil.
    var value: T? {
        guard case .loaded(let data) = self else {
            return nil
        }

        return data
    }
}
