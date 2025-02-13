//
//  OriginMapView.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import SwiftUI
import MapKit

struct OriginMapView: View {
    let title: String
    let origin: String

    @Environment(MapModel.self) var model

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.headline)
                .padding()

            @Bindable var model = model

            Map(position: $model.cameraPosition) {
                if let coordinates = model.coordinates {
                    Marker(origin, coordinate: coordinates)
                        .tint(.red)
                }
            }
        }
        .onAppear {
            Task {
                await model.fetchCoordinates(origin: origin)
            }
        }
    }
}

#Preview {
    OriginMapView(title: "Paella origin location", origin: "Valencia, Spain")
        .environment(MapModel())
}
