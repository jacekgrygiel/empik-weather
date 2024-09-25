//
//  MapKitService.swift
//  
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation
import MapKit

struct City {
    let name: String?
    let state: String?
    let country: String?
}

protocol CitySearchServiceType {
    func searchCity(by name: String) async throws -> [City]
}

class CitySearchService: CitySearchServiceType {

    init() {}

    func searchCity(by name: String) async throws -> [City] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = name
        request.resultTypes = .address

        let polandCenter = CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122)
        let span = MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)
        let polandRegion = MKCoordinateRegion(center: polandCenter, span: span)

        request.region = polandRegion

        let search = MKLocalSearch(request: request)
        let response = try await search.start()
        return response.mapItems.map { City(name: $0.placemark.title, state: $0.placemark.administrativeArea, country: $0.placemark.country) }
    }
}
