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
}
