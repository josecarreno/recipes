//
//  MapView.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import SwiftUI
import MapKit
import CoreLocation


struct MapView: View {
    let title: String
    let origin: String

    @State private var coordinates: CLLocationCoordinate2D? = nil
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .region(MKCoordinateRegion()))

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.headline)
                .padding()

            Map(position: $cameraPosition) {
                if let coordinates {
                    Marker(origin, coordinate: coordinates)
                        .tint(.red)
                }
            }
        }
        .onAppear {
            Task { @MainActor in
                do {
                    let fetchedCoordinates = try await CLGeocoder().geocodeAddressStringAsync(origin)
                    self.coordinates = fetchedCoordinates
                    cameraPosition = .region(MKCoordinateRegion(
                        center: fetchedCoordinates,
                        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                    ))
                } catch {
                    print(error)
                }
            }
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

#Preview {
    MapView(title: "Paella origin location", origin: "Valencia, Spain")
}
