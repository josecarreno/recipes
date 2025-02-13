//
//  MapModel.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import SwiftUI
import CoreLocation
import MapKit

@MainActor
@Observable
class MapModel {
    var coordinates: CLLocationCoordinate2D?
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .region(MKCoordinateRegion()))

    func fetchCoordinates(origin: String) async {
        do {
            let fetchedCoordinates = try await CLGeocoder().geocodeAddressStringAsync(origin)
            self.coordinates = fetchedCoordinates
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: fetchedCoordinates,
                    span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                )
            )
        } catch {
            print(error)
        }
    }
}

enum GeocodingError: Error {
    case noPlaceMarkersFound
    case geocodingFailed(Error)
}

extension CLGeocoder {
    func geocodeAddressStringAsync(_ addressString: String) async throws -> CLLocationCoordinate2D {
        return try await withCheckedThrowingContinuation { continuation in
            geocodeAddressString(addressString) { placeMarks, error in
                if let error = error {
                    continuation.resume(throwing: GeocodingError.geocodingFailed(error))
                    return
                }

                guard let coordinate = placeMarks?.first?.location?.coordinate else {
                    continuation.resume(throwing: GeocodingError.noPlaceMarkersFound)
                    return
                }

                continuation.resume(returning: coordinate)
            }
        }
    }
}
